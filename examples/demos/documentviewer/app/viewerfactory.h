// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#ifndef VIEWERFACTORY_H
#define VIEWERFACTORY_H

#include <QString>
#include <QMimeType>
#include <QObject>
#include <QMap>

class AbstractViewer;
class QWidget;
class QMainWindow;
class Questions;
class QFile;
class ViewerFactory
{
public:
    enum class DefaultPolicy {
        NeverDefault,
        DefaultToTxtViewer,
        DefaultToCustomViewer
    };

    explicit ViewerFactory(QWidget *displayWidget, QMainWindow *mainWindow,
                           DefaultPolicy policy = DefaultPolicy::DefaultToTxtViewer);
    ~ViewerFactory();

    DefaultPolicy defaultPolicy() const { return m_defaultPolicy; }
    void setDefaultPolicy(DefaultPolicy policy) { m_defaultPolicy = policy; }

    AbstractViewer *viewer(QFile *file) const;


    typedef QMap<QString, AbstractViewer *> ViewerMap;
    typedef QList<AbstractViewer *> ViewerList;
    QStringList viewerNames(bool showDefault = false) const;
    ViewerList viewers() const;
    AbstractViewer *findViewer(const QString &viewerName) const;
    AbstractViewer *defaultViewer() const;
    QStringList supportedMimeTypes() const;

private:
    DefaultPolicy m_defaultPolicy;
    QWidget *m_displayWidget;
    QMainWindow *m_mainWindow;
    ViewerMap m_viewers;
    AbstractViewer *m_defaultViewer = nullptr;

    void loadViewerPlugins();
    void addViewer(QObject *viewerObject);
    AbstractViewer *viewer(const QMimeType &type) const;
    void unload();
};

#endif // VIEWERFACTORY_H
