// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Controls.Fusion
import QtQuick.Layouts
import Config

Menu {
    id: menuPopup
    padding: 0
    verticalPadding: 15

    property alias openUrlMenuItem: openUrlMenuItem
    property alias openFileMenuItem: openFileMenuItem

    background: Rectangle {
        color: Config.mainColor
        radius: 15
        border.color: "#41CD52"
    }

    component MenuItemLabel: Label {
        font.pixelSize: 24
        color: "#41CD52"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        topPadding: 4
        bottomPadding: 4
    }

    component CustomMenuItem: MenuItem {
        id: menuItem

        property bool bold

        text: qsTr("File")
        contentItem: MenuItemLabel {
            text: menuItem.text
            font.bold: menuItem.bold
        }

        background: Rectangle {
            color: menuItem.pressed ? "#41CD52" : "transparent"
            opacity: 0.25
        }
    }

    MenuItemLabel {
        text: qsTr("Load media file from:")
        color: Config.secondaryColor
        bottomPadding: 12

        width: parent.width
    }

    Rectangle {
        width: parent.width
        implicitHeight: 1
        color: "#41CD52"
        opacity: 0.25
    }

    CustomMenuItem {
        id: openFileMenuItem
        text: qsTr("File")
        bold: true
    }

    Rectangle {
        width: parent.width
        implicitHeight: 1
        color: "#41CD52"
        opacity: 0.25
    }

    CustomMenuItem {
        id: openUrlMenuItem
        text: qsTr("URL")
        bold: true
    }

    Rectangle {
        implicitHeight: 1
        color: "#41CD52"

        Layout.fillWidth: true
    }

    CustomMenuItem {
        id: cancelButtonBackground
        text: qsTr("Cancel")
    }
}
