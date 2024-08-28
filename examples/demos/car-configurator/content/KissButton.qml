// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Controls
import QtQuick.Studio.Effects
import "doorIcon"
import QtQuick.Studio.DesignEffects

Rectangle {
    id: root

    property bool menubutton: false

    radius: 8

    width: 132
    height: 98
    color: root.checked ? "#ffffff"
                        : mouseArea.containsPress ? "#2cde85"
                                                  : mouseArea.containsMouse ? "#00414a" : "#66000000"

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
        font.family: "Titillium Web"
        font.pointSize: 16
        color: root.checked ? "black" : "white"
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 23
    }

    Icons {
        id: iconsON

        currentStateIndex: iconId
        anchors.verticalCenterOffset: -16
        anchors.centerIn: parent
    }

    Item {
        id: __materialLibrary__
    }

    DesignEffect {
        backgroundLayer: view3D
        backgroundBlurRadius: 40
    }
    states: [
        State {
            name: "Normal"
            when: !menubutton
        },
        State {
            name: "Menu"
            when: menubutton

            PropertyChanges {
                target: iconsON
                anchors.verticalCenterOffset: 0
                anchors.horizontalCenterOffset: 0
            }
        }
    ]
}
