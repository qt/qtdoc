// Copyright (C) 2022 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#ifndef RESTACCESSMANAGER_H
#define RESTACCESSMANAGER_H

#include "contactentry.h"

#include <QMap>
#include <QMutex>
#include <QNetworkAccessManager>
#include <QObject>
#include <QString>

#include <optional>

class RestAccessManager : public QObject
{
    Q_OBJECT
    struct AuthHeader
    {
        QString key;
        QString value;
    };

public:
    using ContactsMap = QMap<qint64, ContactEntry>;

    explicit RestAccessManager(const QString &host, quint16 port);
    ~RestAccessManager();

    void setAuthorizationHeader(const QString &key, const QString &value);
    ContactsMap getContacts() const;

    void addContact(const ContactEntry &entry);
    void updateContact(const ContactEntry &entry);
    void deleteContact(qint64 id);

signals:
    void contactsChanged();

private slots:
    void readContacts(QNetworkReply *reply);

private:
    void updateContacts();

    const QString host;
    const quint16 port;
    std::optional<AuthHeader> authHeader;
    QNetworkAccessManager manager;
    mutable QMutex contactsMtx;
    ContactsMap contacts;
};

#endif // RESTACCESSMANAGER_H
