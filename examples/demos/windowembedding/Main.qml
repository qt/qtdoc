// Copyright (C) 2024 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick

//! [qt-quick]
Window {
    title: "Qt Quick"
    color: "#2CDE85"

    required property QtObject calendarWindow;

    property int contentsMargins: 20

    minimumWidth: calendarWindow.minimumWidth + contentsMargins * 2
    minimumHeight: calendarWindow.minimumHeight + contentsMargins * 2

    WindowContainer {
        id: calendar
        window: calendarWindow
        width: window.minimumWidth
        height: window.minimumHeight
        anchors.centerIn: parent
    }
}
//! [qt-quick]
