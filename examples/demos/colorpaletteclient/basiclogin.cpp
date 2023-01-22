// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#include "util.h"
#include "basiclogin.h"
#include "restaccessmanager.h"
#include <QtNetwork/qnetworkreply.h>
#include <QtCore/qjsonobject.h>

using namespace Qt::StringLiterals;

static constexpr auto tokenField = "token"_L1;
static constexpr auto emailField = "email"_L1;
static constexpr auto idField = "id"_L1;

BasicLogin::BasicLogin(QObject* parent)
    : AbstractResource(parent)
{
}

QString BasicLogin::user() const
{
    return m_user ? m_user->email : QString{};
}

bool BasicLogin::loggedIn() const
{
    return m_user.has_value();
}

void BasicLogin::login(const QVariantMap& data)
{
    RestAccessManager::ResponseCallback callback =
            [this,  data](QNetworkReply* reply, bool success) {
        if (success)
            loginRequestFinished(reply, data);
    };
    m_manager->post(m_loginPath, data, callback);
}

void BasicLogin::loginRequestFinished(QNetworkReply* reply, const QVariantMap& data)
{
    std::optional<QJsonObject> json = byteArrayToJsonObject(reply->readAll());
    if (json && json->contains(tokenField)) {
        m_user = User{data.value(emailField).toString(),
                      json->value(tokenField).toVariant().toByteArray(),
                      data.value(idField).toInt()};
    } else {
        m_user.reset();
    }
    m_manager->setAuthorizationToken(m_user ? m_user->token : ""_ba);
    emit userChanged();
}

void BasicLogin::logout()
{
    RestAccessManager::ResponseCallback callback = [this](QNetworkReply* reply, bool success) {
        if (success)
            logoutRequestFinished(reply);
    };
    m_manager->post(m_logoutPath, {}, callback);
}

void BasicLogin::logoutRequestFinished(QNetworkReply* reply)
{
    Q_UNUSED(reply);
    m_user.reset();
    emit userChanged();
}
