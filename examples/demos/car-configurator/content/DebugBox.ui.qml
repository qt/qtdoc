// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only WITH Qt-GPL-exception-1.0

import QtQuick
import QtQuick3D

Rectangle {
    id: root

    property int fps: sView.renderStats.fps
    property int frameTime: sView.renderStats.frameTime
    property int syncTime: sView.renderStats.syncTime
    property int renderTime: sView.renderStats.renderTime

    required property View3D sView

    width: col.width
    height: col.height
    radius: 8
    color: "#99000000"

    Column {
        id: col

        padding: 15

        Text {
            color: "#ffffff"
            text: root.fps + " FPS (" + root.frameTime + " ms)"
            font.pixelSize: 24
        }

        Text {
            color: "#ffffff"
            text: "Sync: " + root.syncTime + " ms"
                + "\nRender: " + root.renderTime + " ms"
            font.pixelSize: 18
        }
    }

    Item {
        id: __materialLibrary__
    }
}
