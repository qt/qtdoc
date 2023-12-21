// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Controls

PinchArea {
    anchors.fill: parent

    onPinchUpdated: pinchEvent => {
        const threshold = 0.008
        if (pinchEvent.previousScale - pinchEvent.scale > threshold
         || pinchEvent.previousScale - pinchEvent.scale < -1 * threshold) {
            let velocity = (pinchEvent.previousScale - pinchEvent.scale) > 0 ? 1.25 : -1.25
            sceneCamera2.fieldOfView += velocity * (sceneCamera2.fieldOfView + velocity > 0.0)
                                                 * (sceneCamera2.fieldOfView + velocity < 120.0)
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        preventStealing: false
        cursorShape: Qt.SizeAllCursor
        drag.axis: Drag.YAxis

        Connections {
            target: mouseArea

            onWheel: wheel => {
                sceneCamera2.fieldOfView += wheel.angleDelta.y * 0.04
                * (sceneCamera2.fieldOfView + wheel.angleDelta.y * 0.04 > 0.0)
                * (sceneCamera2.fieldOfView + wheel.angleDelta.y * 0.04 < 120.0)
            }
        }
    }
}
