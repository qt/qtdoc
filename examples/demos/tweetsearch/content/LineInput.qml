// Copyright (C) 2017 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick

FocusScope {
    id: wrapper

    property alias text: input.text
    property alias hint: hint.text
    property alias prefix: prefix.text

    signal accepted

    Rectangle {
        anchors.fill: parent
        border.color: "#707070"
        color: "#c1c1c1"
        radius: 4

        Text {
            id: hint
            anchors { fill: parent; leftMargin: 14 }
            verticalAlignment: Text.AlignVCenter
            text: "Enter word"
            font.pixelSize: 18
            color: "#707070"
            opacity: input.displayText.length ? 0 : 1
        }

        Text {
            id: prefix
            anchors { left: parent.left; leftMargin: 14; verticalCenter: parent.verticalCenter }
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 18
            color: "#707070"
            opacity: !hint.opacity
        }

        TextInput {
            id: input
            focus: true
            anchors { left: prefix.right; right: parent.right; top: parent.top; bottom: parent.bottom }
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 18
            color: "#707070"
            onAccepted: wrapper.accepted()
        }

        Image {
            source: "resources/icon-search.png"
            anchors.right: parent.right
            anchors.rightMargin: 12
            anchors.verticalCenter: parent.verticalCenter
            MouseArea {
                anchors { fill: parent; margins: -10 }
                onClicked: wrapper.accepted()
            }
        }
    }
}
