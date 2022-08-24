// Copyright (C) 2022 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#include "restaccessmanager.h"

#include <QJsonArray>
#include <QJsonDocument>
#include <QNetworkReply>

static std::optional<QJsonArray> byteArrayToJsonArray(const QByteArray &arr)
{
    QJsonParseError err;
    const auto json = QJsonDocument::fromJson(arr, &err);
    if (err.error || !json.isArray())
        return std::nullopt;
    return json.array();
}

RestAccessManager::RestAccessManager(const QString &host, quint16 port) : host(host), port(port)
{
    //! [Connect QNetworkAccessManager example]
    manager.connectToHost(host, port);
    manager.setAutoDeleteReplies(true);
    QObject::connect(&manager, &QNetworkAccessManager::finished, this,
                     &RestAccessManager::readContacts);
    //! [Connect QNetworkAccessManager example]
    this->updateContacts();
}

RestAccessManager::~RestAccessManager() = default;

void RestAccessManager::setAuthorizationHeader(const QString &key, const QString &value)
{
    authHeader = AuthHeader{ key, value };
}

RestAccessManager::ContactsMap RestAccessManager::getContacts() const
{
    QMutexLocker lock(&contactsMtx);
    return contacts;
}

//! [POST contacts example]
void RestAccessManager::addContact(const ContactEntry &entry)
{
    auto request = QNetworkRequest(QUrl(QString("%1:%2/v2/contact").arg(host).arg(port)));
    request.setHeader(QNetworkRequest::KnownHeaders::ContentTypeHeader, "application/json");
    if (authHeader) {
        request.setRawHeader(authHeader->key.toLatin1(), authHeader->value.toLatin1());
    }
    manager.post(request, QJsonDocument(entry.toJson()).toJson(QJsonDocument::Compact));
}
//! [POST contacts example]

void RestAccessManager::updateContact(const ContactEntry &entry)
{
    auto request =
            QNetworkRequest(QUrl(QString("%1:%2/v2/contact/%3").arg(host).arg(port).arg(entry.id)));
    request.setHeader(QNetworkRequest::KnownHeaders::ContentTypeHeader, "application/json");
    if (authHeader) {
        request.setRawHeader(authHeader->key.toLatin1(), authHeader->value.toLatin1());
    }
    manager.put(request, QJsonDocument(entry.toJson()).toJson(QJsonDocument::Compact));
}

void RestAccessManager::deleteContact(qint64 id)
{
    auto request =
            QNetworkRequest(QUrl(QString("%1:%2/v2/contact/%3").arg(host).arg(port).arg(id)));
    if (authHeader) {
        request.setRawHeader(authHeader->key.toLatin1(), authHeader->value.toLatin1());
    }
    manager.deleteResource(request);
}

//! [Update contacts signal example]
void RestAccessManager::readContacts(QNetworkReply *reply)
{
    if (reply->error()) {
        return;
    }
    const std::optional<QJsonArray> array = byteArrayToJsonArray(reply->readAll());
    if (array) {
        ContactsMap tmpContacts;
        for (const auto &jsonValue : *array) {
            if (jsonValue.isObject()) {
                const QJsonObject obj = jsonValue.toObject();
                if (obj.contains("id") && obj.contains("name") && obj.contains("address")) {
                    tmpContacts.insert(obj.value("id").toInt(),
                                       ContactEntry{ obj.value("id").toInt(),
                                                     obj.value("name").toString(),
                                                     obj.value("address").toString() });
                }
            }
        }
        {
            QMutexLocker lock(&contactsMtx);
            contacts.swap(tmpContacts);
        }
        emit contactsChanged();
    } else {
        this->updateContacts();
    }
}
//! [Update contacts signal example]

//! [GET contacts example]
void RestAccessManager::updateContacts()
{
    auto request = QNetworkRequest(QUrl(QString("%1:%2/v2/contact").arg(host).arg(port)));
    request.setHeader(QNetworkRequest::KnownHeaders::ContentTypeHeader, "application/json");
    manager.get(request);
}
//! [GET contacts example]
