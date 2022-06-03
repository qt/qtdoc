// Copyright (C) 2017 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause
import QtQuick 2.4
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import Coffee 1.0

Item {
    id: root
    width: Constants.width
    height: Constants.height
    clip: true
    property string coffeeName: qsTr("Cappucino")
    property alias cup: cup

    state: "initial state"

    Rectangle {
        id: rectangle
        color: Constants.backgroundColor
        anchors.fill: parent

        CupForm {
            id: cup
            x: 256
            y: 96
            anchors.horizontalCenterOffset: 150
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            questionVisible: false
            coffeeLabel: ""
            showLabels: false
            milkAmount: 0
            coffeeAmount: 0
            sugarAmount: 0
        }
    }
    Text {
        id: brewLabel

        color: "#ffffff"
        text: qsTr("Making ") + root.coffeeName
        anchors.topMargin: Constants.defaultMargin
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        font.family: Constants.fontFamily
        wrapMode: Text.WrapAnywhere
        font.pixelSize: 64
        font.capitalization: Font.AllUppercase
    }
    states: [
        State {
            name: "coffee"

            PropertyChanges {
                target: cup
                coffeeAmount: 4
            }
        },
        State {
            name: "milk"
            PropertyChanges {
                target: cup
                milkAmount: 6
                coffeeAmount: 4
            }

            PropertyChanges {
                target: brewLabel
                text: root.coffeeName + qsTr(" Ready")
            }
        }
    ]
}
