/****************************************************************************
**
** Copyright (C) 2015 The Qt Company Ltd.
** Contact: http://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

#ifdef QT_3DCORE_LIB
#include "scenehelper.h"
#endif
#include "gauge.h"
#include "qtiviclusterdata.h"
#include "circularindicator.h"

#include <QtQml/QQmlApplicationEngine>
#include <QtGui/QFont>
#include <QtGui/QFontDatabase>
#include <QtGui/QGuiApplication>
#include <QtQuick/QQuickView>

#include "etcprovider.h"
#ifdef STATIC
#include <QtPlugin>
#include <QQmlExtensionPlugin>

Q_IMPORT_PLUGIN(QtQuick2Plugin)
Q_IMPORT_PLUGIN(QtQuickScene3DPlugin)
Q_IMPORT_PLUGIN(Qt3DQuick3DCorePlugin)
Q_IMPORT_PLUGIN(Qt3DQuick3DRenderPlugin)
#endif

int main(int argc, char **argv)
{
    qputenv("QT_QPA_EGLFS_HIDECURSOR", "1");
    qputenv("QT_QPA_EGLFS_DISABLE_INPUT", "1");
//  qputenv("QT_QPA_EGLFS_INTEGRATION", "eglfs_viv");
    qputenv("FB_MULTI_BUFFER", "2");
    qputenv("QT_QPA_EGLFS_WIDTH", "1280");
    qputenv("QT_QPA_EGLFS_HEIGHT", "480");
    qputenv("QT_QPA_EGLFS_PHYSICAL_WIDTH", "1280");
    qputenv("QT_QPA_EGLFS_PHYSICAL_HEIGHT", "480");
    qputenv("QT_QPA_FONTDIR", ".");
//  iPad Air, iPad Air 2, iPad Pro (9.7 inch), iPad Pro (12.9 inch), iPad Retina
//  qputenv("QT_SCALE_FACTOR", "0.8");
//  iPhone 5, iPhone 5s, iPhone 6, iPhone 6 Plus, iPhone 6s, iPhone 6s Plus, iPhone 7, iPhone 7 Plus, iPhone SE
//  qputenv("QT_SCALE_FACTOR", "0.44");

#ifdef STATIC
    qobject_cast<QQmlExtensionPlugin*>(qt_static_plugin_QtQuick2Plugin().instance())->registerTypes("QtQuick");
    qobject_cast<QQmlExtensionPlugin*>(qt_static_plugin_QtQuickScene3DPlugin().instance())->registerTypes("QtQuick.Scene3D");
    qobject_cast<QQmlExtensionPlugin*>(qt_static_plugin_Qt3DQuick3DCorePlugin().instance())->registerTypes("Qt3D.Core");
    qobject_cast<QQmlExtensionPlugin*>(qt_static_plugin_Qt3DQuick3DRenderPlugin().instance())->registerTypes("Qt3D.Render");
#endif
    QGuiApplication app(argc, argv);

#ifdef QT_3DCORE_LIB
    qmlRegisterType<SceneHelper>("Qt3D.Examples", 2, 0, "SceneHelper");
#endif
    qmlRegisterType<QtIVIClusterData>("ClusterDemoData", 1, 0, "ClusterData");
    qmlRegisterType<Gauge>("ClusterDemo", 1, 0, "GaugeFiller");
    qmlRegisterType<CircularIndicator>("ClusterDemo", 1, 0, "CircularIndicator");
    qmlRegisterSingletonType(QUrl("qrc:/qml/ValueSource.qml"), "ClusterDemo", 1, 0, "ValueSource");

    QQuickView view;

    EtcProvider *etcProvider = new EtcProvider();
    etcProvider->setBaseUrl(QUrl("qrc:///images/"));
    view.engine()->addImageProvider("etc", etcProvider);

    view.setColor(QColor(Qt::black));
    view.setWidth(1280);
    view.setHeight(480);
    view.engine()->addImportPath("qrc:/imports/");

    bool sportsCar = false;
    if (app.arguments().count() > 1)
        sportsCar = app.arguments().at(1) == "sports";

    if (sportsCar)
        view.setSource(QUrl("qrc:/qml/dash_sports/DashboardFrame.qml"));
    else
        view.setSource(QUrl("qrc:/qml/dash_hybrid/DashboardFrame.qml"));

    view.show();
    return app.exec();
}
