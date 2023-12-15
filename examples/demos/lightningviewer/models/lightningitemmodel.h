// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#ifndef LIGHTNINGITEMMODEL_H
#define LIGHTNINGITEMMODEL_H

#include "../data/lightningitemdata.h"

#include <QAbstractListModel>

class LastStrikeInfo;

class LightningItemModel : public QAbstractListModel
{
    Q_OBJECT

public:
    explicit LightningItemModel(QObject *parent = nullptr);

    void insertData(QSharedPointer<LightningItemData> data);
    void getNearestStrikeInfo(const QGeoCoordinate &coordinate,
                              LastStrikeInfo *nearestStrikeInfo) const;
    void getLatestStrikeInfo(const QGeoCoordinate &searchCenter,
                             double searchRadius,
                             LastStrikeInfo *latestStrikeInfo) const;

private:
    // QAbstractItemModel interface
    int rowCount(const QModelIndex &parent) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;

private:
    QList<QSharedPointer<LightningItemData>> m_data;
};

#endif // LIGHTNINGITEMMODEL_H
