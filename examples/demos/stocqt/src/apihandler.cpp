// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause
#include "apihandler.h"

#include <QDateTime>
#include <QDebug>
#include <QFile>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>

ApiHandler::ApiHandler() {}

void ApiHandler::testApiKey(QString apiKey, std::function<void(bool)> onComplete)
{
    auto url = QString("https://financialmodelingprep.com/api/v3/quote-short/AAPL?apikey=")
               + apiKey;

    m_getRequest.setUrl(QUrl(url));
    auto reply = m_accessManager.get(m_getRequest);

    connect(reply, &QNetworkReply::finished, [reply, onComplete]() {
        auto replyStr = QString(reply->readAll());
        if (reply->error() == QNetworkReply::NoError && !replyStr.contains("Error"))
            onComplete(true);
        else
            onComplete(false);

        reply->deleteLater();
    });
}
void ApiHandler::getStockQuote(const QString symbols,
                               std::function<void(QList<QuoteData *>)> onComplete)
{
    QString url;
    QStringList symbolList = symbols.split(u',');
    if (m_useLiveData) {
        url = QString("https://financialmodelingprep.com/api/v3/quote/") + symbols
              + QString("?apikey=") + m_apiKey;

        m_getRequest.setUrl(QUrl(url));
        auto reply = m_accessManager.get(m_getRequest);
        connect(reply, &QNetworkReply::finished, [reply, symbolList, onComplete]() {
            QJsonParseError error;
            auto replyStr = QString(reply->readAll());
            auto doc = QJsonDocument::fromJson(replyStr.toUtf8(), &error);

            if (error.error != QJsonParseError::NoError) {
                qDebug() << "Error when parsing json: " << error.errorString();
                return;
            }
            if (reply->error() != QNetworkReply::NoError) {
                qDebug() << "Network error" << reply->errorString() << reply->readAll();
            }

            auto array = doc.array();
            QList<QuoteData *> dataList;

            for (int i = 0; i < symbolList.size(); ++i) {
                for (int j = 0; j < array.size(); ++j) {
                    auto obj = array.at(j).toObject();
                    if (symbolList.at(i) == obj["symbol"].toString()) {
                        QuoteData *data = new QuoteData();
                        data->price = obj["price"].toDouble();
                        data->change = obj["change"].toDouble();
                        data->changePercentage = obj["changesPercentage"].toDouble();
                        data->time = QDateTime::fromSecsSinceEpoch(obj["timestamp"].toInt());
                        dataList.append(data);
                    }
                }
            }
            onComplete(dataList);
            reply->deleteLater();
        });
    } else { // offline data
        QString filePath = QStringLiteral(":/data/quotes.json");
        QFile file(filePath);
        if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
            qDebug() << "failed to read";
        }
        QByteArray jsonData = file.readAll();
        file.close();
        QJsonParseError error;
        auto doc = QJsonDocument::fromJson(jsonData, &error);
        if (error.error != QJsonParseError::NoError) {
            qDebug() << "Error when parsing json: " << error.errorString();
            return;
        }
        QList<QuoteData *> dataList;
        auto array = doc.array();
        for (int i = 0; i < symbolList.size(); ++i) {
            for (int j = 0; j < array.size(); ++j) {
                auto obj = array.at(j).toObject();
                if (symbolList.at(i) == obj["symbol"].toString()) {
                    QuoteData *data = new QuoteData();
                    data->price = obj["price"].toDouble();
                    data->change = obj["change"].toDouble();
                    data->changePercentage = obj["changesPercentage"].toDouble();
                    data->time = QDateTime::fromSecsSinceEpoch(obj["timestamp"].toInt());
                    dataList.append(data);
                }
            }
        }
        onComplete(dataList);
    }
}

void ApiHandler::getStockHistory(QString symbol,
                                 std::function<void(QList<HistoryData *>)> onComplete)
{
    if (m_useLiveData) {
        QDateTime sixMonthsAgo = QDateTime::currentDateTimeUtc().addMonths(-6);
        QString to = QDateTime::currentDateTimeUtc().toString("yyyy-MM-dd");
        QString from = sixMonthsAgo.toString("yyyy-MM-dd");

        auto url = QString("https://financialmodelingprep.com/api/v3/historical-price-full/")
                   + symbol + QString("?from=") + from + QString("&to=") + to + QString("&apikey=")
                   + m_apiKey;

        m_getRequest.setUrl(QUrl(url));
        auto reply = m_accessManager.get(m_getRequest);

        connect(reply, &QNetworkReply::finished, [reply, onComplete]() {
            QJsonParseError error;
            auto replyStr = QString(reply->readAll());
            auto doc = QJsonDocument::fromJson(replyStr.toUtf8(), &error);

            if (error.error != QJsonParseError::NoError) {
                qDebug() << "Error when parsing json: " << error.errorString();
                return;
            }

            if (reply->error() != QNetworkReply::NoError) {
                qDebug() << "Network error" << reply->errorString() << reply->readAll();
            }
            QList<HistoryData *> dataList;
            auto array = doc["historical"].toArray();

            for (int i = 0; i < array.size(); ++i) {
                auto obj = array.at(i);
                HistoryData *data = new HistoryData();
                data->high = obj["high"].toDouble();
                data->low = obj["low"].toDouble();
                data->open = obj["open"].toDouble();
                data->close = obj["close"].toDouble();
                data->volume = obj["volume"].toInt();
                data->time = QDateTime::fromString(obj["date"].toString(), "yyyy-MM-dd");
                dataList.append(data);
            }
            onComplete(dataList);
            reply->deleteLater();
        });
    } else { //offline data
        QString filePath = QString(":/data/" + symbol + ".json");
        QFile file(filePath);
        if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
            qDebug() << "failed to read";
        }
        QByteArray jsonData = file.readAll();
        file.close();
        QJsonParseError error;
        auto doc = QJsonDocument::fromJson(jsonData, &error);
        if (error.error != QJsonParseError::NoError) {
            qDebug() << "Error when parsing json: " << error.errorString();
            return;
        }

        QList<HistoryData *> dataList;
        auto array = doc["historical"].toArray();

        for (int i = 0; i < array.size(); ++i) {
            auto obj = array.at(i);
            HistoryData *data = new HistoryData();
            data->high = obj["high"].toDouble();
            data->low = obj["low"].toDouble();
            data->open = obj["open"].toDouble();
            data->close = obj["close"].toDouble();
            data->volume = obj["volume"].toInt();
            data->time = QDateTime::fromString(obj["date"].toString(), "yyyy-MM-dd");
            dataList.append(data);
        }
        onComplete(dataList);
    }
}

bool ApiHandler::getUseLiveData()
{
    return m_useLiveData;
}

void ApiHandler::setApiKey(QString apiKey)
{
    m_apiKey = apiKey;
}

void ApiHandler::setUseLiveData(bool useLiveData)
{
    m_useLiveData = useLiveData;
}
