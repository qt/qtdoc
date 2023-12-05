// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause
#ifndef STOCKMODEL_H
#define STOCKMODEL_H

#include <QDateTime>
#include <QObject>

class QuoteData
{
public:
    float price = 0;
    float change = 0;
    float changePercentage = 0;
    QDateTime time;
};

class HistoryData
{
public:
    float high = 0;
    float low = 0;
    float open = 0;
    float close = 0;
    int volume = 0;
    QDateTime time;
};

class StockModel : public QObject
{
    Q_OBJECT
public:
    StockModel(QString stockId, QString name);
    ~StockModel();

    void addData(HistoryData *data);
    void updateHistory(QList<HistoryData *> data);
    void appendQuote(QuoteData *data);
    void resetQuote();
    void setDataIsLive(bool live);

    Q_INVOKABLE int historyCount();
    Q_INVOKABLE int quoteCount();
    Q_INVOKABLE QString getStockId();
    Q_INVOKABLE QString getName();
    Q_INVOKABLE float getPrice(int index);
    Q_INVOKABLE float getChange(int index);
    Q_INVOKABLE float getChangePercentage(int index);
    Q_INVOKABLE int getHigh(int index);
    Q_INVOKABLE int getLow(int index);
    Q_INVOKABLE int getOpen(int index);
    Q_INVOKABLE int getClose(int index);
    Q_INVOKABLE int getVolume(int index);
    Q_INVOKABLE int getAvgVolume();
    Q_INVOKABLE int daysFromNow(int index);
    Q_INVOKABLE int indexOf(QDateTime date);
    Q_INVOKABLE bool getDataIsLive();
    Q_INVOKABLE long long getHistoryDate(int index, bool milliseconds = true);
    Q_INVOKABLE long long getQuoteTime(int index, bool milliseconds = true);

signals:
    void historyDataReady();
    void quoteDataReady();

private:
    QList<HistoryData *> m_historyDataList;
    QList<QuoteData *> m_quoteDataList;
    QString m_stockId;
    QString m_name;
    bool m_dataIsLive = false;
};

#endif // STOCKMODEL_H
