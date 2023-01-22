// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause
#ifndef ABSTRACTRESOURCE_H
#define ABSTRACTRESOURCE_H

#include "restaccessmanager.h"
#include <QtQml/qqml.h>
#include <QtCore/qobject.h>

class AbstractResource : public QObject
{
    Q_OBJECT
    QML_ANONYMOUS

public:
    explicit AbstractResource(QObject* parent = nullptr) : QObject (parent)
    {}

    virtual ~AbstractResource() = default;
    void setAccessManager(std::shared_ptr<RestAccessManager> manager)
    {
        m_manager = manager;
    }

protected:
    std::shared_ptr<RestAccessManager> m_manager;
};

#endif // ABSTRACTRESOURCE_H
