// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#include "controller.h"
#include "data/laststrikeinfo.h"
#include "models/lightningitemmodel.h"
#include "providers/lightningprovider.h"

#include <QGeoPositionInfoSource>


namespace {
constexpr int NOTIFICATION_RADIUS = 100000;  // meters
}

Controller::Controller(QObject *parent)
    : QObject{parent}
{
    m_sourcePosition.reset(QGeoPositionInfoSource::createDefaultSource(this));

    connect(&m_provider, &LightningProvider::dataReady, this, &Controller::onDataReceived);
    connect(m_sourcePosition.get(), &QGeoPositionInfoSource::positionUpdated, this,
            &Controller::onUserPositionChanged);

    m_sourcePosition->setUpdateInterval(3000);
    m_sourcePosition->startUpdates();
}

Controller::~Controller()
{
}

QAbstractItemModel *Controller::getModel()
{
    return &m_model;
}

int Controller::getLastStrikeTime()
{
    return m_lastStrikeInfo.isValid() ? m_lastStrikeInfo.timestamp.count() : -1;
}

double Controller::getLastStrikeDistance()
{
    return m_lastStrikeInfo.isValid() ? m_lastStrikeInfo.distance : -1;
}

double Controller::getLastStrikeDirection()
{
    return m_lastStrikeInfo.isValid() ? m_lastStrikeInfo.direction : -1;
}

void Controller::updateDistanceTime(const LightningItemData &data)
{
    LastStrikeInfo strikeInfo(data.getDistanceTo(m_userLocation),
                              data.timestamp,
                              data.getDirectionFrom(m_userLocation));
    if (strikeInfo.distance > NOTIFICATION_RADIUS)
        return;

    m_lastStrikeInfo = strikeInfo;

    emit lastStrikeInfoUpdated();
}

void Controller::onDataReceived(const LightningItemData &data)
{
    m_model.insertData(data);

    updateDistanceTime(data);
}

void Controller::onUserPositionChanged(const QGeoPositionInfo &position)
{
    QGeoCoordinate newCoordinate = position.coordinate();
    if (m_userLocation == newCoordinate)
        return;

    m_userLocation = newCoordinate;

    m_model.getLatestStrikeInfo(m_userLocation, NOTIFICATION_RADIUS, &m_lastStrikeInfo);

    emit lastStrikeInfoUpdated();
}
