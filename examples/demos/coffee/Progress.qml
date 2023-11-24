// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects

Item {
    // Height, width and any other size related properties containing odd looking float or other dividers
    // that do not seem to have any logical origin are just arbitrary and based on original design
    // and/or personal preference on what looks nice.
    id: root
    property alias grid: grid
    property alias timer: timer
    property alias greenBar: greenBar
    property alias cup: cup
    property int brewTime
    property int maxCoffee
    property int maxmilk
    property int maxFoam
    property int coffeeAmount
    property int milkAmount
    property int foamAmount
    property double sugarAmount
    property double progressBarValue: 0

    states: [
        State {
            name: "portrait"
            PropertyChanges {
                target: cup
                Layout.alignment: Qt.AlignCenter | Qt.AlignTop
                Layout.preferredWidth: height / 1.16
                Layout.preferredHeight: root.height / 3
            }
            PropertyChanges {
                target: dialog
                Layout.preferredWidth: root.width / 1.12
                Layout.preferredHeight: root.height / 7
            }
        },
        State {
            name: "landscape"
            PropertyChanges {
                target: grid
                rowSpacing: 10

            }
            PropertyChanges {
                target: cup
                Layout.alignment: Qt.AlignCenter | Qt.AlignTop
                Layout.preferredWidth: height / 1.16
                Layout.preferredHeight: root.height / 2.5
            }
            PropertyChanges {
                target: dialog
                Layout.preferredWidth: root.width / 2.5
                Layout.preferredHeight: root.height / 5
                Layout.minimumHeight: 70
                Layout.minimumWidth: 400
            }
            PropertyChanges {
                target: control
                Layout.bottomMargin: 10

            }
        }
    ]
    //! [Timer]
    Timer {
        id: timer
        interval: brewTime
        running: true
        onTriggered: {
            applicationFlow.onFinished()
        }
    }
    //! [Timer]
    //! [Behavior]
    Behavior on greenBar.width {
        SmoothedAnimation {
            easing.type: Easing.Linear
            velocity: (contentItem.width / brewTime) * 1000
        }
    }
    //! [Behavior]
    GridLayout {
        id: grid
        rowSpacing: 20
        anchors.horizontalCenter: parent.horizontalCenter
        flow: GridLayout.TopToBottom
        //! [Cup]
        Cup {
            id: cup
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            state: "0"
            states: [
                State {
                    name: "0"
                    PropertyChanges {
                        target: cup
                        coffeeAmount: 0
                    }
                    PropertyChanges {
                        target: cup
                        milkAmount: 0
                    }
                    PropertyChanges {
                        target: cup
                        foamAmount: 0
                    }
                    PropertyChanges {
                        target: cup
                        sugarAmount: 0
                    }
                },
                State {
                    name: "1"
                    PropertyChanges {
                        target: cup
                        coffeeAmount: root.coffeeAmount
                    }
                    PropertyChanges {
                        target: cup
                        milkAmount: root.milkAmount
                    }
                    PropertyChanges {
                        target: cup
                        foamAmount: root.foamAmount
                    }
                    PropertyChanges {
                        target: cup
                        sugarAmount: root.sugarAmount
                    }
                }
            ]
            transitions: Transition {
                from: "0"
                to: "1"
                SmoothedAnimation {
                    target: cup
                    property: "coffeeAmount"
                    velocity: (coffeeAmount / brewTime) * 1200
                }
                SmoothedAnimation {
                    target: cup
                    property: "milkAmount"
                    velocity: (milkAmount / brewTime) * 1200
                }
                SmoothedAnimation {
                    target: cup
                    property: "foamAmount"
                    velocity: (foamAmount / brewTime) * 1200
                }
                SmoothedAnimation {
                    target: cup
                    property: "sugarAmount"
                    velocity: (sugarAmount / brewTime) * 1200
                }

            }
        }
        //! [Cup]
        Rectangle {
            id: dialog
            radius: 8
            Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
            gradient: Colors.greyBorder
            Rectangle {
                id: rectangle
                width: parent.width - 2
                height: parent.height - 2
                radius: 8
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                color: Colors.currentTheme.cardColor
                Text {
                    text: "Your Coffee is preparing, Please Wait!"
                    color: Colors.currentTheme.textColor
                    font.pixelSize: 18
                    font.weight: 600
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
            MultiEffect {
                source: rectangle
                anchors.fill: rectangle
                shadowEnabled: true
                shadowColor: "white"
                shadowOpacity: 0.5
            }
        }
        ProgressBar {
            id: control
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            value: progressBarValue
            Layout.topMargin: 20
            background: Rectangle {
                implicitHeight: 2
                color: "#e6e6e6"
            }

            contentItem: Item {
                id: contentItem
                implicitWidth: dialog.width / 1.5
                implicitHeight: 2
                Rectangle {
                    id: greenBar
                    width: control.visualPosition * parent.width
                    height: parent.height
                    color: "#1FC974"
                }
                Image {
                    id: circle
                    source: (Colors.currentTheme == Colors.dark) ? "./images/icons/ellipse_dark.svg" : "./images/icons/ellipse_light.svg"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.left
                }
                Image {
                    id: circle2
                    source: (Colors.currentTheme == Colors.dark) ? "./images/icons/ellipse_dark.svg" : "./images/icons/ellipse_light.svg"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Image {
                    id: circle3
                    source: (Colors.currentTheme == Colors.dark) ? "./images/icons/ellipse_dark.svg" : "./images/icons/ellipse_light.svg"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.right
                }
                Text {
                    text: "0%"
                    font.pixelSize: 12
                    anchors.horizontalCenter: circle.horizontalCenter
                    anchors.verticalCenter: circle.verticalCenter
                    color: Colors.currentTheme.textColor
                }
                Text {
                    text: "50%"
                    font.pixelSize: 12
                    anchors.horizontalCenter: circle2.horizontalCenter
                    anchors.verticalCenter: circle2.verticalCenter
                    color: Colors.currentTheme.textColor
                }
                Text {
                    text: "100%"
                    font.pixelSize: 12
                    anchors.horizontalCenter: circle3.horizontalCenter
                    anchors.verticalCenter: circle3.verticalCenter
                    color: Colors.currentTheme.textColor
                }
            }
        }
        Text {
            color: "#2CDE85"
            text: qsTr("Brewing...")
            Layout.alignment: Qt.AlignHCenter
            font.pixelSize: 12
            font.weight: 600
        }
    }
}
