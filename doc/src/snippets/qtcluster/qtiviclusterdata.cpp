/****************************************************************************
**
** Copyright (C) 2015 Pelagicore AG
** Contact: http://www.qt.io/ or http://www.pelagicore.com/
**
** This file is part of the QtIVI module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:LGPL3-PELAGICORE$
** Commercial License Usage
** Licensees holding valid commercial Qt IVI licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and Pelagicore. For licensing terms
** and conditions, contact us at http://www.pelagicore.com.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 3 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPLv3 included in the
** packaging of this file. Please review the following information to
** ensure the GNU Lesser General Public License version 3 requirements
** will be met: https://www.gnu.org/licenses/lgpl-3.0.html.
**
** $QT_END_LICENSE$
**
** SPDX-License-Identifier: LGPL-3.0
**
****************************************************************************/

#include "qtiviclusterdata.h"

QtIVIClusterData::QtIVIClusterData(QObject* parent)
    : QObject(parent),
      m_vehicleSpeed(0),
      m_latitude(0),
      m_longitude(0),
      m_direction(0),
      m_flatTire(false),
      m_doorOpen(false),
      m_lightFailure(false),
      m_reverse(false),
      m_leftTurnLight(false),
      m_rightTurnLight(false),
      m_headLight(false),
      m_parkLight(false),
      m_carId(1),
      m_brake(false),
      m_engineTemp(60),
      m_oilTemp(0.0),
      m_oilPressure(0),
      m_batteryPotential(80.0),
      m_gasLevel(67.0),
      m_rpm(4000),
      m_gear(1)
{
    connectToServiceObject();
}

void QtIVIClusterData::connectToServiceObject()
{
    initializeZones();
}

ZonedProperties *QtIVIClusterData::zoneAt(const QString &zone) const
{
    foreach (ZonedProperties *f, m_zoneFeatures)
        if (f->zone() == zone)
            return f;
    return 0;
}

void QtIVIClusterData::initializeZones()
{

}

QVariantMap QtIVIClusterData::zoneFeatureMap() const
{
    return m_zoneFeatureMap;

}

double QtIVIClusterData::vehicleSpeed() const
{
    return m_vehicleSpeed;
}

double QtIVIClusterData::latitude() const
{
    return m_latitude;
}

double QtIVIClusterData::longitude() const
{
    return m_longitude;
}

double QtIVIClusterData::direction() const
{
    return m_direction;
}

bool QtIVIClusterData::flatTire() const
{
    return m_flatTire;
}

bool QtIVIClusterData::doorOpen() const
{
    return m_doorOpen;
}

bool QtIVIClusterData::lightFailure() const
{
    return m_lightFailure;
}

bool QtIVIClusterData::reverse() const
{
    return m_reverse;
}

bool QtIVIClusterData::leftTurnLight() const
{
    return m_leftTurnLight;
}

bool QtIVIClusterData::rightTurnLight() const
{
    return m_rightTurnLight;
}

bool QtIVIClusterData::headLight() const
{
    return m_headLight;
}

bool QtIVIClusterData::parkLight() const
{
    return m_parkLight;
}

int QtIVIClusterData::carId() const
{
    return m_carId;
}

bool QtIVIClusterData::brake() const
{
    return  m_brake;
}

int QtIVIClusterData::engineTemp() const
{
    return m_engineTemp;
}

double QtIVIClusterData::oilTemp() const
{
    return m_oilTemp;
}

int QtIVIClusterData::oilPressure() const
{
    return m_oilPressure;
}

double QtIVIClusterData::batteryPotential() const
{
    return  m_batteryPotential;
}

double QtIVIClusterData::gasLevel() const
{
    return m_gasLevel;
}

int QtIVIClusterData::rpm() const
{
    return m_rpm;
}

int QtIVIClusterData::gear() const
{
    return  m_gear;
}

void QtIVIClusterData::classBegin()
{

}

void QtIVIClusterData::componentComplete()
{

}

void QtIVIClusterData::onVehicleSpeedChanged(double vehicleSpeed, const QString &zone)
{
    Q_UNUSED(zone);
    m_vehicleSpeed = vehicleSpeed;
    emit vehicleSpeedChanged(vehicleSpeed);
}

