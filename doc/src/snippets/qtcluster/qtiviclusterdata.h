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

#ifndef CLUSTERDATA_H
#define CLUSTERDATA_H

#include <QObject>
#include <QQmlParserStatus>
#include <QQmlProperty>

#ifndef NO_NETWORK
#include "clusterdatabackend.h"
#endif

QT_BEGIN_NAMESPACE

#ifndef NO_NETWORK
class ClusterDataBackend;
#endif

class ZonedProperties : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool doorOpen READ doorOpen NOTIFY doorOpenChanged)

public:
    ZonedProperties(QObject *parent=0) : QObject(parent), m_zone(""), m_doorOpen(false) {}

    void setZone(const QString &zone) { m_zone = zone; }
    QString zone() { return m_zone; }

    bool doorOpen() { return m_doorOpen; }
    void setDoorOpen(const bool &d) { m_doorOpen = d; emit doorOpenChanged(); }
signals:
    void zoneChanged(const QString &zone);
    void doorOpenChanged();

private:
    QString m_zone;
    bool m_doorOpen;
};

class QtIVIClusterData : public QObject, public QQmlParserStatus
{
    Q_OBJECT
    Q_INTERFACES(QQmlParserStatus)

    Q_PROPERTY(double vehicleSpeed READ vehicleSpeed NOTIFY vehicleSpeedChanged)
    Q_PROPERTY(double latitude READ latitude NOTIFY latitudeChanged)
    Q_PROPERTY(double longitude READ longitude NOTIFY longitudeChanged)
    Q_PROPERTY(double direction READ direction NOTIFY directionChanged)
    Q_PROPERTY(bool flatTire READ flatTire NOTIFY flatTireChanged)
    Q_PROPERTY(bool lightFailure READ lightFailure NOTIFY lightFailureChanged)
    Q_PROPERTY(bool reverse READ reverse NOTIFY reverseChanged)
    Q_PROPERTY(bool leftTurnLight READ leftTurnLight NOTIFY leftTurnLightChanged)
    Q_PROPERTY(bool rightTurnLight READ rightTurnLight NOTIFY rightTurnLightChanged)
    Q_PROPERTY(bool headLight READ headLight NOTIFY headLightChanged)
    Q_PROPERTY(bool parkLight READ parkLight NOTIFY parkLightChanged)
    Q_PROPERTY(int carId READ carId NOTIFY carIdChanged)
    Q_PROPERTY(bool brake READ brake NOTIFY brakeChanged)
    Q_PROPERTY(int engineTemp READ engineTemp NOTIFY engineTempChanged)
    Q_PROPERTY(double oilTemp READ oilTemp NOTIFY oilTempChanged)
    Q_PROPERTY(int oilPressure READ oilPressure NOTIFY oilPressureChanged)
    Q_PROPERTY(double batteryPotential READ batteryPotential NOTIFY batteryPotentialChanged)
    Q_PROPERTY(double gasLevel READ gasLevel NOTIFY gasLevelChanged)
    Q_PROPERTY(int rpm READ rpm NOTIFY rpmChanged)
    Q_PROPERTY(int gear READ gear NOTIFY gearChanged)

    Q_PROPERTY(QVariantMap zoneAt READ zoneFeatureMap  NOTIFY zonesChanged)

public:

    QtIVIClusterData(QObject *parent=0);

