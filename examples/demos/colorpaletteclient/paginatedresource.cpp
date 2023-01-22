// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#include "util.h"
#include "paginatedresource.h"
#include "restaccessmanager.h"
#include <QtNetwork/qnetworkreply.h>
#include <QtCore/qurlquery.h>
#include <QtCore/qjsonobject.h>
#include <QtCore/qjsonarray.h>

using namespace Qt::StringLiterals;

static constexpr auto totalPagesField = "total_pages"_L1;
static constexpr auto currentPageField = "page"_L1;
static constexpr auto resourceIdentification = "/%1"_L1;

PaginatedResource::PaginatedResource(QObject* parent)
    : AbstractResource(parent)
{
}

QList<QJsonObject> PaginatedResource::data() const
{
    return m_data;
}

int PaginatedResource::pages() const
{
    return m_pages;
}

int PaginatedResource::page() const
{
    return m_currentPage;
}

void PaginatedResource::setPage(int page)
{
    if (m_currentPage == page || page < 1)
        return;
    m_currentPage = page;
    emit pageUpdated();
    refreshCurrentPage();
}

void PaginatedResource::refreshCurrentPage()
{
    RestAccessManager::ResponseCallback callback = [this](QNetworkReply* reply, bool success) {
        if (success)
            refreshRequestFinished(reply);
    };
    QUrlQuery query;
    query.addQueryItem("page"_L1, QString::number(m_currentPage));
    m_manager->get(m_path, query, callback);
}

void PaginatedResource::refreshRequestFinished(QNetworkReply* reply)
{
    m_data.clear();
    std::optional<QJsonObject> json = byteArrayToJsonObject(reply->readAll());
    if (json) {
        QJsonArray data = json->value("data"_L1).toArray();
        for (const auto& entry : std::as_const(data))
            m_data.append(entry.toObject());
        m_pages = json->value(totalPagesField).toInt();
        m_currentPage = json->value(currentPageField).toInt();
        emit pageUpdated();
    } else if (m_currentPage != 1) {
        // An unexpected response. If we weren't on page 1, try that.
        // Last resource on currentPage might have been deleted, causing a failure
        m_pages = 0;
        setPage(1);
    }
    emit dataUpdated();
}

void PaginatedResource::update(const QVariantMap& data, int id)
{
    RestAccessManager::ResponseCallback callback = [this](QNetworkReply* reply, bool success) {
        Q_UNUSED(reply);
        if (success)
            refreshCurrentPage();
    };
    m_manager->put(m_path + resourceIdentification.arg(QString::number(id)), data, callback);
}

void PaginatedResource::add(const QVariantMap& data)
{
    RestAccessManager::ResponseCallback callback = [this](QNetworkReply* reply, bool success) {
        Q_UNUSED(reply);
        if (success)
            refreshCurrentPage();
    };
    m_manager->post(m_path, data, callback);
}

void PaginatedResource::remove(int id)
{
    RestAccessManager::ResponseCallback callback = [this](QNetworkReply* reply, bool success) {
        Q_UNUSED(reply);
        if (success)
            refreshCurrentPage();
    };
    m_manager->deleteResource(m_path + resourceIdentification.arg(QString::number(id)), callback);
}
