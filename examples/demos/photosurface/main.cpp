// Copyright (C) 2017 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#include <QCommandLineOption>
#include <QCommandLineParser>
#include <QDebug>
#include <QDir>
#include <QGuiApplication>
#include <QImageReader>
#include <QMimeDatabase>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickWindow>
#include <QStandardPaths>
#include <QUrl>

static QStringList imageNameFilters()
{
    QStringList result;
    QMimeDatabase mimeDatabase;
    const auto supportedMimeTypes = QImageReader::supportedMimeTypes();
    for (const QByteArray &m : supportedMimeTypes) {
        const auto suffixes = mimeDatabase.mimeTypeForName(m).suffixes();
        for (const QString &suffix : suffixes)
            result.append(QLatin1String("*.") + suffix);
    }
    return result;
}

// Note: C++ main() is optional! You can alternatively run the qml on the command line:
// $ qml photosurface.qml -- /path/to/my/images

int main(int argc, char* argv[])
{

    QGuiApplication app(argc, argv);
    QCoreApplication::setApplicationName(QStringLiteral("Photosurface"));
    QCoreApplication::setOrganizationName(QStringLiteral("QtProject"));
    QCoreApplication::setApplicationVersion(QLatin1String(QT_VERSION_STR));
    QCommandLineParser parser;
    parser.setApplicationDescription(QStringLiteral("Qt Quick Demo - Photo Surface"));
    parser.addHelpOption();
    parser.addVersionOption();
    parser.addPositionalArgument(QStringLiteral("directory"),
                                 QStringLiteral("The image directory or URL to show."));
    parser.process(app);

    QQmlApplicationEngine engine;
    engine.load(QUrl("qrc:/qt/qml/photosurface/photosurface.qml"));
    if (engine.rootObjects().isEmpty())
        return -1;

    // imageNameFilters has a default list in the QML, but Qt often supports more image formats
    engine.rootObjects().first()->setProperty("imageNameFilters", imageNameFilters());

    return app.exec();
}
