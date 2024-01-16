// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#ifndef CONTROLLER_H
#define CONTROLLER_H

#include "data/laststrikeinfo.h"
#include "models/lightningitemmodel.h"
#include "providers/lightningprovider.h"

#include <QObject>
#include <QTime>

QT_BEGIN_NAMESPACE
class QGeoPositionInfo;
class QGeoPositionInfoSource;
QT_END_NAMESPACE

class Controller : public QObject
{
    Q_OBJECT
    Q_DISABLE_COPY_MOVE(Controller)

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
    LastStrikeInfo m_lastStrikeInfo;
    LightningItemModel m_model;
    LightningProvider m_provider;
    std::unique_ptr<QGeoPositionInfoSource> m_sourcePosition;
    QGeoCoordinate m_userLocation;

};

#endif // CONTROLLER_H
