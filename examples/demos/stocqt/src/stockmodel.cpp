// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause
#include "stockmodel.h"
#include <QDateTime>

StockModel::StockModel(QString stockId, QString name)
    : m_stockId(stockId)
    , m_name(name){};

StockModel::~StockModel()
{
    while (!m_historyDataList.isEmpty()) {
        delete m_historyDataList.takeFirst();
    }
    while (!m_quoteDataList.isEmpty()) {
        delete m_quoteDataList.takeFirst();
    }
};
void StockModel::addData(HistoryData *data)
{
    m_historyDataList.append(data);
    emit historyDataReady();
}

void StockModel::updateHistory(QList<HistoryData *> data)
{
    while (!m_historyDataList.isEmpty())
        delete m_historyDataList.takeFirst();
    m_historyDataList = data;
    emit historyDataReady();
}

void StockModel::appendQuote(QuoteData *data)
{
    // check if already exists
    if (!m_quoteDataList.isEmpty()) {
        const QuoteData *latest = m_quoteDataList.at(0);
        if (latest->time == data->time) {
            return;
        }
    }
    m_quoteDataList.insert(0, data);
    emit quoteDataReady();
}

void StockModel::resetQuote()
{
    while (!m_quoteDataList.isEmpty())
        delete m_quoteDataList.takeFirst();
    emit quoteDataReady();
}

void StockModel::setDataIsLive(bool live)
{
    m_dataIsLive = live;
}

int StockModel::historyCount()
{
    return m_historyDataList.count();
}

int StockModel::quoteCount()
{
    return m_quoteDataList.count();
}

QString StockModel::getStockId()
{
    return m_stockId;
}
QString StockModel::getName()
{
    return m_name;
}

float StockModel::getPrice(int index)
{
    if (m_quoteDataList.isEmpty())
        return 0;
    return m_quoteDataList.at(index)->price;
}

float StockModel::getChange(int index)
{
    if (m_quoteDataList.isEmpty())
        return 0;
    return m_quoteDataList.at(index)->change;
}
float StockModel::getChangePercentage(int index)
{
    if (m_quoteDataList.isEmpty())
        return 0;
    return m_quoteDataList.at(index)->changePercentage;
}

int StockModel::getOpen(int index)
{
    if (m_historyDataList.isEmpty())
        return 0;
    return m_historyDataList.at(index)->open;
}
int StockModel::getClose(int index)
{
    if (m_historyDataList.isEmpty())
        return 0;
    return m_historyDataList.at(index)->close;
}
int StockModel::getHigh(int index)
{
    if (m_historyDataList.isEmpty())
        return 0;
    return m_historyDataList.at(index)->high;
}
int StockModel::getLow(int index)
{
    if (m_historyDataList.isEmpty())
        return 0;
    return m_historyDataList.at(index)->low;
}
int StockModel::getVolume(int index)
{
    if (m_historyDataList.isEmpty())
        return 0;
    return m_historyDataList.at(index)->volume;
}

int StockModel::getAvgVolume()
{
    long long totalVolume = 0;
    for (int i = 0; i < historyCount(); ++i) {
        totalVolume += getVolume(i);
    }
    if (historyCount() > 0)
        return totalVolume / historyCount();
    else
        return 0;
}

int StockModel::daysFromNow(int index)
{
    if (m_historyDataList.isEmpty())
        return 0;
    return m_historyDataList.at(index)->time.daysTo(QDateTime::currentDateTime());
}

long long StockModel::getHistoryDate(int index, bool milliseconds)
{
    if (m_historyDataList.isEmpty())
        return 0;
    if (milliseconds)
        return m_historyDataList.at(index)->time.toMSecsSinceEpoch();
    else
        return m_historyDataList.at(index)->time.toSecsSinceEpoch();
}

long long StockModel::getQuoteTime(int index, bool milliseconds)
{
    if (m_quoteDataList.isEmpty() || index >= m_quoteDataList.count())
        return 0;
    if (milliseconds)
        return m_quoteDataList.at(index)->time.toMSecsSinceEpoch();
    else
        return m_quoteDataList.at(index)->time.toSecsSinceEpoch();
}
int StockModel::indexOf(QDateTime date)
{
    if (m_historyDataList.empty())
        return -1;
    auto today = date.addMSecs(-QTime::currentTime().msecsSinceStartOfDay());
    bool afterDate = true;
    int index = 0;
    while (afterDate) {
        if (index == m_historyDataList.size() - 1)
            afterDate = false;
        else if (today.secsTo(m_historyDataList.at(index)->time) < 0) {
            afterDate = false;
        } else
            index++;
    }
    return index;
}

bool StockModel::getDataIsLive()
{
    return m_dataIsLive;
}
