// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QCommandLineParser>
#include <QDir>

using namespace Qt::Literals::StringLiterals;

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QCoreApplication::setApplicationName("MediaPlayer Example");
    QCoreApplication::setOrganizationName("QtProject");
    QCoreApplication::setApplicationVersion(QT_VERSION_STR);
    QCommandLineParser parser;
    parser.setApplicationDescription(QCoreApplication::translate("main", "Qt Quick MediaPlayer Example"));
    parser.addHelpOption();
    parser.addVersionOption();
    parser.addPositionalArgument("url", QCoreApplication::translate("main", "The URL(s) to open."));
    parser.process(app);

    QQmlApplicationEngine engine;
    QObject::connect(&engine, &QQmlApplicationEngine::quit, &app, &QGuiApplication::quit);

    QUrl source;
    if (!parser.positionalArguments().isEmpty())
        source = QUrl::fromUserInput(parser.positionalArguments().at(0), QDir::currentPath());

    QVariantMap initialProperties{
        {"source", source}
    };

    engine.setInitialProperties(initialProperties);
    engine.loadFromModule("MediaPlayerModule", "Main");

    return app.exec();
}
