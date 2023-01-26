// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#ifndef VIEWERFACTORY_H
#define VIEWERFACTORY_H

class AbstractViewer;
class QWidget;
class QMainWindow;
class Questions;
class QFile;
class ViewerFactory
{
public:
    ViewerFactory() = delete;
    static AbstractViewer *makeViewer(QFile *file, QWidget *displayWidget, QMainWindow *mainWindow);
};

#endif // VIEWERFACTORY_H
