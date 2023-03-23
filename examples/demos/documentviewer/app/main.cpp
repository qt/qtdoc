// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#include "mainwindow.h"
#include <QApplication>
#include <QCommandLineParser>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    QApplication::setOrganizationName(QApplication::translate("main", "QtExamples"));
    QApplication::setApplicationName(QApplication::translate("main", "DocumentViewer"));
    QApplication::setApplicationVersion("1.0");

    QCommandLineParser parser;
    parser.setApplicationDescription(QApplication::translate("main",
                                                     "A viewer for JSON, PDF and text files"));
    parser.addHelpOption();
    parser.addVersionOption();
    parser.addPositionalArgument("File", QApplication::translate("main",
                                                                 "JSON, PDF or text file to open"));
    parser.process(app);

    const QStringList &positionalArguments = parser.positionalArguments();
    const QString &fileName = (positionalArguments.count() > 0) ? positionalArguments.at(0)
                                                                : QString();

    MainWindow w;
    w.show();
    if (!fileName.isEmpty())
        w.openFile(fileName);

    return app.exec();
}
