// Copyright (C) 2022 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#ifndef TYPES_H
#define TYPES_H

#include <QJsonObject>
#include <QString>

struct ContactEntry
{
    qint64 id;
    QString name;
    QString address;

    QJsonObject toJson() const
    {
        return QJsonObject{ { "id", id }, { "name", name }, { "address", address } };
    }

    static constexpr qsizetype size() { return 3; }

    bool operator==(const ContactEntry &other) const
    {
        return name == other.name && address == other.address;
    }
};

#endif // TYPES_H
