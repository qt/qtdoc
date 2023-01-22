// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#include <QtQml/qqmlapplicationengine.h>
#include <QtQml/qqmlcontext.h>
#include <QtGui/qguiapplication.h>
#include <QtGui/qicon.h>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QIcon::setThemeName("colorpaletteclient");

    QQmlApplicationEngine engine;
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed, &app,
                     [](){ QCoreApplication::exit(EXIT_FAILURE);}, Qt::QueuedConnection);
    engine.loadFromModule("ColorPalette", "MainWindow");

    return QGuiApplication::exec();
}
