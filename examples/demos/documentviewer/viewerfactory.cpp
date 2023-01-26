// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#include <QWidget>
#include <QMimeDatabase>
#include <QMimeType>
#include "viewerfactory.h"

#include "abstractviewer.h"
#include "pdfviewer.h"
#include "txtviewer.h"
#include "jsonviewer.h"

AbstractViewer *ViewerFactory::makeViewer(QFile *file, QWidget *displayWidget,
                                          QMainWindow *mainWindow)
{
    Q_ASSERT(file);

    const QFileInfo info(*file);
    QMimeDatabase db;
    const auto mimeType = db.mimeTypeForFile(info);

    if (mimeType.inherits("application/json"))
        return  new JsonViewer(file, displayWidget, mainWindow);
    if (mimeType.inherits("text/plain"))
        return  new TxtViewer(file, displayWidget, mainWindow);
    if (mimeType.inherits("application/pdf"))
        return new PdfViewer(file, displayWidget, mainWindow);

    // Default to text viewer
    return new TxtViewer(file, displayWidget, mainWindow);
}
