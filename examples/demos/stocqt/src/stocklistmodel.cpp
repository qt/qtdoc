// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause
#include "stocklistmodel.h"

StockListModel::StockListModel(QObject *parent)
    : QAbstractListModel(parent)
{
    m_data.append(new StockListData("QTCOM.HE", "Qt Group"));
    m_data.append(new StockListData("AAPL", "Apple Inc"));
    m_data.append(new StockListData("MSFT", "Microsoft Corp"));
    m_data.append(new StockListData("AMZN", "Amazon.com Inc"));
    m_data.append(new StockListData("NVDA", "NVIDIA Corp"));
    m_data.append(new StockListData("TSLA", "Tesla Inc"));
    m_data.append(new StockListData("GOOG", "Alphabet Inc"));
    m_data.append(new StockListData("GOOGL", "Alphabet Inc"));
    m_data.append(new StockListData("META", "Meta Platforms Inc"));
    m_data.append(new StockListData("AVGO", "Broadcom Inc"));
    m_data.append(new StockListData("PEP", "PepsiCo Inc"));
    m_data.append(new StockListData("COST", "Costco Wholesale Corp"));
    m_data.append(new StockListData("CSCO", "Cisco Systems Inc"));
    m_data.append(new StockListData("TMUS", "T-Mobile US Inc"));
    m_data.append(new StockListData("CMCSA", "Comcast Corp"));
    m_data.append(new StockListData("TXN", "Texas Instruments Inc"));
    m_data.append(new StockListData("ADBE", "Adobe Inc"));
    m_data.append(new StockListData("NFLX", "Netflix Inc"));
    m_data.append(new StockListData("QCOM", "QUALCOMM Inc"));
    m_data.append(new StockListData("HON", "Honeywell International Inc"));
    m_data.append(new StockListData("AMD", "Advanced Micro Devices Inc"));
    m_data.append(new StockListData("AMGN", "Amgen Inc"));
    m_data.append(new StockListData("SBUX", "Starbucks Corp"));
    m_data.append(new StockListData("INTU", "Intuit Inc"));
    m_data.append(new StockListData("INTC", "Intel Corp"));
    m_data.append(new StockListData("GILD", "Gilead Sciences Inc"));
    m_data.append(new StockListData("AMAT", "Applied Materials Inc"));
    m_data.append(new StockListData("BKNG", "Booking Holdings Inc"));
    m_data.append(new StockListData("ADI", "Analog Devices Inc"));
    m_data.append(new StockListData("ADP", "Automatic Data Processing Inc"));
    m_data.append(new StockListData("MDLZ", "Mondelez International Inc"));
    m_data.append(new StockListData("PYPL", "PayPal Holdings Inc"));
    m_data.append(new StockListData("REGN", "Regeneron Pharmaceuticals Inc"));
    m_data.append(new StockListData("ISRG", "Intuitive Surgical Inc"));
    m_data.append(new StockListData("VRTX", "Vertex Pharmaceuticals Inc"));
    m_data.append(new StockListData("LRCX", "Lam Research Corp"));
    m_data.append(new StockListData("CSX", "CSX Corp"));
    m_data.append(new StockListData("MU", "Micron Technology Inc"));
    m_data.append(new StockListData("MELI", "MercadoLibre Inc"));
    m_data.append(new StockListData("ATVI", "Activision Blizzard Inc"));
    m_data.append(new StockListData("CHTR", "Charter Communications Inc"));
    m_data.append(new StockListData("PANW", "Palo Alto Networks Inc"));
    m_data.append(new StockListData("SNPS", "Synopsys Inc"));
    m_data.append(new StockListData("ASML", "ASML Holding NV"));
    m_data.append(new StockListData("KLAC", "KLA Corp"));
    m_data.append(new StockListData("MAR", "Marriott International Inc/MD"));
    m_data.append(new StockListData("MRNA", "Moderna Inc"));
    m_data.append(new StockListData("MNST", "Monster Beverage Corp"));
    m_data.append(new StockListData("CDNS", "Cadence Design Systems Inc"));
    m_data.append(new StockListData("ORLY", "O'Reilly Automotive Inc"));
    m_data.append(new StockListData("ABNB", "Airbnb Inc"));
    m_data.append(new StockListData("KDP", "Keurig Dr Pepper Inc"));
    m_data.append(new StockListData("KHC", "Kraft Heinz Co/The"));
    m_data.append(new StockListData("FTNT", "Fortinet Inc"));
    m_data.append(new StockListData("NXPI", "NXP Semiconductors NV"));
    m_data.append(new StockListData("AEP", "American Electric Power Co Inc"));
    m_data.append(new StockListData("MCHP", "Microchip Technology Inc"));
    m_data.append(new StockListData("CTAS", "Cintas Corp"));
    m_data.append(new StockListData("ADSK", "Autodesk Inc"));
    m_data.append(new StockListData("DXCM", "Dexcom Inc"));
    m_data.append(new StockListData("PDD", "PDD Holdings Inc ADR"));
    m_data.append(new StockListData("EXC", "Exelon Corp"));
    m_data.append(new StockListData("AZN", "AstraZeneca PLC ADR"));
    m_data.append(new StockListData("PAYX", "Paychex Inc"));
    m_data.append(new StockListData("IDXX", "IDEXX Laboratories Inc"));
    m_data.append(new StockListData("BIIB", "Biogen Inc"));
    m_data.append(new StockListData("MRVL", "Marvell Technology Inc"));
    m_data.append(new StockListData("ROST", "Ross Stores Inc"));
    m_data.append(new StockListData("WBD", "Warner Bros Discovery Inc"));
    m_data.append(new StockListData("LULU", "Lululemon Athletica Inc"));
    m_data.append(new StockListData("PCAR", "PACCAR Inc"));
    m_data.append(new StockListData("ODFL", "Old Dominion Freight Line Inc"));
    m_data.append(new StockListData("WDAY", "Workday Inc"));
    m_data.append(new StockListData("GFS", "GLOBALFOUNDRIES Inc"));
    m_data.append(new StockListData("XEL", "Xcel Energy Inc"));
    m_data.append(new StockListData("CPRT", "Copart Inc"));
    m_data.append(new StockListData("CTSH", "Cognizant Technology Solutions Corp"));
    m_data.append(new StockListData("DLTR", "Dollar Tree Inc"));
    m_data.append(new StockListData("ILMN", "Illumina Inc"));
    m_data.append(new StockListData("WBA", "Walgreens Boots Alliance Inc"));
    m_data.append(new StockListData("BKR", "Baker Hughes Co"));
    m_data.append(new StockListData("EA", "Electronic Arts Inc"));
    m_data.append(new StockListData("FAST", "Fastenal Co"));
    m_data.append(new StockListData("CSGP", "CoStar Group Inc"));
    m_data.append(new StockListData("ENPH", "Enphase Energy Inc"));
    m_data.append(new StockListData("VRSK", "Verisk Analytics Inc"));
    m_data.append(new StockListData("ANSS", "ANSYS Inc"));
    m_data.append(new StockListData("CRWD", "Crowdstrike Holdings Inc"));
    m_data.append(new StockListData("EBAY", "eBay Inc"));
    m_data.append(new StockListData("FANG", "Diamondback Energy Inc"));
    m_data.append(new StockListData("CEG", "Constellation Energy Corp"));
    m_data.append(new StockListData("TEAM", "Atlassian Corp"));
    m_data.append(new StockListData("ALGN", "Align Technology Inc"));
    m_data.append(new StockListData("DDOG", "Datadog Inc"));
    m_data.append(new StockListData("JD", "JD.com Inc ADR"));
    m_data.append(new StockListData("ZS", "Zscaler Inc"));
    m_data.append(new StockListData("ZM", "Zoom Video Communications Inc"));
    m_data.append(new StockListData("RIVN", "Rivian Automotive Inc"));
    m_data.append(new StockListData("SIRI", "Sirius XM Holdings Inc"));
    m_data.append(new StockListData("LCID", "Lucid Group Inc"));
    for (auto stock : m_data) {
        stock->model->setParent(this);
    }
}

