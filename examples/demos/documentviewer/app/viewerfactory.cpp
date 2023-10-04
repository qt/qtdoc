// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#include "abstractviewer.h"
#include "viewerfactory.h"
#include "viewerinterfaces.h"

#include <QApplication>
#include <QMessageBox>
#include <QWidget>

#include <QDir>
#include <QMimeDatabase>
#include <QMimeType>
#include <QPluginLoader>
#include <QTimer>

using namespace Qt::StringLiterals;

ViewerFactory::ViewerFactory(QWidget *displayWidget, QMainWindow *mainWindow, DefaultPolicy policy)
    : m_defaultPolicy(policy),
      m_displayWidget(displayWidget),
      m_mainWindow(mainWindow)
{
    Q_ASSERT(m_displayWidget);
    Q_ASSERT(m_mainWindow);
    loadViewerPlugins();
}

ViewerFactory::~ViewerFactory()
{
    unload();
}

AbstractViewer *ViewerFactory::viewer(QFile *file) const
{
    Q_ASSERT(file);

    const QFileInfo info(*file);
    QMimeDatabase db;
    const auto mimeType = db.mimeTypeForFile(info);

    AbstractViewer *viewer = ViewerFactory::viewer(mimeType);
    if (!viewer) {
        qWarning() << "Mime type" << mimeType.name() << "not supported.";
        return nullptr;
    }

    viewer->init(file, m_displayWidget, m_mainWindow);
    return viewer;
}

void ViewerFactory::loadViewerPlugins()
{
    if (!m_viewers.isEmpty())
        return;

    // Load static plugins
    const QObjectList &staticPlugins = QPluginLoader::staticInstances();
    for (auto *plugin : staticPlugins)
        addViewer(plugin);

    // Load shared plugins
    QDir pluginsDir = QDir(QApplication::applicationDirPath());

#if defined(Q_OS_WINDOWS)
    pluginsDir.cd("app"_L1);
#elif defined(Q_OS_DARWIN)
    if (pluginsDir.dirName() == "MacOS"_L1) {
        pluginsDir.cdUp();
        pluginsDir.cdUp();
        pluginsDir.cdUp();
    }
#endif
    const auto entryList = pluginsDir.entryList(QDir::Files);
    for (const QString &fileName : entryList) {
        QPluginLoader loader(pluginsDir.absoluteFilePath(fileName));
        QObject *plugin = loader.instance();
        if (plugin)
            addViewer(plugin);
#if 0
        else
            qDebug() << loader.errorString();
#endif
    }
}

void ViewerFactory::unload()
{
    qDeleteAll(viewers());
    m_viewers.clear();
}

void ViewerFactory::addViewer(QObject *viewerObject)
{
    auto *interface = qobject_cast<ViewerInterface *>(viewerObject);
    if (!interface)
        return;

    // Set custom default viewer
    if (interface->viewer()->isDefaultViewer())
        m_defaultViewer = interface->viewer();

    m_viewers.insert(interface->viewerName(), interface->viewer());
}

QStringList ViewerFactory::viewerNames(bool showDefault) const
{
    if (!showDefault)
        return m_viewers.keys();

    QStringList list;
    for (auto it = m_viewers.constBegin(); it != m_viewers.constEnd(); ++it) {
        QString name = it.key();
        if ((m_defaultViewer && it.value()->isDefaultViewer())
             || (!m_defaultViewer && it.key() == "TxtViewer"_L1)) {
            name += "(default)"_L1;
        }
        list.append(name);
    }
    return list;
}

ViewerFactory::ViewerList ViewerFactory::viewers() const
{
    return m_viewers.values();
}

AbstractViewer *ViewerFactory::findViewer(const QString &viewerName) const
{
    const ViewerList &viewerList = viewers();
    for (auto *viewer : viewerList) {
        if (viewer->viewerName() == viewerName)
            return viewer;
    }
    qWarning() << "Plugin" << viewerName << "not loaded.";
    return nullptr;
}

AbstractViewer *ViewerFactory::viewer(const QMimeType &mimeType) const
{
    const ViewerList &viewerList = viewers();

    for (AbstractViewer *viewer : viewerList) {
        for (const QString &type : viewer->supportedMimeTypes()) {
            if (mimeType.inherits(type))
                return viewer;
        }
    }

    AbstractViewer *viewer = defaultViewer();

    if (m_defaultWarning) {
        QMessageBox mbox;
        mbox.setIcon(QMessageBox::Warning);
        mbox.setText(QObject::tr("Mime type %1 not supported. Falling back to %2.")
                     .arg(mimeType.name(), viewer->viewerName()));
        mbox.setStandardButtons(QMessageBox::Ok);
        QTimer::singleShot(8000, &mbox, [&mbox](){ mbox.close(); });
        mbox.exec();
    }

    return viewer;
}

AbstractViewer *ViewerFactory::defaultViewer() const
{
    switch (m_defaultPolicy) {
    case DefaultPolicy::NeverDefault:
        return nullptr;
    case DefaultPolicy::DefaultToCustomViewer:
        return m_defaultViewer ? m_defaultViewer : findViewer("TxtViewer"_L1);
    case DefaultPolicy::DefaultToTxtViewer:
        return findViewer("TxtViewer"_L1);
    }
    Q_UNREACHABLE();
}

QStringList ViewerFactory::supportedMimeTypes() const
{
    static QStringList mimeTypes;
    if (!mimeTypes.isEmpty())
        return mimeTypes;

    const ViewerList &viewerList = viewers();
    for (auto viewer : viewerList)
        mimeTypes.append(viewer->supportedMimeTypes());
    return mimeTypes;
}
