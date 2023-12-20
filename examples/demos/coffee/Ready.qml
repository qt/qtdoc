// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause
import QtQuick

ReadyForm {
    property alias timer: timer

    Timer {
        id: timer
        interval: 3000
        running: true
        onTriggered: {
            applicationFlow.onReturnToStart()
        }
    }
    grid.states: [
        State {
            name: "small"
            when: ((Screen.height * Screen.devicePixelRatio)
                   + (Screen.width * Screen.devicePixelRatio)) < 2000
            PropertyChanges {
                target: grid
                rowSpacing: 10
            }
        }
    ]
    caption.states: [
        State {
            name: "small"
            when: ((Screen.height * Screen.devicePixelRatio)
                   + (Screen.width * Screen.devicePixelRatio)) < 2000
            PropertyChanges {
                target: caption
                font.pixelSize: 16
            }
        }
    ]
}
