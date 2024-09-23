// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#include "request.h"

#include <QFileInfo>
#include <QGeoPolygon>
#include <QJsonDocument>
#include <QJsonObject>
#include <QNetworkReply>

using namespace Qt::StringLiterals;

size_t qHash(OSMTileData data, size_t seed) noexcept
{
    return qHashMulti(seed, data.TileX, data.TileY, data.ZoomLevel);
}

static QString tileKey(const OSMTileData &tile)
{
    return QString::number(tile.ZoomLevel) + u',' + QString::number(tile.TileX)
           + u',' + QString::number(tile.TileY);
}

QGeoCoordinate importPosition(const QVariant &position)
{
    QGeoCoordinate returnedCoordinates;
    const auto positionList = position.value<QVariantList>();
    for (qsizetype i  = 0; i < positionList.size(); ++i) { // Iterating Point coordinates arrays
        double value = positionList.at(i).toDouble();
        switch (i) {
        case 0:
            returnedCoordinates.setLongitude(value);
            break;
        case 1:
            returnedCoordinates.setLatitude(value);
            break;
        case 2:
            returnedCoordinates.setAltitude(value);
            break;
        default:
            break;
        }
    }
    return returnedCoordinates;
}

QList<QGeoCoordinate> importArrayOfPositions(const QVariant &arrayOfPositions)
{
    QList<QGeoCoordinate> returnedCoordinates;
    const auto positionsList = arrayOfPositions.value<QVariantList>();
    for (const auto &position : positionsList) { // Iterating the LineString coordinates nested arrays
        QGeoCoordinate coordinate = importPosition(position);
        if ( coordinate.isValid() )
            returnedCoordinates.append(coordinate); // Populating the QList of coordinates
    }
    return returnedCoordinates;
}

QList<QList<QGeoCoordinate>> importArrayOfArrayOfPositions(const QVariant &arrayOfArrayofPositions)
{
    QList<QList<QGeoCoordinate>> returnedCoordinates;
    const auto positionsList = arrayOfArrayofPositions.value<QVariantList>();
    for (const QVariant &position : positionsList) // Iterating the Polygon coordinates nested arrays
        returnedCoordinates << importArrayOfPositions(position);
    return returnedCoordinates;
}


QGeoPolygon importPolygon(const QVariantMap &inputMap)
{
    QGeoPolygon returnedObject;
    const QVariant valueCoordinates = inputMap.value("coordinates"_L1);
    const QList<QList<QGeoCoordinate>> perimeters = importArrayOfArrayOfPositions(valueCoordinates);
    for (qsizetype i  = 0; i < perimeters.size(); ++i) { // Import an array of QList<QGeocoordinates>
        if (i == 0)
            returnedObject.setPerimeter(perimeters.at(i)); // External perimeter
        else
            returnedObject.addHole(perimeters.at(i)); // Inner perimeters
    }
    return returnedObject;
}

QVariantMap importGeometry(const QVariantMap &inputMap)
{
    QVariantMap returnedObject;

    const int geometryTypesLen = 1;
    QString geometryTypes[] = {
        "Polygon"_L1,
    };
    enum geoTypeSwitch {
        Polygon,
    };
    for (int i = 0; i < geometryTypesLen; ++i) {
    if (inputMap.value("type"_L1).value<QString>() == geometryTypes[i]) {
        switch (i) {
        case Polygon: {
            returnedObject.insert("type"_L1, "Polygon"_L1);
            returnedObject.insert("data"_L1, QVariant::fromValue(importPolygon(inputMap)));
            break;
        }
        default:
            break;
        }
    }
    }
    return returnedObject;
}

static QVariantList importFeatureCollection(const QVariantMap &inputMap)
{
    QVariantList returnedObject;
    const auto featuresList = inputMap.value("features"_L1).value<QVariantList>();
    for (const QVariant &inputfeature : featuresList) {
        auto inputFeatureMap = inputfeature.value<QVariantMap>();
        auto singleFeatureMap = importGeometry(inputFeatureMap.value("geometry"_L1).value<QVariantMap>());
        const auto importedProperties = inputFeatureMap.value("properties"_L1).value<QVariantMap>();
        singleFeatureMap.insert("properties"_L1, importedProperties);
        if (inputFeatureMap.contains("id"_L1)) {
            auto importedId = inputFeatureMap.value("id"_L1).value<QVariant>();
            singleFeatureMap.insert("id"_L1, importedId);
        }
        returnedObject.append(singleFeatureMap);
    }
    return returnedObject;
}

