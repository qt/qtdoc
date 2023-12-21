// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Controls
import "FigmaExportCarConfig"

Rectangle {
    id: root

    radius: 17

    width: 144
    height: 108
    color: root.checked ? "#ffffff"
                        : mouseArea.containsPress ? "#2cde85"
                                                  : mouseArea.containsMouse ? "#00414a" : "#66111111"

    property bool checked: false
    property int iconId: 0
    property var group: null

    property alias buttonText: buttonText.text

    signal clicked

    function toggleCheck() {
        if (root.group) {
            if (root.group === "toggle") {
                root.checked = !root.checked
            } else {
                for (let i = 0; i < root.group.buttons.length; ++i) {
                    let button = root.group.buttons[i]
                    if (button !== root)
                        button.checked = false
                }
                root.checked = true
                root.group.checkedButton = root
            }
        }
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        hoverEnabled: true

        onClicked: {
            root.toggleCheck()
            root.clicked()
        }
    }

    Text {
        id: buttonText

        text: ""
        color: root.checked ? "black" : "white"
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 23
    }

    Icons {
        id: iconsON

        currentStateIndex: iconId
        anchors.verticalCenterOffset: -12
        anchors.centerIn: parent
    }

    Item {
        id: __materialLibrary__
    }
}
