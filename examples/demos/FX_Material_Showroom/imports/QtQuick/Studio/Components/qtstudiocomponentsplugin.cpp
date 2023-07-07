// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#include <QtQml/qqmlextensionplugin.h>

class QtStudioComponentsPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID QQmlExtensionInterface_iid)

public:
    QtStudioComponentsPlugin(QObject *parent = nullptr);
    void registerTypes(const char *uri) override;
};

QtStudioComponentsPlugin::QtStudioComponentsPlugin(QObject *parent)
    : QQmlExtensionPlugin(parent) { }

void QtStudioComponentsPlugin::registerTypes(const char *) { }

#include "qtstudiocomponentsplugin.moc"
