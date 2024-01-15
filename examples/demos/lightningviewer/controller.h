// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#ifndef CONTROLLER_H
#define CONTROLLER_H

#include "models/lightningitemmodel.h"

#include <QObject>
#include <QTime>

QT_BEGIN_NAMESPACE
class QGeoPositionInfo;
class QGeoPositionInfoSource;
QT_END_NAMESPACE

class LightningProvider;
struct LastStrikeInfo;

class Controller : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QAbstractItemModel* model READ getModel NOTIFY modelUpdated FINAL)
    Q_PROPERTY(double lastStrikeDistance
                   READ getLastStrikeDistance
                       NOTIFY lastStrikeInfoUpdated FINAL)
    Q_PROPERTY(int lastStrikeTime
                   READ getLastStrikeTime
                       NOTIFY lastStrikeInfoUpdated FINAL)
    Q_PROPERTY(double lastStrikeDirection
                   READ getLastStrikeDirection
                       NOTIFY lastStrikeInfoUpdated FINAL)

public:
    explicit Controller(QObject *parent = nullptr);
    ~Controller() override;

    QAbstractItemModel *getModel();

private:
    int getLastStrikeTime();
    double getLastStrikeDistance();
    double getLastStrikeDirection();
    void updateDistanceTime(const LightningItemData &data);

private slots:
    void onDataReceived(const LightningItemData &data);
    void onUserPositionChanged(const QGeoPositionInfo &position);

signals:
    void lastStrikeInfoUpdated();
    void modelUpdated();

private:
    QScopedPointer<LastStrikeInfo> m_lastStrikeInfo;
    QScopedPointer<LightningItemModel> m_model;
    QScopedPointer<LightningProvider> m_provider;
    QScopedPointer<QGeoPositionInfoSource> m_sourcePosition;
    QScopedPointer<QGeoCoordinate> m_userLocation;
};

#endif // CONTROLLER_H
