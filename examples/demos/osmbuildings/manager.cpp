// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#include "manager.h"

#include <QImage>
#include <QRgb>
#include <QtMath>

OSMManager::OSMManager(QObject *parent)
    : QObject{parent}
{
    m_request = new OSMRequest(this);
    connect(m_request, &OSMRequest::buildingsDataReady, this, [this](const QList<QVariant> &geoVariantsList
                                                                     , int tileX, int tileY, int zoomLevel){
        m_buildingsHash[QString::number(tileX) + ","
                        + QString::number(tileY)
                        + ","
                        + QString::number(zoomLevel)] = true;
        emit buildingsDataReady(geoVariantsList, tileX - m_startBuildingTileX,
                                tileY - m_startBuildingTileY,
                                zoomLevel);
    });

    connect(m_request, &OSMRequest::mapsDataReady, this, [this](const QByteArray &mapData, int tileX, int tileY, int zoomLevel){
        emit mapsDataReady(mapData, tileX - m_startBuildingTileX,
                           tileY - m_startBuildingTileY,
                           zoomLevel);
    });

}

void OSMManager::setCameraProperties(const QVector3D &position, const QVector3D &right,
                                    float cameraZoom, float minimunZoom, float maximumZoom,
                                    float cameraTilt, float minimumTilt, float maxmumTilt)
{

    float tiltFactor = (cameraTilt - minimumTilt) / qMax(maxmumTilt - minimumTilt, 1.0);
    float zoomFactor = (cameraZoom - minimunZoom) / qMax(maximumZoom - minimunZoom, 1.0);

    QVector3D forwardVector = QVector3D::crossProduct(right,
                                                      QVector3D(0.0, 0.0, -1.0)).normalized(); //Forward vector align to the XY plane
    QVector3D projectionOfForwardOnXY = position
            + forwardVector * tiltFactor * zoomFactor * 50.0;

    QQueue<OSMTileData> queue;
    for ( int fowardIndex = -20; fowardIndex <= 20; ++fowardIndex ){
        for ( int sidewardIndex = -20; sidewardIndex <= 20; ++sidewardIndex ){
            QVector3D transferedPosition = projectionOfForwardOnXY + QVector3D(float(m_tileSizeX * sidewardIndex)
                                                                               , float(m_tileSizeY * fowardIndex), 0.0);
            addBuildingRequestToQueue(queue, m_startBuildingTileX + int(transferedPosition.x() / m_tileSizeX),
                                m_startBuildingTileY - int(transferedPosition.y() / m_tileSizeY));
        }
    }

    int projectedTileX = m_startBuildingTileX + int(projectionOfForwardOnXY.x() / m_tileSizeX);
    int projectedTileY = m_startBuildingTileY - int(projectionOfForwardOnXY.y() / m_tileSizeY);

    std::sort(queue.begin(), queue.end(), [projectedTileX, projectedTileY](const OSMTileData &v1, const OSMTileData &v2)->bool{
        return qSqrt(qPow(v1.TileX - projectedTileX, 2)
                     + qPow(v1.TileY - projectedTileY, 2))
               <
              qSqrt(qPow(v2.TileX - projectedTileX, 2)
                        + qPow(v2.TileY - projectedTileY, 2));
    });

    m_request->getBuildingsData( queue );
    m_request->getMapsData( queue );

}

void OSMManager::addBuildingRequestToQueue(QQueue<OSMTileData> &queue, int tileX, int tileY, int zoomLevel)
{
    QString key = QString::number(tileX) + "," + QString::number(tileY) + "," + QString::number(zoomLevel);
    if ( m_buildingsHash.contains( key ) )
        return;

    OSMTileData tile;
    tile.ZoomLevel = zoomLevel;
    tile.TileX = tileX;
    tile.TileY = tileY;
    queue.append( tile );

}

int OSMManager::tileSizeX() const
{
    return m_tileSizeX;
}

int OSMManager::tileSizeY() const
{
    return m_tileSizeY;
}

bool OSMManager::isDemoToken() const
{
    return m_request->isDemoToken();
}

void OSMManager::setToken(QString token)
{
    m_request->setToken(token);
}

QString OSMManager::token() const
{
    return m_request->token();
}

void CustomTextureData::setImageData(const QByteArray &data)
{
    QImage image = QImage::fromData(data).convertToFormat(QImage::Format_RGBA8888);
    setTextureData( QByteArray(reinterpret_cast<const char*>(image.constBits()), image.sizeInBytes()) );
    setSize( image.size() );
    setHasTransparency(false);
    setFormat(Format::RGBA8);
}
