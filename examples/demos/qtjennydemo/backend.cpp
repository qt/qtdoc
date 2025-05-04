// Copyright (C) 2025 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#include "backend.h"

BackEnd::BackEnd(QObject *parent) : QObject{ parent }
{
    using namespace android::os;
    using namespace android::app;

    // Initialize members
    m_qAndroidApp = qGuiApp->nativeInterface<QNativeInterface::QAndroidApplication>();
    m_context = ContextProxy(m_qAndroidApp->context());
    m_activityContext = ActivityProxy(m_qAndroidApp->context());
    PowerManagerProxy powerManager = m_activityContext.getSystemService(
        QJniObject::fromString(m_context.POWER_SERVICE).object<jstring>());
    m_audioManager = m_activityContext.getSystemService(
        QJniObject::fromString(m_context.AUDIO_SERVICE).object<jstring>());
    m_window = m_activityContext.getWindow();
    m_layoutParams = m_window.getAttributes();
    m_partialWakeLock = powerManager.newWakeLock(powerManager.PARTIAL_WAKE_LOCK,
        QJniObject::fromString("PARTIALWAKELOCK").object<jstring>());

    // If system implements a fixed volume policy, disable volume slider
    if (m_audioManager.isVolumeFixed())
        handleVolumeError("Device implements fixed volume setting.", "");

    m_qAndroidApp->runOnAndroidMainThread([&]() {
        m_layoutParams.setScreenBrightness(0.5);
        m_window.setAttributes(m_layoutParams);
    });

    createNotification();
}

void BackEnd::vibrate()
{
    using namespace android::os;

    VibrationEffectProxy effect;
    VibratorManagerProxy vibratorManager;
    VibratorProxy vibrator;

    if (m_systemVersion >= 12) {
        vibratorManager = m_activityContext.getSystemService(
            QJniObject::fromString(m_context.VIBRATOR_MANAGER_SERVICE).object<jstring>());
        vibrator = vibratorManager.getDefaultVibrator();
    } else {
        vibrator = m_activityContext.getSystemService(
            QJniObject::fromString(m_context.VIBRATOR_SERVICE).object<jstring>());
    }

    effect = VibrationEffectProxy().createOneShot(
        vibrateTimeInMillisecs, VibrationEffectProxy().DEFAULT_AMPLITUDE);
    vibrator.vibrate(effect->object<jobject>());
}

// Posts an Android notification
void BackEnd::notify()
{
    using namespace QtAndroidPrivate;

    PermissionResult result = checkPermission("android.permission.POST_NOTIFICATIONS").result();

    if (result == Authorized || m_systemVersion <= 12) {
        m_notificationManager.notify(0, m_notification);
    } else {
        requestPermission("android.permission.POST_NOTIFICATIONS").then(
            [&](PermissionResult result) {
                if (result == Denied)
                    qWarning() << "POST_NOTIFICATIONS permission was denied";
                else if (result == Authorized)
                    m_notificationManager.notify(0, m_notification);
            });
    }
}

// Adjust system volume, either lowering or raising based on given direction
void BackEnd::adjustVolume(enum Direction direction)
{
    if (m_global.getInt(m_context.getContentResolver().object<jobject>(),
                        QJniObject::fromString("zen_mode").object<jstring>()) != 0) {
        handleVolumeError("Do not Disturb mode is on",
                          "Disable Do not Disturb mode to adjust the volume");
    } else if (m_audioManager.getRingerMode() != m_audioManager.RINGER_MODE_NORMAL) {
        if (m_audioManager.getRingerMode() == m_audioManager.RINGER_MODE_VIBRATE) {
            handleVolumeError("Vibrate only mode is on",
                              "Disable vibrate only mode to adjust volume.");
        } else if (m_audioManager.getRingerMode() == m_audioManager.RINGER_MODE_SILENT) {
            handleVolumeError("Silent mode is on", "Disable Silent mode to adjust the volume.");
        }
    } else if (direction == Direction::Up) {
        m_audioManager.adjustVolume(m_audioManager.ADJUST_RAISE, m_audioManager.FLAG_SHOW_UI);
    } else if (direction == Direction::Down) {
        m_audioManager.adjustVolume(m_audioManager.ADJUST_LOWER, m_audioManager.FLAG_SHOW_UI);
    }
}

