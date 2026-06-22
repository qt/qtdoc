// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QGuiApplication>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
#ifdef Q_OS_MACOS
    engine.addImportPath(app.applicationDirPath() + "/../PlugIns");
#endif
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed, &app,
                     [](){ QCoreApplication::exit(EXIT_FAILURE);}, Qt::QueuedConnection);
    engine.loadFromModule("ColorPalette", "Main");

    return QGuiApplication::exec();
}