int StockListModel::rowCount(const QModelIndex &parent) const
{
    return m_data.size();
}

int StockListModel::columnCount(const QModelIndex &parent) const
{
    return 8;
}
QVariant StockListModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    switch (role) {
    case Roles::idRole:
        return m_data[index.row()]->stockId;
    case Roles::nameRole:
        return m_data[index.row()]->name;
    case Roles::favoriteRole:
        return m_data[index.row()]->favorite;
    case Roles::dateRole:
        return m_data[index.row()]->model->getQuoteTime(0);
    case Roles::priceRole:
        return m_data[index.row()]->model->getPrice(0);
    case Roles::changeRole:
        return m_data[index.row()]->model->getChange(0);
    case Roles::changePercentageRole:
        return m_data[index.row()]->model->getChangePercentage(0);
    case Roles::filterRole:
        return m_data[index.row()]->stockId + " " + m_data[index.row()]->name;
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> StockListModel::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles[Roles::idRole] = "stockId";
    roles[Roles::nameRole] = "name";
    roles[Roles::favoriteRole] = "favorite";
    roles[Roles::dateRole] = "date";
    roles[Roles::priceRole] = "price";
    roles[Roles::changeRole] = "change";
    roles[Roles::changePercentageRole] = "changePercentage";
    roles[Roles::filterRole] = "filter";

    return roles;
}

void StockListModel::updateDetails(const QList<QuoteData *> &data)
{
    beginResetModel();
    for (int i = 0; i < m_data.size(); ++i) {
        m_data.at(i)->model->appendQuote(data.at(i));
        m_data.at(i)->favorite = m_favorites.contains(m_data.at(i)->stockId);
    }
    endResetModel();
}

void StockListModel::resetQuotes()
{
    for (int i = 0; i < m_data.size(); ++i) {
        m_data.at(i)->model->resetQuote();
    }
}

void StockListModel::addFavorite(const QString &stockId)
{
    for (int i = 0; i < m_data.size(); i++) {
        StockListData *stock = m_data[i];
        if (stock->stockId == stockId) {
            beginResetModel();
            stock->favorite = true;
            m_favorites.append(stockId);
            endResetModel();
        }
    }
}
void StockListModel::removeFavorite(const QString &stockId)
{
    for (int i = 0; i < m_data.size(); i++) {
        StockListData *stock = m_data[i];
        if (stock->stockId == stockId) {
            beginResetModel();
            stock->favorite = false;
            endResetModel();
        }
    }
    for (int i = 0; i < m_favorites.size(); ++i) {
        if (m_favorites.at(i) == stockId)
            m_favorites.removeAt(i);
    }
}

StockModel *StockListModel::getStockModel(int index)
{
    return m_data[index]->model;
}
