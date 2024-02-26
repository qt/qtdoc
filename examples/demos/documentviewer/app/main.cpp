// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#include "mainwindow.h"
#include <QApplication>
#include <QCommandLineParser>
#include <QMessageBox>

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

    // Start application only if plugins are available
    if (!w.hasPlugins()) {
        QMessageBox::critical(nullptr,
                              "No viewer plugins found"_L1,
                              "Unable to load viewer plugins. Exiting application."_L1);
        return 1;
    }

    w.show();
    if (!fileName.isEmpty())
        w.openFile(fileName);

    return app.exec();
}
