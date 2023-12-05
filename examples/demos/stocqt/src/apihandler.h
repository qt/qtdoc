// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause
#ifndef APIHANDLER_H
#define APIHANDLER_H

#include <QNetworkAccessManager>
#include "stockmodel.h"

class ApiHandler : public QObject
{
    Q_OBJECT
public:
    ApiHandler();

    void testApiKey(QString apiKey, std::function<void(bool)> onComplete);
    void setApiKey(QString apiKey);
    void setUseLiveData(bool useLiveData);
    void getStockQuote(const QString symbol, std::function<void(QList<QuoteData *>)> onComplete);
    void getStockHistory(QString symbol, std::function<void(QList<HistoryData *>)> onComplete);
    void getStockListData();
    bool getUseLiveData();

private:
    QString m_apiKey;
    bool m_useLiveData = false;
    QNetworkAccessManager m_accessManager;
    QNetworkRequest m_getRequest;

};

#endif // APIHANDLER_H