// Adjust system brightness, either lowering or raising based on given direction
void BackEnd::adjustBrightness(enum Direction direction)
{
    using namespace android::content;
    using namespace android::provider;

    IntentProxy m_intent = m_intent.newInstance(QJniObject::fromString(
        SettingsProxy::ACTION_MANAGE_WRITE_SETTINGS).object<jstring>());

    // Check if app has permission to write system settings.
    // Start an Activity with the ACTION_MANAGE_WRITE_SETTINGS intent if app
    // does not have permission to write said settings, after which user
    // has to manually give the permission to this app.
    if (!m_system.canWrite(m_context))
        m_context.startActivity(m_intent);

    int brightness = m_system.getInt(m_context.getContentResolver().object<jobject>(),
        QJniObject::fromString(m_system.SCREEN_BRIGHTNESS).object<jstring>());

    if (direction == Direction::Up) {
        if (brightness <= maxBrightness)
            brightness += 10;
    } else if (direction == Direction::Down) {
        if (brightness >= minBrightness)
            brightness -= 10;
    }

    double brightnessToDouble = brightnessStep * (brightness / 10.0);

    // We need to set the brightness to system settings and to Window separately, as
    // synchronization does not happen automatically and updating one or
    // the other only, leaves the other one out of sync.
    m_system.putInt(m_context.getContentResolver().object<jobject>(),
        QJniObject::fromString(m_system.SCREEN_BRIGHTNESS).object<jstring>(),
        brightness);
    m_qAndroidApp->runOnAndroidMainThread([this, brightness = brightnessToDouble]() {
        m_layoutParams.setScreenBrightness(brightness);
        m_window.setAttributes(m_layoutParams);
    });
}

void BackEnd::setPartialWakeLock()
{
    m_partialWakeLock.acquire(m_activityContext);
}

void BackEnd::disablePartialWakeLock()
{
    m_partialWakeLock.release(m_activityContext);
}

void BackEnd::setFullWakeLock()
{
    m_qAndroidApp->runOnAndroidMainThread([&]() {
        m_window.addFlags(m_layoutParams.FLAG_KEEP_SCREEN_ON);
    }).then([]() {
            qInfo() << "Full WakeLock set";
        });
}

void BackEnd::disableFullWakeLock()
{
    m_qAndroidApp->runOnAndroidMainThread([&]() {
        m_window.clearFlags(m_layoutParams.FLAG_KEEP_SCREEN_ON);
    }).then([]() {
            qInfo() << "Full WakeLock released";
        });
}

// Creates a notification that is later posted in notify() method
void BackEnd::createNotification()
{
    using namespace android::app;
    using namespace android::drawable;

    NotificationChannelProxy channel;
    BuilderProxy builder;

    channel = NotificationChannelProxy().newInstance(
        QJniObject::fromString("01").object<jstring>(),
        QJniObject::fromString("QtJenny").object<jstring>(),
        m_notificationManager.IMPORTANCE_HIGH);

    m_notificationManager = m_activityContext.getSystemService(
        QJniObject::fromString(m_context.NOTIFICATION_SERVICE).object<jstring>());
    m_notificationManager.createNotificationChannel(channel);

    builder = BuilderProxy().newInstance(m_context,
        QJniObject::fromString(channel.getId().toString()).object<jstring>());
    builder.setSmallIcon(drawableProxy::ic_dialog_info);
    builder.setContentTitle(QJniObject::fromString("QtJenny").object<jstring>());
    builder.setContentText(QJniObject::fromString(
                                 "Hello from QtJenny app!").object<jstring>());
    builder.setDefaults(m_notification.DEFAULT_SOUND);
    builder.setAutoCancel(true);
    m_notification = builder.build();
}

void BackEnd::handleVolumeError(const QString &problem, const QString &solution)
{
    if (!problem.isEmpty())
        qWarning() << problem;

    const QString message = problem.isEmpty() ? solution
                                              : problem + "\n" + solution;
    emit showPopup(message);
}