void QtIVIClusterData::onLatitudeChanged(double latitude, const QString &zone)
{
    Q_UNUSED(zone);
    m_latitude = latitude;
    emit latitudeChanged(latitude);
}

void QtIVIClusterData::onLongitudeChanged(double longitude, const QString &zone)
{
    Q_UNUSED(zone);
    m_longitude = longitude;
    emit longitudeChanged(longitude);
}

void QtIVIClusterData::onDirectionChanged(double direction, const QString &zone)
{
    Q_UNUSED(zone);
    m_direction = direction;
    emit directionChanged(direction);
}

void QtIVIClusterData::onFlatTireChanged(bool flatTire, const QString &zone)
{
    Q_UNUSED(zone);
    m_flatTire = flatTire;
    emit flatTireChanged(flatTire);
}

void QtIVIClusterData::onDoorOpenChanged(bool doorOpen, const QString &zone)
{
    ZonedProperties *z = zoneAt(zone);
    if (z) {
        z->setDoorOpen(doorOpen);
    }
}

void QtIVIClusterData::onLightFailureChanged(bool lightFailure, const QString &zone)
{
    Q_UNUSED(zone);
    m_lightFailure = lightFailure;
    emit lightFailureChanged(lightFailure);
}

void QtIVIClusterData::onReverseChanged(bool reverse, const QString &zone)
{
    Q_UNUSED(zone);
    m_reverse = reverse;
    emit reverseChanged(reverse);
}

void QtIVIClusterData::onLeftTurnLightChanged(bool leftTurnLight, const QString &zone)
{
    Q_UNUSED(zone);
    m_leftTurnLight = leftTurnLight;
    emit leftTurnLightChanged(leftTurnLight);
}

void QtIVIClusterData::onRightTurnLightChanged(bool rightTurnLight, const QString &zone)
{
    Q_UNUSED(zone);
    m_rightTurnLight = rightTurnLight;
    emit rightTurnLightChanged(rightTurnLight);
}

void QtIVIClusterData::onHeadLightChanged(bool headLight, const QString &zone)
{
    Q_UNUSED(zone);
    m_headLight = headLight;
    emit headLightChanged(headLight);
}

void QtIVIClusterData::onParkLightChanged(bool parkLight, const QString &zone)
{
    Q_UNUSED(zone);
    m_parkLight = parkLight;
    emit parkLightChanged(parkLight);
}

void QtIVIClusterData::onCarIdChanged(int carId, const QString &zone)
{
    Q_UNUSED(zone);
    m_carId = carId;
    emit carIdChanged(carId);
}

void QtIVIClusterData::onBrakeChanged(bool brakeOn, const QString &zone)
{
    Q_UNUSED(zone);
    m_brake = brakeOn;
    emit brakeChanged(brakeOn);
}

void QtIVIClusterData::onEngineTempChanged(int engineTemp, const QString &zone)
{
    Q_UNUSED(zone);
    m_engineTemp = engineTemp;
    emit engineTempChanged(engineTemp);
}

void QtIVIClusterData::onOilTempChanged(double oilTemp, const QString &zone)
{
    Q_UNUSED(zone);
    m_oilTemp = oilTemp;
    emit oilTempChanged(oilTemp);
}

void QtIVIClusterData::onOilPressureChanged(int oilPressure, const QString &zone)
{
    Q_UNUSED(zone);
    m_oilPressure = oilPressure;
    emit oilPressureChanged(oilPressure);
}

void QtIVIClusterData::onBatteryPotentialChanged(double batteryPotential, const QString &zone)
{
    Q_UNUSED(zone);
    m_batteryPotential = batteryPotential;
    emit batteryPotentialChanged(batteryPotential);
}

void QtIVIClusterData::onGasLevelChanged(double gasLevel, const QString &zone)
{
    Q_UNUSED(zone);
    m_gasLevel = gasLevel;
    emit gasLevelChanged(gasLevel);
}

void QtIVIClusterData::onRpmChanged(int rpm, const QString &zone)
{
    Q_UNUSED(zone);
    m_rpm = rpm;
    emit rpmChanged(rpm);
}

void QtIVIClusterData::onGearChanged(int gear, const QString &zone)
{
    Q_UNUSED(zone);
    m_gear = gear;
    emit gearChanged(gear);
}
