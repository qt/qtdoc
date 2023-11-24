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
    spacing: -circle.height / 2
    rotation: 180
    property alias button: button
    property alias rectangle: rectangle
    property alias circle: circle
    property string coffeeName: ""
    property string ingredients: ""
    property int time: 4
    property int cupsLeft: 0
    states: [
        State {
            name: "portrait"
            when: applicationFlow.mode == "portrait"
            PropertyChanges {
                target: rectangle
                implicitHeight: applicationFlow.height / 3.6
                implicitWidth: applicationFlow.width / 2.4
            }
        },
        State {
            name: "landscape"
            when: applicationFlow.mode == "landscape"
            PropertyChanges {
                target: rectangle
                implicitHeight: applicationFlow.height / 2
                implicitWidth: applicationFlow.width / 6
            }
        }
    ]

    Rectangle {
        id: rectangle
        radius: 8
        gradient: Colors.invertedGreyBorder
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
                PropertyChanges { target: rectangle; scale: 0.9 }
                PropertyChanges { target: circle; scale: 0.9 }
                PropertyChanges { target: rectangle; gradient: Colors.invertedGreenBorder }
                PropertyChanges { target: circle; gradient: Colors.invertedGreenBorder }
            }

            transitions: Transition {
                NumberAnimation { properties: "scale"; duration: 50; easing.type: Easing.InOutQuad }
            }
            //! [AbstractButton]
            contentItem: Rectangle {
                id: rectangle2
                anchors.fill: parent
                color: Colors.currentTheme.cardColor
                radius: 8
                ColumnLayout {
                    rotation: 180
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width / 1.19
                    height: parent.height - circle.height / 2
                    Text {
                        text: coffeeName
                        color: Colors.currentTheme.textColor
                        font.weight: 700
                        font.pixelSize: 18
                        Layout.alignment: Qt.AlignHCenter
                        wrapMode: Text.Wrap

                    }
                    Text {
                        text: ingredients
                        color: Colors.currentTheme.caption
                        Layout.alignment: Qt.AlignHCenter
                        Layout.maximumWidth: parent.width
                        wrapMode: Text.Wrap
                    }
                    Text {
                        text: "Time"
                        font.pointSize: 12
                        color: Colors.currentTheme.caption
                        wrapMode: Text.Wrap
                    }
                    RowLayout {
                        Layout.bottomMargin: 12
                        Text {
                            Layout.fillWidth: true
                            text: time + " Mins"
                            font.pixelSize: 14
                            font.family: "Titillium Web"
                            color: Colors.currentTheme.textColor
                        }
                        Rectangle {
                            width: 24
                            height: 24
                            color: Colors.currentTheme.cardColor
                            border.color: "#898989"
                            border.width: 1
                            radius: 8
                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.verticalCenter: parent.verticalCenter
                                text: cupsLeft
                                font.pixelSize: 12
                                font.weight: 600
                                color: "#1FC974"
                            }
                        }
                    }
                }
                Rectangle {
                    id: outOfDialog
                    width: rectangle.width / 1.5
                    height: rectangle.height / 5
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
                source: rectangle2
                anchors.fill: rectangle2
                shadowEnabled: true
                shadowColor: "white"
                shadowOpacity: (cupsLeft != 0) ? 0.5 : 0.0
            }
        }
    }
    Rectangle {
        id: circle
        anchors.horizontalCenter: parent.horizontalCenter
        implicitHeight: implicitWidth
        implicitWidth: rectangle.implicitWidth / 1.36
        radius: width * 0.5
        gradient: Colors.invertedGreyBorder
        Rectangle {
            id: circle2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            height: width
            width: parent.width - 2
            radius: width * 0.5
            color: Colors.currentTheme.cardColor
            Image {
                source: (Colors.currentTheme == Colors.dark) ? "./images/Cups/card_cup_dark.svg" : "./images/Cups/card_cup_light.svg"
                sourceSize.width: circle.width / 2.2
                sourceSize.height: circle.height / 1.9
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                rotation: 180
            }

        }
        MultiEffect {
            source: circle2
            anchors.fill: circle2
            shadowEnabled: true
            shadowColor: "white"
            shadowOpacity: (cupsLeft != 0) ? 0.5 : 0.0
        }
    }
}
