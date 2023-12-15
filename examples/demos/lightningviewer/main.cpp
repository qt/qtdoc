// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#include "controller.h"

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    Q_INIT_RESOURCE(resources);
    Q_INIT_RESOURCE(lv_style);

    Controller controller;

    QQmlApplicationEngine engine;
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    QQmlContext *context = engine.rootContext();
    context->setContextProperty("LightningController", &controller);

    engine.loadFromModule("LightningViewer", "LightningView");

    return app.exec();
}
