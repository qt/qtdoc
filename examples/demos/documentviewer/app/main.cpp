// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#include "mainwindow.h"
#include <QApplication>
#include <QCommandLineParser>

using namespace Qt::StringLiterals;

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    QCoreApplication::setOrganizationName("QtProject"_L1);
    QCoreApplication::setApplicationName("DocumentViewer"_L1);
    QCoreApplication::setApplicationVersion("1.0"_L1);

    QCommandLineParser parser;
    parser.setApplicationDescription(QApplication::translate("main",
                                                     "A viewer for JSON, PDF and text files"));
    parser.addHelpOption();
    parser.addVersionOption();
    parser.addPositionalArgument("File"_L1, QApplication::translate("main",
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
