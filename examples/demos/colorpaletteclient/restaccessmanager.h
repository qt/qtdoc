// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#ifndef RESTACCESSMANAGER_H
#define RESTACCESSMANAGER_H

#include <functional>
#include <QtCore/qurlquery.h>
#include <QtCore/qjsondocument.h>
#include <QtNetwork/qnetworkreply.h>
#include <QtNetwork/qnetworkaccessmanager.h>
#include <QtQml/qqml.h>

class RestAccessManager : public QNetworkAccessManager
{
    Q_OBJECT
    Q_PROPERTY(bool sslSupported READ sslSupported CONSTANT)
    QML_ANONYMOUS

public:
    explicit RestAccessManager(QObject *parent = nullptr);

    void setUrl(const QUrl& url);
    void setAuthorizationToken(const QByteArray& token);

    bool sslSupported() const;

    using ResponseCallback = std::function<void(QNetworkReply*, bool)>;
    void post(const QString& api, const QVariantMap& value, ResponseCallback callback);
    void get(const QString& api, const QUrlQuery& parameters, ResponseCallback callback);
    void put(const QString& api, const QVariantMap& value, ResponseCallback callback);
    void deleteResource(const QString& api, ResponseCallback callback);

private:
    QUrl m_url;
    QByteArray m_authorizationToken;
};

#endif // RESTACCESSMANAGER_H
