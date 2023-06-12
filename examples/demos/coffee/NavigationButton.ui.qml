// Copyright (C) 2017 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause
import QtQuick
import Coffee

Row {
    id: row

    signal clicked

    property alias text: brewLabel.text

    property bool forward: true
    layoutDirection: row.forward ? Qt.LeftToRight : Qt.RightToLeft

    spacing: 17

    Text {
        id: brewLabel
        color: "#ffffff"
        text: qsTr("Brew Me a CUP")
        font.family: Constants.fontFamily
        wrapMode: Text.WrapAnywhere
        font.pixelSize: 64
        font.capitalization: Font.AllUppercase
    }

    Image {
        id: image

        anchors.verticalCenter: parent.verticalCenter
        source: row.forward ? "images/ui controls/buttons/go/white.png" : "images/ui controls/buttons/back/white.png"
        scale: mouseArea.containsMouse ? 1.1 : 1
        MouseArea {
            id: mouseArea
            hoverEnabled: true

            anchors.fill: parent
            Connections {
                function onClicked(mouse) {
                    row.clicked()
                }
            }
        }
    }
}
