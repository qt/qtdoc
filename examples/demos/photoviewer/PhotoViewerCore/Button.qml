// Copyright (C) 2016 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick

Item {
    id: container

    property alias label: labelText.text
    property color tint: "transparent"
    signal clicked

    width: labelText.width + 70 ; height: labelText.height + 18

    BorderImage {
        anchors { fill: container; leftMargin: -6; topMargin: -6; rightMargin: -8; bottomMargin: -8 }
        source: 'images/box-shadow.png'
        border.left: 10; border.top: 10; border.right: 10; border.bottom: 10
    }

    Image { anchors.fill: parent; source: "images/cardboard.png"; antialiasing: true }

    Rectangle {
        anchors.fill: container; color: container.tint; visible: container.tint != ""
        opacity: 0.25
    }

    Text { id: labelText; font.pixelSize: 15; anchors.centerIn: parent }

    MouseArea {
        anchors { fill: parent; leftMargin: -20; topMargin: -20; rightMargin: -20; bottomMargin: -20 }
        onClicked: container.clicked()
    }
}
