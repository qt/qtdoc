// Copyright (C) 2022 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#include "addressbookmodel.h"
#include "restaccessmanager.h"

#include <QCommandLineParser>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QCommandLineParser parser;
    parser.addOptions({
            { "host", QCoreApplication::translate("main", "Hostname of the server."), "host" },
            { "port", QCoreApplication::translate("main", "Port of the server."), "port" },
    });
    parser.addHelpOption();
    parser.process(app);

    if (parser.value("host").isEmpty() || parser.value("port").isEmpty())
        parser.showHelp(-1);

    QQmlApplicationEngine engine;
    auto manager = QSharedPointer<RestAccessManager>::create(parser.value("host"),
                                                             parser.value("port").toInt());
    AddressBookModel model(manager);
    engine.setInitialProperties({ { "addressBookModel", QVariant::fromValue(&model) } });

    engine.load(QUrl("qrc:/qml/main.qml"));
    if (engine.rootObjects().isEmpty())
        return -1;

    return QGuiApplication::exec();
}
