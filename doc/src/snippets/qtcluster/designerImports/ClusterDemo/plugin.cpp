/****************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the plugins of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:LGPL$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 3 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPL3 included in the
** packaging of this file. Please review the following information to
** ensure the GNU Lesser General Public License version 3 requirements
** will be met: https://www.gnu.org/licenses/lgpl-3.0.html.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 2.0 or (at your option) the GNU General
** Public license version 3 or any later version approved by the KDE Free
** Qt Foundation. The licenses are as published by the Free Software
** Foundation and appearing in the file LICENSE.GPL2 and LICENSE.GPL3
** included in the packaging of this file. Please review the following
** information to ensure the GNU General Public License requirements will
** be met: https://www.gnu.org/licenses/gpl-2.0.html and
** https://www.gnu.org/licenses/gpl-3.0.html.
**
** $QT_END_LICENSE$
**
****************************************************************************/

#include "../../etcprovider.h"
#include "../../circularindicator.h"
#include "../../gauge.h"

#include <QtQml/qqmlextensionplugin.h>

#include <QDebug>

class ClusterDemoPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT

    Q_PLUGIN_METADATA(IID QQmlExtensionInterface_iid)
public:
    ClusterDemoPlugin(QObject *parent = 0) : QQmlExtensionPlugin(parent) {}
    void registerTypes(const char *) Q_DECL_OVERRIDE
    {
        qmlRegisterType<CircularIndicator>("ClusterDemo", 1, 0, "CircularIndicator");
        qmlRegisterType<Gauge>("ClusterDemo", 1, 0, "GaugeFiller");
        qmlRegisterSingletonType(QUrl("qrc:/ValueSource.qml"), "ClusterDemo", 1, 0, "ValueSource");
    }

    void initializeEngine(QQmlEngine *engine, const char *uri) Q_DECL_OVERRIDE
    {
        EtcProvider *etcProvider = new EtcProvider();
        etcProvider->setBaseUrl(QUrl("qrc:///images/"));
        engine->addImageProvider("etc", etcProvider);
        QQmlExtensionPlugin::initializeEngine(engine, uri);
    }
};

#include "plugin.moc"
