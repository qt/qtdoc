// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#ifndef VIEWERINTERFACES_H
#define VIEWERINTERFACES_H

#include "abstractviewer.h"

#include <QtPlugin>

QT_BEGIN_NAMESPACE
class QPrinter;
QT_END_NAMESPACE

class ViewerInterface : public AbstractViewer
{
public:
    virtual ~ViewerInterface() = default;
    virtual QString viewerName() const override = 0;
    virtual QByteArray saveState() const override = 0;
    virtual bool restoreState(QByteArray &) override = 0;
    virtual bool supportsOverview() const override = 0;
    virtual bool hasContent() const override = 0;
#ifdef QT_DOCUMENTVIEWER_PRINTSUPPORT
    virtual void printDocument(QPrinter *) const override = 0;
    virtual QStringList supportedMimeTypes() const override = 0;
#endif
};

QT_BEGIN_NAMESPACE
#define ViewerInterface_iid "org.qt-project.Qt.Examples.DocumentViewer.ViewerInterface/1.0"
Q_DECLARE_INTERFACE(ViewerInterface, ViewerInterface_iid)
QT_END_NAMESPACE

#endif //VIEWERINTERFACES_H
