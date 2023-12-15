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
    , m_lastStrikeInfo{nullptr}
    , m_model{new LightningItemModel{}}
    , m_provider{new LightningProvider{}}
    , m_sourcePosition{nullptr}
    , m_userLocation{nullptr}
{
    m_sourcePosition.reset(QGeoPositionInfoSource::createDefaultSource(this));

    connect(m_provider.get(), &LightningProvider::dataReady, this, &Controller::onDataReceived);
    connect(m_sourcePosition.get(), &QGeoPositionInfoSource::positionUpdated, this,
            &Controller::onUserPositionChanged);

    m_sourcePosition->setUpdateInterval(3000);
    m_sourcePosition->startUpdates();
}

Controller::~Controller()
{
    m_provider.reset();
}

QAbstractItemModel *Controller::getModel()
{
    return m_model.get();
}

long long Controller::getLastStrikeTime()
{
    return (m_lastStrikeInfo && m_lastStrikeInfo->isValid()) ? m_lastStrikeInfo->timestamp : -1;
}

double Controller::getLastStrikeDistance()
{
    return (m_lastStrikeInfo && m_lastStrikeInfo->isValid()) ? m_lastStrikeInfo->distance : -1;
}

double Controller::getLastStrikeDirection()
{
    return (m_lastStrikeInfo && m_lastStrikeInfo->isValid()) ? m_lastStrikeInfo->direction : -1;
}

void Controller::updateDistanceTime(QSharedPointer<LightningItemData> data)
{
    if (m_userLocation == nullptr)
        return;

    LastStrikeInfo strikeInfo(data->getDistanceTo(*m_userLocation),
                              data->timestamp,
                              data->getDirectionFrom(*m_userLocation));
    if (strikeInfo.distance > NOTIFICATION_RADIUS)
        return;

    if (m_lastStrikeInfo == nullptr)
        m_lastStrikeInfo.reset(new LastStrikeInfo{strikeInfo});
    else
        *m_lastStrikeInfo = strikeInfo;

    emit lastStrikeInfoUpdated();
}

void Controller::onDataReceived(QSharedPointer<LightningItemData> data)
{
    m_model->insertData(data);

    updateDistanceTime(data);
}

void Controller::onUserPositionChanged(const QGeoPositionInfo &position)
{
    if (m_userLocation == nullptr)
        m_userLocation.reset(new QGeoCoordinate{position.coordinate()});
    else if (*m_userLocation == position.coordinate())
        return;
    else
        *m_userLocation = position.coordinate();

    LastStrikeInfo latestStrikeInfo;
    m_model->getLatestStrikeInfo(*m_userLocation, NOTIFICATION_RADIUS, &latestStrikeInfo);

    if (m_lastStrikeInfo == nullptr)
        m_lastStrikeInfo.reset(new LastStrikeInfo{latestStrikeInfo});
    else
        *m_lastStrikeInfo = latestStrikeInfo;

    emit lastStrikeInfoUpdated();
}
