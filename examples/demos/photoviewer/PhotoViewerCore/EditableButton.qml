// Copyright (C) 2016 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick

Item {
    id: container

    property string label
    signal clicked

    width: textInput.width + 70 ; height: textInput.height + 18

    BorderImage {
        anchors { fill: container; leftMargin: -6; topMargin: -6; rightMargin: -8; bottomMargin: -8 }
        source: 'images/box-shadow.png';
        border.left: 10; border.top: 10; border.right: 10; border.bottom: 10
    }

    Image { anchors.fill: parent; source: "images/cardboard.png"; antialiasing: true }

    TextInput {
        id: textInput; text: label; font.pixelSize: 15; anchors.centerIn: parent
        Keys.onReturnPressed: {
            container.label = textInput.text
            container.focus = true
        }
        Keys.onEnterPressed: {
            container.label = textInput.text
            container.focus = true
        }
        Keys.onEscapePressed: {
            textInput.text = container.label
            container.focus = true
        }
    }

    Rectangle {
        anchors.fill: container; border.color: "steelblue"; border.width: 4
        color: "transparent"; visible: textInput.focus; antialiasing: true
    }

    MouseArea {
        anchors { fill: parent; leftMargin: -20; topMargin: -20; rightMargin: -20; bottomMargin: -20 }
        onClicked: { textInput.forceActiveFocus(); Qt.inputMethod.show(); }
    }
}