static QVariantList importGeoJson(const QJsonDocument &geoJson)
{
    QVariantList returnedList;
    QJsonObject object = geoJson.object(); // Read json object from imported doc
    QVariantMap rootGeoJsonObject = object.toVariantMap(); // Extraced map using Qt's API

    const int geometryTypesLen = 3;
    QString geoType[] = {
        "Polygon"_L1,
        "Feature"_L1,
        "FeatureCollection"_L1
    };
    enum geoTypeSwitch {
        Polygon,
        Feature,
        FeatureCollection
    };
    QVariantMap parsedGeoJsonMap;

    // Checking whether the JSON object has a "type" member
    const QVariant keyVariant = rootGeoJsonObject.value("type"_L1);
    auto valueType = keyVariant.value<QString>();

    // Checking whether the "type" member has a GeoJSON admitted value
    for (int i = 0; i < geometryTypesLen; ++i) {
        if (valueType == geoType[i]) {
            switch (i) {
            case Polygon: {
                QGeoPolygon poly = importPolygon(rootGeoJsonObject);
                QVariant dataNodeValue = QVariant::fromValue(poly);
                parsedGeoJsonMap.insert("type"_L1, "Polygon"_L1);
                parsedGeoJsonMap.insert("data"_L1, dataNodeValue);
                break;
            }
            // Single GeoJson geometry object with properties
            case Feature: {
                parsedGeoJsonMap = importGeometry(rootGeoJsonObject.value("geometry"_L1).value<QVariantMap>());
                auto importedProperties = rootGeoJsonObject.value("properties"_L1).value<QVariantMap>();
                parsedGeoJsonMap.insert("properties"_L1, importedProperties);
                if (rootGeoJsonObject.contains("id"_L1)){
                    auto importedId = rootGeoJsonObject.value("id"_L1).value<QVariant>();
                    parsedGeoJsonMap.insert("id"_L1, importedId);
                }
                break;
            }
            // Heterogeneous list of GeoJSON geometries with properties
            case FeatureCollection: {
                QVariantList featCollection = importFeatureCollection(rootGeoJsonObject);
                QVariant dataNodeValue = QVariant::fromValue(featCollection);
                parsedGeoJsonMap.insert("type"_L1, "FeatureCollection"_L1);
                parsedGeoJsonMap.insert("data"_L1, dataNodeValue);
                break;
            }
            default:
                break;
            }
            QVariant bboxNodeValue = rootGeoJsonObject.value("bbox"_L1);
            if (bboxNodeValue.isValid()) {
                parsedGeoJsonMap.insert("bbox"_L1, bboxNodeValue);
            }
            returnedList.append(parsedGeoJsonMap);
        } else if (i >= 9) {
            // Error
            break;
        }
    }
    return returnedList;
}


OSMRequest::OSMRequest(QObject *parent)
    : QObject{parent}
{
    connect( &m_queuesTimer, &QTimer::timeout, this, [this](){
        if ( m_buildingsQueue.isEmpty() && m_mapsQueue.isEmpty() ) {
            m_queuesTimer.stop();
        }
        else {

#ifdef QT_DEBUG
            const int numConcurrentRequests = 1;
#else
            const int numConcurrentRequests = 6;
#endif
            if ( !m_buildingsQueue.isEmpty() && m_buildingsNumberOfRequestsInFlight < numConcurrentRequests ) {
                getBuildingsDataRequest(m_buildingsQueue.dequeue());
                ++m_buildingsNumberOfRequestsInFlight;
            }

            if ( !m_mapsQueue.isEmpty() && m_mapsNumberOfRequestsInFlight < numConcurrentRequests ) {
                getMapsDataRequest(m_mapsQueue.dequeue());
                ++m_mapsNumberOfRequestsInFlight;
            }
        }
    });
    m_queuesTimer.setInterval(0);
}

