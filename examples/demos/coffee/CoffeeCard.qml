// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects

    // Height, width and any other size related properties containing odd looking float or other dividers
    // that do not seem to have any logical origin are just arbitrary and based on original design
    // and/or personal preference on what looks nice.
Column {
    id: root
    spacing: -coffeeCardCircle.height / 2
    rotation: 180
    property alias button: button
    property string coffeeName: ""
    property string ingredients: ""
    property int time: 4
    property int cupsLeft: 0

    states: [
        State {
            name: "portrait"
            when: applicationFlow.mode == "portrait"
            PropertyChanges {
                target: coffeeCardRectangle
                implicitHeight: (applicationFlow.stack.height / 2) - 20 - (coffeeCardCircle.height / 2)
                implicitWidth: applicationFlow.width / 2.4
            }
        },
        State {
            name: "landscape"
            when: applicationFlow.mode == "landscape"
            PropertyChanges {
                target: coffeeCardRectangle
                implicitHeight: applicationFlow.height / 2
                implicitWidth: applicationFlow.width / 5
            }
        }
    ]

    Rectangle {
        id: coffeeCardRectangle
        radius: 8
        gradient: Colors.invertedGreyBorder
        states: State {
                    name: "small"
                    when: ((Screen.height * Screen.devicePixelRatio) + (Screen.width * Screen.devicePixelRatio)) < 2900
                    PropertyChanges {
                        target: coffeeCardRectangle
                        implicitHeight: ((applicationFlow.stack.height - ((applicationFlow.width / 2.4) / 1.36)) / 2) + 40
                    }
                }
        //! [AbstractButton]
        AbstractButton {
            width: parent.width - 2
            height: parent.height - 2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            id: button
            hoverEnabled: true
            checkable: true
            enabled: (cupsLeft != 0) ? true : false
            states: State {
                name: "pressed"; when: button.pressed
                PropertyChanges { target: coffeeCardRectangle; scale: 0.9 }
                PropertyChanges { target: coffeeCardCircle; scale: 0.9 }
                PropertyChanges { target: coffeeCardRectangle; gradient: Colors.invertedGreenBorder }
                PropertyChanges { target: coffeeCardCircle; gradient: Colors.invertedGreenBorder }
            }

            transitions: Transition {
                NumberAnimation { properties: "scale"; duration: 50; easing.type: Easing.InOutQuad }
            }
            //! [AbstractButton]
            contentItem: Rectangle {
                id: innerCoffeeCardRectangle
                anchors.fill: parent
                color: Colors.currentTheme.cardColor
                radius: 8
                states: State {
                            name: "small"
                            when: ((Screen.height * Screen.devicePixelRatio) + (Screen.width * Screen.devicePixelRatio)) < 3200
                            PropertyChanges {
                                target: coffeeText
                                font.pixelSize: 14
                            }
                            PropertyChanges {
                                target: ingredientText
                                font.pixelSize: 10
                            }
                            PropertyChanges {
                                target: timeText
                                font.pointSize: 10
                            }
                            PropertyChanges {
                                target: actualTimeText
                                font.pixelSize: 10
                            }
                            PropertyChanges {
                                target: box
                                radius: 6
                                Layout.preferredHeight: 18
                                Layout.preferredWidth: 18
                            }
                            PropertyChanges {
                                target: cupsLeftText
                                font.pixelSize: 10
                            }
                        }
                ColumnLayout {
                    rotation: 180
                    anchors.top: parent.top
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width / 1.19
                    height: parent.height - (coffeeCardCircle.height / 2)
                    Text {
                        id: coffeeText
                        text: coffeeName
                        color: Colors.currentTheme.textColor
                        font.weight: 700
                        font.pixelSize: 18
                        Layout.maximumWidth: parent.width
                        Layout.alignment: Qt.AlignHCenter

                    }
                    Text {
                        id: ingredientText
                        text: ingredients
                        color: Colors.currentTheme.caption
                        Layout.alignment: Qt.AlignHCenter
                        Layout.maximumWidth: parent.width
                        wrapMode: Text.Wrap
                    }
                    Text {
                        id: timeText
                        text: "Time"
                        font.pointSize: 12
                        color: Colors.currentTheme.caption
                        wrapMode: Text.Wrap
                    }
                    RowLayout {
                        Layout.bottomMargin: 12
                        Layout.alignment: Qt.AlignBottom
                        Text {
                            id: actualTimeText
                            Layout.fillWidth: true
                            text: time + " Mins"
                            font.pixelSize: 14
                            color: Colors.currentTheme.textColor
                        }
                        Rectangle {
                            id: box
                            Layout.preferredHeight: 24
                            Layout.preferredWidth: 24
                            color: Colors.currentTheme.cardColor
                            border.color: Colors.border
                            border.width: 1
                            radius: 8
                            Text {
                                id: cupsLeftText
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.verticalCenter: parent.verticalCenter
                                text: cupsLeft
                                font.pixelSize: 12
                                font.weight: 600
                                color: Colors.green
                            }
                        }
                    }
                }
                Rectangle {
                    id: outOfDialog
                    width: coffeeCardRectangle.width / 1.5
                    height: coffeeCardRectangle.height / 5
                    visible: (cupsLeft != 0) ? false : true
                    radius: 8
                    color: (Colors.currentTheme == Colors.dark) ? Colors.light.cardColor : Colors.dark.cardColor
                    rotation: 180
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        text: "Out of " + coffeeName
                        color: (Colors.currentTheme == Colors.dark) ? Colors.light.textColor : Colors.dark.textColor
                    }
                }
            }
            MultiEffect {
                source: innerCoffeeCardRectangle
                anchors.fill: innerCoffeeCardRectangle
                shadowEnabled: true
                shadowColor: Colors.shadow
                shadowOpacity: (cupsLeft != 0) ? 0.5 : 0.0
            }
        }
    }
    Rectangle {
        id: coffeeCardCircle
        anchors.horizontalCenter: parent.horizontalCenter
        implicitHeight: implicitWidth
        implicitWidth: coffeeCardRectangle.implicitWidth / 1.36
        radius: width * 0.5
        gradient: Colors.invertedGreyBorder
        states: [
            State {
                name: "small"
                when: ((Screen.height * Screen.devicePixelRatio) + (Screen.width * Screen.devicePixelRatio)) < 3200 && ((Screen.height * Screen.devicePixelRatio) + (Screen.width * Screen.devicePixelRatio)) > 1200
                PropertyChanges {
                    target: coffeeCardCircle
                    implicitWidth: coffeeCardRectangle.implicitWidth / 1.5
                }
            },
            State {
                name: "smaller"
                when: applicationFlow.mode == "portrait" && ((Screen.height * Screen.devicePixelRatio) + (Screen.width * Screen.devicePixelRatio)) < 1200
                PropertyChanges {
                    target: coffeeCardCircle
                    implicitWidth: coffeeCardRectangle.implicitWidth / 2
                }
            }
        ]
        Rectangle {
            id: innerCoffeeCardCircle
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            height: width
            width: parent.width - 2
            radius: width * 0.5
            color: Colors.currentTheme.cardColor
            Image {
                source: (Colors.currentTheme == Colors.dark) ? "./images/Cups/card_cup_dark.svg" : "./images/Cups/card_cup_light.svg"
                sourceSize.width: coffeeCardCircle.width / 2.2
                sourceSize.height: coffeeCardCircle.height / 1.9
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                rotation: 180
            }

        }
        MultiEffect {
            source: innerCoffeeCardCircle
            anchors.fill: innerCoffeeCardCircle
            shadowEnabled: true
            shadowColor: Colors.shadow
            shadowOpacity: (cupsLeft != 0) ? 0.5 : 0.0
        }
    }
}
