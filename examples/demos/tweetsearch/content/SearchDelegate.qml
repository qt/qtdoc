// Copyright (C) 2017 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick

FlipBar {
    id: flipBar
    animDuration: 250
    property string label: ""
    property string placeHolder: ""
    property alias searchText: lineInput.text
    property alias prefix: lineInput.prefix
    property bool opened: false
    signal ok
    signal hasOpened

    height: 60
    width: parent.width

    function open() {
        flipBar.flipUp()
        flipBar.opened = true
        lineInput.forceActiveFocus()
        flipBar.hasOpened()
    }

    function close() {
        if (opened) {
            flipBar.flipDown()
            flipBar.opened = false
        }
    }

    front: Rectangle {
        height: 60
        width: parent.width
        color: "#999999"

        Rectangle { color: "#c1c1c1"; width: parent.width; height: 1 }
        Rectangle { color: "#707070"; width: parent.width; height: 1; anchors.bottom: parent.bottom }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            onClicked: {
                if (!flipBar.opened)
                    open()
                else if (!lineInput.activeFocus)
                    lineInput.forceActiveFocus()
                else
                    close()
            }
        }

        Text {
            text: flipBar.label
            anchors { left: parent.left; leftMargin: 20 }
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 18
            color: "#ffffff"
        }
    }

    back: FocusScope {
        height: 60
        width: parent.width
        Rectangle {
            anchors.fill: parent
            color: "#999999"

            Rectangle { color: "#c1c1c1"; width: parent.width; height: 1 }
            Rectangle { color: "#707070"; width: parent.width; height: 1; anchors.bottom: parent.bottom }

            LineInput {
                id: lineInput
                hint: flipBar.placeHolder
                focus: flipBar.opened
                anchors { fill: parent; margins: 6 }
                onAccepted: {
                    if (Qt.inputMethod.visible)
                        Qt.inputMethod.hide()
                    flipBar.ok()
                }
            }
        }
    }

}
