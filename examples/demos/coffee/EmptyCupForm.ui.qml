// Copyright (C) 2017 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import Coffee

Item {
    id: root
    width: Constants.width
    height: Constants.height
    property alias continueButton: continueButton

    state: "initial state"

    Rectangle {
        id: rectangle
        color: Constants.backgroundColor
        anchors.fill: parent

        Image {
            id: image
            x: 284
            y: 174
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            source: "images/cup structure/coffee_cup_outline.png"
        }
    }

    Text {
        id: brewLabel
        x: 84
        y: 26
        color: "#ffffff"
        text: qsTr("Please insert cup into tray")
        anchors.horizontalCenter: parent.horizontalCenter
        font.family: Constants.fontFamily
        wrapMode: Text.WrapAnywhere
        font.pixelSize: 64
        font.capitalization: Font.AllUppercase
    }

    NavigationButton {
        id: continueButton
        x: 324
        y: 650
        text: "Continue"
        anchors.bottomMargin: Constants.defaultMargin
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
    }
}
