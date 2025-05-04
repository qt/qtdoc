// Copyright (C) 2025 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause
#ifndef BACKEND_H
#define BACKEND_H

#include <QtCore/QCoreApplication>
#include <QtCore/QJniObject>
#include <QtCore/QObject>
#include <QtCore/QOperatingSystemVersion>
#include <QtCore/QString>
#include <QtCore/private/qandroidextras_p.h>
#include <QtQml/qqml.h>
#include <QtGui/qguiapplication.h>

#include <qtjenny_output/jenny/proxy/android_app_ActivityProxy.h>
#include <qtjenny_output/jenny/proxy/android_app_BuilderProxy.h>
#include <qtjenny_output/jenny/proxy/android_app_NotificationChannelProxy.h>
#include <qtjenny_output/jenny/proxy/android_app_NotificationManagerProxy.h>
#include <qtjenny_output/jenny/proxy/android_app_NotificationProxy.h>
#include <qtjenny_output/jenny/proxy/android_content_IntentProxy.h>
#include <qtjenny_output/jenny/proxy/android_drawable_drawableProxy.h>
#include <qtjenny_output/jenny/proxy/android_media_AudioManagerProxy.h>
#include <qtjenny_output/jenny/proxy/android_os_ContextProxy.h>
#include <qtjenny_output/jenny/proxy/android_os_PowerManagerProxy.h>
#include <qtjenny_output/jenny/proxy/android_os_VibrationEffectProxy.h>
#include <qtjenny_output/jenny/proxy/android_os_VibratorManagerProxy.h>
#include <qtjenny_output/jenny/proxy/android_os_VibratorProxy.h>
#include <qtjenny_output/jenny/proxy/android_os_WakeLockProxy.h>
#include <qtjenny_output/jenny/proxy/android_provider_GlobalProxy.h>
#include <qtjenny_output/jenny/proxy/android_provider_SettingsProxy.h>
#include <qtjenny_output/jenny/proxy/android_provider_SystemProxy.h>
#include <qtjenny_output/jenny/proxy/android_view_LayoutParamsProxy.h>
#include <qtjenny_output/jenny/proxy/android_view_WindowProxy.h>

class BackEnd : public QObject
{
    Q_OBJECT
    QML_ELEMENT

public:
    explicit BackEnd(QObject *parent = nullptr);

    enum class Direction {
        Down = 0,
        Up = 1
    };

    Q_ENUM(Direction)

    Q_INVOKABLE void disableFullWakeLock();
    Q_INVOKABLE void disablePartialWakeLock();
    Q_INVOKABLE void notify();
    Q_INVOKABLE void setFullWakeLock();
    Q_INVOKABLE void setPartialWakeLock();
    Q_INVOKABLE void vibrate();
    Q_INVOKABLE void adjustBrightness(enum Direction);
    Q_INVOKABLE void adjustVolume(enum Direction);

    Q_PROPERTY(bool isFixedVolume READ isFixedVolume CONSTANT)

    bool isFixedVolume() const
    { return m_audioManager.isVolumeFixed(); }

signals:
    void showPopup(const QString &volumeDisabledReason);

private:
    const int m_systemVersion = QOperatingSystemVersion::current().version().majorVersion();

    static constexpr int vibrateTimeInMillisecs = 1000;
    static constexpr int maxBrightness = 245;
    static constexpr int minBrightness = 10;
    static constexpr double brightnessStep = 10.0 / 255;

    void createNotification();
    void handleVolumeError(const QString &problem, const QString &solution);

    QNativeInterface::QAndroidApplication *m_qAndroidApp;
    android::app::ActivityProxy m_activityContext;
    android::app::NotificationManagerProxy m_notificationManager;
    android::app::NotificationProxy m_notification;
    android::media::AudioManagerProxy m_audioManager;
    android::os::ContextProxy m_context;
    android::os::WakeLockProxy m_partialWakeLock;
    android::provider::GlobalProxy m_global;
    android::provider::SystemProxy m_system;
    android::view::LayoutParamsProxy m_layoutParams;
    android::view::WindowProxy m_window;
};
#endif // BACKEND_H
