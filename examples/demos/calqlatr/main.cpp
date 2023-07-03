// Copyright (C) 2020 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#include <QGuiApplication>
#include <QQmlEngine>
#include <QQmlFileSelector>
#include <QQuickView>
#include <QQuickStyle>

int main(int argc, char *argv[])
{
    QCoreApplication::setOrganizationName("QtProject");
    QCoreApplication::setApplicationName("Calqlatr");

    QGuiApplication app(argc, argv);

    QQuickStyle::setStyle("Basic");

    QQuickView view;
    view.connect(view.engine(), &QQmlEngine::quit, &app, &QCoreApplication::quit);
    view.setSource(QUrl("qrc:/demos/calqlatr/calqlatr.qml"));
    if (view.status() == QQuickView::Error)
        return -1;
    view.setResizeMode(QQuickView::SizeRootObjectToView);
    view.show();
    return app.exec();
}
