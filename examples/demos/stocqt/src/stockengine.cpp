// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause
#include "stockengine.h"

StockEngine::StockEngine()
{
    m_proxyModel.setParent(this);
    m_proxyModel.setSourceModel(&m_stockListModel);
    m_proxyModel.setFilterRole(StockListModel::filterRole);
    m_proxyModel.setFilterCaseSensitivity(Qt::CaseInsensitive);
    m_stockModel = m_stockListModel.getStockModel(0);
    m_liveDataTimer.setInterval(1000 * 60); // update every minute
    connect(&m_liveDataTimer, &QTimer::timeout, this, &StockEngine::updateStockListModel);
}

StockListModel *StockEngine::getStockListModel()
{
    return &m_stockListModel;
}
FavoritesModel *StockEngine::getFavoritesModel()
{
    return &m_favoritesModel;
}

StockModel *StockEngine::getStockModel()
{
    return m_stockModel;
}

QSortFilterProxyModel *StockEngine::filterModel()
{
    return &m_proxyModel;
}

void StockEngine::testApiKey(QString apiKey)
{
    m_apiHandler.testApiKey(apiKey, [this, apiKey](bool valid) {
        if (valid) {
            m_apiHandler.setApiKey(apiKey);
            emit onApiKeyTested(true);
        } else {
            emit onApiKeyTested(false);
        }
    });
}

void StockEngine::setUseLiveData(bool useLiveData)
{
    if (useLiveData != m_apiHandler.getUseLiveData()) {
        m_apiHandler.setUseLiveData(useLiveData);
        m_stockListModel.resetQuotes();
        updateStockListModel();
        if (useLiveData)
            m_liveDataTimer.start();
        else
            m_liveDataTimer.stop();
    }
}

void StockEngine::updateStockListModel()
{
    QString symbols;
    for (int i = 0; i < m_stockListModel.rowCount(); ++i) {
        auto qIndex = m_stockListModel.index(i);
        symbols.append(m_stockListModel.data(qIndex, StockListModel::idRole).value<QString>() + ",");
    }
    symbols.removeLast(); // remove last comma
    m_apiHandler.getStockQuote(symbols, [this](QList<QuoteData *> data) {
        m_stockListModel.updateDetails(data);
    });
}

void StockEngine::updateStockView(const QString stockId)
{
    disconnect(m_stockModel);
    int index = 0;
    for (int i = 0; i < m_stockListModel.rowCount(); i++) {
        auto qIndex = m_stockListModel.index(i);
        if (m_stockListModel.data(qIndex, StockListModel::idRole).value<QString>() == stockId)
            index = i;
    }
    StockModel *stock;
    stock = m_stockListModel.getStockModel(index);
    m_stockModel = stock;
    connect(m_stockModel, &StockModel::historyDataReady, this, &StockEngine::onStockModelChanged);
    connect(m_stockModel, &StockModel::quoteDataReady, this, &StockEngine::onStockModelChanged);

    if (stock->historyCount() == 0 || stock->getDataIsLive() != m_apiHandler.getUseLiveData()) {
        updateStockModelHistory(stock->getStockId());
    } else {
        emit onStockModelChanged();
    }
}

void StockEngine::addFavorite(const QString stockId)
{
    for (int i = 0; i < m_stockListModel.rowCount(); i++) {
        auto index = m_stockListModel.index(i);
        if (m_stockListModel.data(index, StockListModel::idRole).value<QString>() == stockId) {
            StockModel *stock = m_stockListModel.getStockModel(i);
            if (m_favoritesModel.getCount() < 5) {
                m_stockListModel.addFavorite(stockId);
                m_favoritesModel.addFavorite(stock);
                if (stock->historyCount() == 0) {
                    m_apiHandler.getStockHistory(stockId,
                                                 [this, stock](QList<HistoryData *> dataList) {
                                                     stock->updateHistory(dataList);
                                                 });
                }
                emit onFavoritesChanged(m_favoritesModel.getCount() == 5);
            } else {
                qDebug() << "Favorites are full";
            }
        }
    }
}

void StockEngine::removeFavorite(const QString stockId)
{
    m_stockListModel.removeFavorite(stockId);
    m_favoritesModel.removeFavorite(stockId);
    emit onFavoritesChanged(false);
}

void StockEngine::updateFavorites()
{
    auto favorites = m_favoritesModel.getFavorites();
    for (int i = 0; i < favorites.size(); ++i) {
        StockModel *stock = favorites.at(i);
        if (stock->historyCount() == 0) {
            m_apiHandler.getStockHistory(stock->getStockId(),
                                         [this, stock](QList<HistoryData *> dataList) {
                                             stock->updateHistory(dataList);
                                         });
        }
    }
}

void StockEngine::updateStockModelHistory(const QString stockId)
{
    m_apiHandler.getStockHistory(stockId, [this](QList<HistoryData *> dataList) {
        m_stockModel->updateHistory(dataList);
    });
    m_stockModel->setDataIsLive(m_apiHandler.getUseLiveData());
}

void StockEngine::updateStockModelQuote()
{
    m_apiHandler.getStockQuote(getCurrentStockId(), [this](QList<QuoteData *> data) {
        m_stockModel->appendQuote(data.at(0));
    });
    m_stockModel->setDataIsLive(m_apiHandler.getUseLiveData());
}

QString StockEngine::getCurrentStockId()
{
    return m_stockModel->getStockId();
}

QString StockEngine::getCurrentName()
{
    return m_stockModel->getName();
}

bool StockEngine::isFavorite(QString stockId)
{
    bool favorite = false;
    for (int i = 0; i < m_favoritesModel.getCount(); ++i) {
        if (m_favoritesModel.getAtIndex(i)->getStockId() == stockId)
            favorite = true;
    }
    return favorite;
}

bool StockEngine::getUseLiveData()
{
    return m_apiHandler.getUseLiveData();
}
