/****************************************************************************
**
** Copyright (C) 2022 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the documentation of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

#include "testwindow.h"

//! [0]
#include <QtGui/QGuiApplication>
//! [0]
#include <QDebug>

#if defined(Q_OS_UNIX)
#if QT_VERSION < 0x060000
#include <QtX11Extras/QX11Info>
#endif
#endif

#include <X11/Xlib.h>
#include <xcb/xcb.h>

TestWindow::TestWindow(QWindow *parent)
    : QWindow(parent)
{

#if QT_VERSION < 0x060000
    Display *display = QX11Info::display();
    xcb_connection_t *connection = QX11Info::connection();
    bool isPlatformX11 = QX11Info::isPlatformX11();
#else
//! [1]
    Display *display = nullptr;
    xcb_connection_t *connection = nullptr;
    bool isPlatformX11 = false;
    if (auto *x11Application = qGuiApp->nativeInterface<QNativeInterface::QX11Application>()) {
        display = x11Application->display();
        connection = x11Application->connection();
        isPlatformX11 = true;
    }
    // or
    // isPlatformX11 = qGuiApp->nativeInterface<QNativeInterface::QX11Application>();
//! [1]
#endif

    qDebug() << "Display *display=" << display;
    if (display)
        qDebug() << "XConnectionNumber=" << XConnectionNumber(display);

    qDebug() << "xcb_connection_t *xcbConnection=" << connection;
    if (connection) {
        const xcb_setup_t *xcbSetup = xcb_get_setup(connection);
        if (xcbSetup)
            qDebug() << "protocol_major_version=" << xcbSetup->protocol_major_version << ", protocol_minor_version=" << xcbSetup->protocol_minor_version;
    }

    qDebug() << "isPlatformX11=" << isPlatformX11;
}
