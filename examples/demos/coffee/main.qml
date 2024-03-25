// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause
import QtQuick
import QtQuick.Controls
//! [Set application window size]
ApplicationWindow {
    visible: true
    width: 1000
    height: 600
    title: qsTr("Coffee")
//! [Set application window size]
    ApplicationFlow {
        width: parent.width
        height: parent.height
        mode: (Screen.height > Screen.width) ? "portrait" : "landscape"
    }
}
