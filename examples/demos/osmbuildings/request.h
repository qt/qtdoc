// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#ifndef OSMREQUEST_H
#define OSMREQUEST_H

#include <QNetworkAccessManager>
#include <QQueue>
#include <QTimer>


struct OSMTileData{
    int TileX;
    int TileY;
    int ZoomLevel;
    bool operator ==(const OSMTileData &other) const{
        return (TileX == other.TileX && TileY == other.TileY && ZoomLevel == other.ZoomLevel);
    }
};

class OSMRequest : public QObject
{
    Q_OBJECT

public:
    explicit OSMRequest(QObject *parent = nullptr);
    bool isDemoToken() const;

    QString token() const;
    void setToken(const QString &token);

public slots:
    void getBuildingsData(const QQueue<OSMTileData> &buildingsQueue);
    void getMapsData(const QQueue<OSMTileData> &mapsQueue);

signals:
    void buildingsDataReady( const QList<QVariant> &geoVariantsList, int tileX, int tileY, int zoomLevel );
    void mapsDataReady(const QByteArray &mapData, int tileX, int tileY, int zoomLevel );

private slots:
    void getBuildingsDataRequest(const OSMTileData &tile);
    void getMapsDataRequest(const OSMTileData &tile);

private:

    int m_buildingsNumberOfRequestsInFlight = 0;
    int m_mapsNumberOfRequestsInFlight = 0;
    QTimer m_queuesTimer;
    QQueue<OSMTileData> m_buildingsQueue;
    QQueue<OSMTileData> m_mapsQueue;
    QNetworkAccessManager m_networkAccessManager;
    QString m_token;

    //%1 = zoom level(15 the default and only one here that seems working), %2 = x tile number, %3 = y tile number
    const char *m_uRL_OSMB_JSON = "https://983wdxn2c2.execute-api.eu-north-1.amazonaws.com/production/osmbuildingstile?z=%1&x=%2&y=%3&token=%4";

    //%1 = zoom level(is dynamic), %2 = x tile number, %3 = y tile number
    const char *m_uRL_OSMB_MAP = "https://tile-a.openstreetmap.fr/hot/%1/%2/%3.png";
};


#endif // REQUEST_H
