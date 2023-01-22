// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#ifndef RESTSERVICE_H
#define RESTSERVICE_H

#include "abstractresource.h"

#include <QtQml/qqml.h>
#include <QtQml/qqmlparserstatus.h>
#include <QtNetwork/qnetworkaccessmanager.h>
#include <QtNetwork/qnetworkreply.h>
#include <QtCore/qobject.h>
#include <QtCore/qstring.h>
#include <QtCore/qjsonobject.h>

class RestAccessManager;

class RestService : public QObject, public QQmlParserStatus
{
    Q_OBJECT
    Q_PROPERTY(RestAccessManager* network READ network CONSTANT)
    Q_PROPERTY(QUrl url READ url WRITE setUrl NOTIFY urlChanged)
    Q_PROPERTY(QQmlListProperty<AbstractResource> resources READ resources)
    Q_CLASSINFO("DefaultProperty", "resources")
    Q_INTERFACES(QQmlParserStatus)
    QML_ELEMENT

public:
    explicit RestService(QObject* parent = nullptr);
    ~RestService() override = default;

    RestAccessManager* network() const;

    QUrl url() const;
    void setUrl(const QUrl& url);

    void classBegin() override;
    void componentComplete() override;

    QQmlListProperty<AbstractResource> resources();

signals:
    void urlChanged();

private:
    QUrl m_url;
    QList<AbstractResource*> m_resources;
    std::shared_ptr<RestAccessManager> m_manager;
};

#endif // RESTSERVICE_H
