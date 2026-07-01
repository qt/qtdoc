// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QGuiApplication>
#include <QQuickStyle>

#include <QCommandLineOption>
#include <QCommandLineParser>
#include <QUrl>
#include <QVariant>

using namespace Qt::StringLiterals;

static constexpr auto defaultUrl = "http://127.0.0.1:49425/api"_L1;

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QCommandLineParser parser;
    parser.setApplicationDescription(u"RESTful API client"_s);
    parser.addHelpOption();
    parser.addVersionOption();
    const QCommandLineOption urlOption(u"url"_s, u"URL to open"_s, u"url"_s, defaultUrl);
    parser.addOption(urlOption);
    parser.process(app);

    const QUrl url = QUrl::fromUserInput(parser.value(urlOption));
    if (!url.isValid()) {
        qWarning("Invalid url \"%s\": %s", qUtf8Printable(parser.value(urlOption)),
                 qUtf8Printable(url.errorString()));
        return -1;
    }

    QQuickStyle::setStyle("Fusion");

    QQmlApplicationEngine engine;
    engine.setInitialProperties({{u"serverUrl"_s, url}});

#ifdef Q_OS_MACOS
    engine.addImportPath(app.applicationDirPath() + "/../PlugIns");
#endif
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed, &app,
                     [](){ QCoreApplication::exit(EXIT_FAILURE);}, Qt::QueuedConnection);
    engine.loadFromModule("ColorPalette", "Main");

    return QGuiApplication::exec();
}
