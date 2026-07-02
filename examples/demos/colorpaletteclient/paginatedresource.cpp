// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#include "paginatedresource.h"

#include <QRestAccessManager>
#include <QRestReply>

#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QUrlQuery>

using namespace Qt::StringLiterals;

static constexpr auto totalPagesField = "total_pages"_L1;
static constexpr auto currentPageField = "page"_L1;
static constexpr auto resourceId = "/%1"_L1;

PaginatedResource::PaginatedResource(QObject *parent)
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
    QUrlQuery query{{"page"_L1, QString::number(m_currentPage)}};
    const QNetworkRequest request = m_api->createRequest(m_path, query);
    const QString requestString = request.url().toDisplayString();

    qCDebug(lcExample).noquote() << "GET" << requestString << "...";
    m_manager->get(request, this, [this, requestString](QRestReply &reply) {
        qCDebug(lcExample).noquote() << "GET" << requestString << "returned:" << reply;
        if (const auto json = reply.readJson()) {
            refreshRequestFinished(*json);
        } else {
            emit errorOccurred(reply.errorString());
            refreshRequestFailed();
        }
    });
}

void PaginatedResource::refreshRequestFinished(const QJsonDocument &json)
{
    m_data.clear();
    const QJsonArray data = json["data"_L1].toArray();
    for (const auto &entry : data)
        m_data.append(entry.toObject());
    m_pages = json[totalPagesField].toInt();
    m_currentPage = json[currentPageField].toInt();
    qCDebug(lcExample) << "Received" << m_data.size() << "items for" << m_path << "- page"
                       << m_currentPage << "of" << m_pages;
    emit pageUpdated();
    emit pagesUpdated();
    emit dataUpdated();
}

void PaginatedResource::refreshRequestFailed()
{
    if (m_currentPage != 1) {
        // A failed refresh. If we weren't on page 1, try that.
        // Last resource on currentPage might have been deleted, causing a failure
        setPage(1);
    } else {
        // Refresh failed and we we're already on page 1 => clear data
        m_pages = 0;
        emit pagesUpdated();
        if (!m_data.isEmpty()) {
            m_data.clear();
            emit dataUpdated();
        }
    }
}

void PaginatedResource::update(const QVariantMap &data, int id)
{
    const QNetworkRequest request =
            m_api->createRequest(m_path + resourceId.arg(QString::number(id)));
    const QString requestString = request.url().toDisplayString();

    qCDebug(lcExample).noquote() << "PUT" << requestString << "...";
    m_manager->put(request, data, this, [this, requestString](QRestReply &reply) {
        qCDebug(lcExample) << "PUT" << requestString << "returned:" << reply;
        if (reply.isSuccess())
            refreshCurrentPage();
    });
}

void PaginatedResource::add(const QVariantMap &data)
{
    const QNetworkRequest request = m_api->createRequest(m_path);
    const QString requestString = request.url().toDisplayString();

    qCDebug(lcExample).noquote() << "POST" << requestString << "...";
    m_manager->post(request, data, this, [this, requestString](QRestReply &reply) {
        qCDebug(lcExample) << "POST" << requestString << "returned:" << reply;
        if (reply.isSuccess())
            refreshCurrentPage();
    });
}

void PaginatedResource::remove(int id)
{
    const QNetworkRequest request =
            m_api->createRequest(m_path + resourceId.arg(QString::number(id)));
    const QString requestString = request.url().toDisplayString();

    qCDebug(lcExample).noquote() << "DELETE" << requestString << "...";
    m_manager->deleteResource(request, this, [this, requestString](QRestReply &reply) {
        qCDebug(lcExample) << "DELETE" << requestString << "returned:"
                           << reply;
        if (reply.isSuccess())
            refreshCurrentPage();
    });
}
