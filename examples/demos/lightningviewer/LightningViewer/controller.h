// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#ifndef CONTROLLER_H
#define CONTROLLER_H

#include "laststrikeinfo.h"
#include "lightningitemmodel.h"
#include "lightningprovider.h"

#include <QGeoPositionInfoSource>
#include <QObject>
#include <QtQmlIntegration>
#include <QTime>

QT_BEGIN_NAMESPACE
class QGeoPositionInfo;
QT_END_NAMESPACE

class Controller : public QObject
{
    Q_OBJECT
    Q_DISABLE_COPY_MOVE(Controller)

    Q_PROPERTY(QAbstractItemModel* model READ getModel NOTIFY modelUpdated FINAL)
    Q_PROPERTY(double lastStrikeDistance READ getLastStrikeDistance NOTIFY lastStrikeInfoUpdated FINAL)
    Q_PROPERTY(int lastStrikeTime READ getLastStrikeTime NOTIFY lastStrikeInfoUpdated FINAL)
    Q_PROPERTY(double lastStrikeDirection READ getLastStrikeDirection NOTIFY lastStrikeInfoUpdated FINAL)
    Q_PROPERTY(bool distanceTimeLayerEnabled READ isDistanceTimeLayerEnabled WRITE setDistanceTimeLayerEnabled NOTIFY distanceTimeLayerEnabledChanged FINAL)

    QML_NAMED_ELEMENT(LightningController)
    QML_SINGLETON

public:
    explicit Controller(QObject *parent = nullptr);
    ~Controller() override;

    QAbstractItemModel *getModel();

private:
    int getLastStrikeTime();
    double getLastStrikeDistance();
    double getLastStrikeDirection();
    void setDistanceTimeLayerEnabled(bool enabled);
    bool isDistanceTimeLayerEnabled() const;
    void updateDistanceTime();
    void updateDistanceTime(const LightningItemData &data);

private slots:
    void onDataReceived(const LightningItemData &data);
    void onUserPositionChanged(const QGeoPositionInfo &position);

signals:
    void lastStrikeInfoUpdated();
    void modelUpdated();
    void distanceTimeLayerEnabledChanged();

private:
    LastStrikeInfo m_lastStrikeInfo;
    LightningItemModel m_model;
    LightningProvider m_provider;
    std::unique_ptr<QGeoPositionInfoSource> m_sourcePosition;
    QGeoCoordinate m_userLocation;
    bool m_distanceTimeLayerEnabled {false};
};

#endif // CONTROLLER_H
