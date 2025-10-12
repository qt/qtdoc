// Copyright (C) 2025 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#include <QFontDatabase>
#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QFontDatabase::addApplicationFont(":/fonts/DynaPuff/DynaPuff-VariableFont_wdth,wght.ttf");
    QFontDatabase::addApplicationFont(":/fonts/WinkySans/WinkySans-VariableFont_wght.ttf");
    QFontDatabase::addApplicationFont(":/fonts/WinkySans/WinkySans-Italic-VariableFont_wght.ttf");

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("ToyCustomizer", "Main");

    return app.exec();
}
