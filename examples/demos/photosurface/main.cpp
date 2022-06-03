// Copyright (C) 2017 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#ifdef QT_WIDGETS_LIB
#include <QtWidgets/QApplication>
#else
#include <QtGui/QGuiApplication>
#endif
#include <QtQml/QQmlApplicationEngine>
#include <QtQml/QQmlContext>
#include <QtQuick/QQuickWindow>
#include <QtGui/QImageReader>
#include <QtCore/QCommandLineParser>
#include <QtCore/QCommandLineOption>
#include <QtCore/QDebug>
#include <QtCore/QDir>
#include <QtCore/QMimeDatabase>
#include <QtCore/QStandardPaths>
#include <QtCore/QUrl>

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

int main(int argc, char* argv[])
{
    // The reason to use QApplication is that QWidget-based dialogs
    // are the native dialogs on Qt-based platforms like KDE,
    // but they cannot be instantiated if this is a QGuiApplication.
#ifdef QT_WIDGETS_LIB
    QApplication app(argc, argv);
#else
    QGuiApplication app(argc, argv);
#endif

    QQuickWindow::setDefaultAlphaBuffer(true);

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

    QUrl initialUrl;
    if (!parser.positionalArguments().isEmpty()) {
        initialUrl = QUrl::fromUserInput(parser.positionalArguments().first(),
                                         QDir::currentPath(), QUrl::AssumeLocalFile);
        if (!initialUrl.isValid()) {
            qWarning().nospace() << "Invalid argument: \""
                << parser.positionalArguments().first() << "\": " << initialUrl.errorString();
            return 1;
        }
    }

    const QStringList nameFilters = imageNameFilters();

    QQmlApplicationEngine engine;
    QQmlContext *context = engine.rootContext();

    QUrl picturesLocationUrl = QUrl::fromLocalFile(QDir::homePath());
    const QStringList picturesLocations = QStandardPaths::standardLocations(QStandardPaths::PicturesLocation);
    if (!picturesLocations.isEmpty()) {
        picturesLocationUrl = QUrl::fromLocalFile(picturesLocations.first());
        if (initialUrl.isEmpty()
            && !QDir(picturesLocations.first()).entryInfoList(nameFilters, QDir::Files).isEmpty()) {
            initialUrl = picturesLocationUrl;
        }
    }

    context->setContextProperty(QStringLiteral("contextPicturesLocation"), picturesLocationUrl);
    context->setContextProperty(QStringLiteral("contextInitialUrl"), initialUrl);
    context->setContextProperty(QStringLiteral("contextImageNameFilters"), nameFilters);

    engine.load(QUrl("qrc:///photosurface.qml"));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
