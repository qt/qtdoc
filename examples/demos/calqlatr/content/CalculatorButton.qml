// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Controls

Button {
    id: button
    width: 60
    height: 64

    property bool dimmable: false
    property bool dimmed: false
    property color textColor: "#eceeea"

    contentItem: Text {
        text: button.text
        font.pixelSize: 48
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: button.dimmable && button.dimmed
            ? Qt.darker(button.textColor)
            : (button.pressed ? Qt.lighter(button.textColor) : button.textColor)
        Behavior on color {
            ColorAnimation {
                duration: 120
                easing.type: Easing.OutElastic
            }
        }
    }

    background: null
}
