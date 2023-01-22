// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#include "restservice.h"
#include "abstractresource.h"
#include "restaccessmanager.h"

RestService::RestService(QObject* parent) : QObject(parent)
{
    m_manager = std::make_shared<RestAccessManager>();
}

RestAccessManager* RestService::network() const
{
    return m_manager.get();
}

void RestService::setUrl(const QUrl& url)
{
    if (m_url == url)
         return;
    m_url = url;
    m_manager->setUrl(url);
    emit urlChanged();
}

QUrl RestService::url() const
{
    return m_url;
}

QQmlListProperty<AbstractResource> RestService::resources()
{
    return {this, &m_resources};
}

void RestService::classBegin()
{
}

void RestService::componentComplete()
{
    for (const auto resource : std::as_const(m_resources))
        resource->setAccessManager(m_manager);
}
