// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Controls

Button {
    id: button
    property bool dimmable: false
    property bool dimmed: false
    property color textColor: "#eceeea"

    width: 30
    height: 50
    contentItem: Text {
        text: button.text
        font.pixelSize: 48
        wrapMode: Text.WordWrap
        lineHeight: 0.75
        color: (button.dimmable && button.dimmed) ? Qt.darker(button.textColor) : button.textColor
        Behavior on color {
            ColorAnimation {
                duration: 120
                easing.type: Easing.OutElastic
            }
        }
        states: [
            State {
                name: "pressed"
                when: button.pressed && !button.dimmed
                PropertyChanges {
                    target: button.contentItem
                    color: Qt.lighter(button.textColor)
                }
            }
        ]
    }

    background: null
}