    double vehicleSpeed() const;
    double latitude() const;
    double longitude() const;
    double direction() const;
    bool flatTire() const;
    bool doorOpen() const;
    bool lightFailure() const;
    bool reverse() const;
    bool leftTurnLight() const;
    bool rightTurnLight() const;
    bool headLight() const;
    bool parkLight() const;
    int carId() const;
    bool brake() const;
    int engineTemp() const;
    double oilTemp() const;
    int oilPressure() const;
    double batteryPotential() const;
    double gasLevel() const;
    int rpm() const;
    int gear() const;

Q_SIGNALS:
    void vehicleSpeedChanged(double vehicleSpeed);
    void latitudeChanged(double latitude);
    void longitudeChanged(double longitude);
    void directionChanged(double direction);
    void flatTireChanged(bool flatTire);
    void doorOpenChanged(bool doorOpen);
    void lightFailureChanged(bool lightFailure);
    void reverseChanged(bool Reverse);
    void leftTurnLightChanged(bool leftTurnLight);
    void rightTurnLightChanged(bool rightTurnLight);
    void headLightChanged(bool headLight);
    void parkLightChanged(bool parkLight);
    void carIdChanged(int carId);
    void brakeChanged(bool brakeOn );
    void engineTempChanged(int engineTemp);
    void oilTempChanged(double oilTemp);
    void oilPressureChanged(int oilPressure);
    void batteryPotentialChanged(double batteryPotential);
    void gasLevelChanged(double gasLevel);
    void rpmChanged(int rpm);
    void gearChanged(int gear);
    void zonesChanged();

protected:
    //TODO This doesn't work for the C++ usecases we should use the constructor there instead
    // Also this means a qml dependency in the core, do we want that ?
    virtual void classBegin();
    virtual void componentComplete();

private Q_SLOTS:
    void onVehicleSpeedChanged(double vehicleSpeed, const QString &zone);
    void onLatitudeChanged(double latitude, const QString &zone);
    void onLongitudeChanged(double longitude, const QString &zone);
    void onDirectionChanged(double direction, const QString &zone);
    void onFlatTireChanged(bool flatTire, const QString &zone);
    void onDoorOpenChanged(bool doorOpen, const QString &zone);
    void onLightFailureChanged(bool lightFailure, const QString &zone);
    void onReverseChanged(bool reverse, const QString &zone);
    void onLeftTurnLightChanged(bool leftTurnLight, const QString &zone);
    void onRightTurnLightChanged(bool rightTurnLight, const QString &zone);
    void onHeadLightChanged(bool headLight, const QString &zone);
    void onParkLightChanged(bool parkLight, const QString &zone);
    void onCarIdChanged(int carId, const QString &zone);
    void onBrakeChanged(bool brakeOn, const QString &zone );
    void onEngineTempChanged(int engineTemp, const QString &zone);
    void onOilTempChanged(double oilTemp, const QString &zone);
    void onOilPressureChanged(int oilPressure, const QString &zone);
    void onBatteryPotentialChanged(double batteryPotential, const QString &zone);
    void onGasLevelChanged(double gasLevel, const QString &zone);
    void onRpmChanged(int rpm, const QString &zone);
    void onGearChanged(int gear, const QString &zone);

protected:
    //    virtual QtIVIAbstractZonedFeature* createZoneFeature(const QString &zone) Q_DECL_OVERRIDE;
    //    QtIVIClusterData* zonedFeature(const QString &zone);


private:
    void connectToServiceObject();
    QVariantMap zoneFeatureMap() const;
    void initializeZones();
    ZonedProperties *zoneAt(const QString &zone) const;

private:
    //QtIVIClusterDataBackendInterface* clusterDataBackend();
#ifndef NO_NETWORK
    ClusterDataBackend *backend;
#endif

    double m_vehicleSpeed;
    double m_latitude;
    double m_longitude;
    double m_direction;
    bool m_flatTire;
    bool m_doorOpen;
    bool m_lightFailure;
    bool m_reverse;
    bool m_leftTurnLight;
    bool m_rightTurnLight;
    bool m_headLight;
    bool m_parkLight;
    int m_carId;
    bool m_brake;
    qint8 m_engineTemp;
    double m_oilTemp;
    int m_oilPressure;
    double m_batteryPotential;
    double m_gasLevel;
    int m_rpm;
    int m_gear;

    QVariantMap m_zoneFeatureMap;
    QList<ZonedProperties*> m_zoneFeatures;
    QVariantList m_zoneFeatureList;

};

QT_END_NAMESPACE

#endif // CLUSTERDATA_H