bool OSMRequest::isDemoToken() const
{
    return m_token.isEmpty();
}

QString OSMRequest::token() const
{
    return m_token;
}

void OSMRequest::setToken(const QString &token)
{
    m_token = token;
}

void OSMRequest::getBuildingsData(const QQueue<OSMTileData> &buildingsQueue) {

    if ( buildingsQueue.isEmpty() )
        return;
    m_buildingsQueue = buildingsQueue;
    if ( !m_queuesTimer.isActive() )
        m_queuesTimer.start();
}

void OSMRequest::getBuildingsDataRequest(const OSMTileData &tile)
{
    const QString fileName = "data/"_L1 + tileKey(tile) + ".json"_L1;
    QFileInfo file(fileName);
    if ( file.size() > 0 ) {
        QFile file(fileName);
        if (file.open(QFile::ReadOnly)){
            QByteArray data = file.readAll();
            file.close();
            emit buildingsDataReady( importGeoJson(QJsonDocument::fromJson( data )), tile.TileX, tile.TileY, tile.ZoomLevel );
            --m_buildingsNumberOfRequestsInFlight;
            return;
        }
    }

    QUrl url = QUrl(tr(m_uRL_OSMB_JSON).arg(QString::number(tile.ZoomLevel),
                                            QString::number(tile.TileX),
                                            QString::number(tile.TileY),
                                            m_token));
    QNetworkReply * reply = m_networkAccessManager.get( QNetworkRequest(url));
    connect( reply, &QNetworkReply::finished, this, [this, reply, tile, url](){
        reply->deleteLater();
        if ( reply->error() == QNetworkReply::NoError ) {
            QByteArray data = reply->readAll();
            emit buildingsDataReady( importGeoJson(QJsonDocument::fromJson( data )), tile.TileX, tile.TileY, tile.ZoomLevel );
        } else {
            const QByteArray message = reply->readAll();
            static QByteArray lastMessage;
            if (message != lastMessage) {
                lastMessage = message;
                qWarning().noquote() << "OSMRequest::getBuildingsData " << reply->error()
                                     << url << message;
            }
        }
        --m_buildingsNumberOfRequestsInFlight;
    } );
}

void OSMRequest::getMapsData(const QQueue<OSMTileData> &mapsQueue) {

    if ( mapsQueue.isEmpty() )
        return;
    m_mapsQueue = mapsQueue;
    if ( !m_queuesTimer.isActive() )
        m_queuesTimer.start();
}

void OSMRequest::getMapsDataRequest(const OSMTileData &tile)
{
    const QString fileName = "data/"_L1 + tileKey(tile) + ".png"_L1;
    QFileInfo file(fileName);
    if ( file.size() > 0) {
        QFile file(fileName);
        if (file.open(QFile::ReadOnly)){
            QByteArray data = file.readAll();
            file.close();
            emit mapsDataReady(  data, tile.TileX, tile.TileY, tile.ZoomLevel );
            --m_mapsNumberOfRequestsInFlight;
            return;
        }
    }

    QUrl url = QUrl(tr(m_uRL_OSMB_MAP).arg(QString::number(tile.ZoomLevel),
                                           QString::number(tile.TileX),
                                           QString::number(tile.TileY)));
    QNetworkReply * reply = m_networkAccessManager.get( QNetworkRequest(url));
    connect( reply, &QNetworkReply::finished, this, [this, reply, tile, url](){
        reply->deleteLater();
        if ( reply->error() == QNetworkReply::NoError ) {
            QByteArray data = reply->readAll();
            emit mapsDataReady( data, tile.TileX, tile.TileY, tile.ZoomLevel );
        } else {
            const QByteArray message = reply->readAll();
            static QByteArray lastMessage;
            if (message != lastMessage) {
                lastMessage = message;
                qWarning().noquote() << "OSMRequest::getMapsDataRequest" << reply->error()
                                     << url << message;
            }
        }
        --m_mapsNumberOfRequestsInFlight;
    } );
}
