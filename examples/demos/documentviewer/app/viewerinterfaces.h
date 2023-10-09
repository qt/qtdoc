// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#ifndef VIEWERINTERFACES_H
#define VIEWERINTERFACES_H

#include "abstractviewer.h"

#include <QtPlugin>

class ViewerInterface : public AbstractViewer
{
public:
    virtual ~ViewerInterface() = default;
};

QT_BEGIN_NAMESPACE
#define ViewerInterface_iid "org.qt-project.Qt.Examples.DocumentViewer.ViewerInterface/1.0"
Q_DECLARE_INTERFACE(ViewerInterface, ViewerInterface_iid)
QT_END_NAMESPACE

#endif //VIEWERINTERFACES_H
