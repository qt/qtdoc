// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects

Item {
    // Height, width and any other size related properties containing odd looking float or other dividers, multipliers, etc.
    // that do not seem to have any logical origin are just arbitrary and based on original design
    // and/or personal preference on what looks nice.
    id: root
    property alias confirmButton: confirmButton
    property int coffeeAmount
    property int milkAmount
    property int foamAmount
    property double sugarAmount

    states: [
        State {
            name: "portrait"
            PropertyChanges {
                target: grid
                flow: GridLayout.TopToBottom
                rows: 3
                columns: 1
                rowSpacing: 20
            }
            PropertyChanges {
                target: cup
                Layout.row: 0
                Layout.preferredWidth: height / 1.16
                Layout.preferredHeight: root.height / 3
            }
            PropertyChanges {
                target: outerRectangle
                Layout.row: 1
                Layout.preferredWidth: root.width / 1.12
                Layout.preferredHeight: root.height / 2.5
            }
            PropertyChanges {
                target: confirmButton
                Layout.alignment: Qt.AlignHCenter
                Layout.row: 2
                Layout.preferredWidth: root.width / 2.2
                Layout.preferredHeight: root.height / 14
            }
        },
        State {
            name: "landscape"
            PropertyChanges {
                target: grid
                flow: GridLayout.LeftToRight
                rows: 2
                columns: 3
            }
            PropertyChanges {
                target: cup
                Layout.column: 0
                Layout.preferredWidth: height / 1.16
                Layout.preferredHeight: root.height / 1.5
            }

            PropertyChanges {
                target: outerRectangle
                Layout.preferredWidth: root.width / 2
                Layout.preferredHeight: root.height / 1.4
                Layout.leftMargin: root.width / 20
                Layout.alignment: Qt.AlignBottom
                Layout.column: 2
            }
            PropertyChanges {
                target: confirmButton
                Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
                Layout.row: 1
                Layout.columnSpan: 3
                Layout.preferredWidth: root.width / 4
                Layout.preferredHeight: root.height / 8
            }
        }
    ]
    GridLayout {
        id: grid
        flow: GridLayout.TopToBottom
        anchors.horizontalCenter: parent.horizontalCenter

        Cup {
            id:cup
            milkAmount: milkSlider.value
            coffeeAmount: coffeeSlider.value
            foamAmount: foamSlider.value
            sugarAmount: sugarSlider.position
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
        }

        Rectangle {
            id: outerRectangle
            radius: 8
            gradient: Colors.greyBorder
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            property int textPixelSize: 16
            states: [
                State {
                    name: "smallerFont"
                    when: ((Screen.height * Screen.devicePixelRatio) + (Screen.width * Screen.devicePixelRatio)) < 2000
                    PropertyChanges {
                        target: outerRectangle
                        textPixelSize: 14
                    }
                }
            ]
            Rectangle {
                id: innerRectangle
                radius: 8
                color: Colors.currentTheme.cardColor
                width: parent.width - 2
                height: parent.height - 2
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 10
                    RowLayout {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Rectangle {
                            Layout.preferredWidth: parent.width / 4
                            Layout.fillHeight: true
                            color: Colors.currentTheme.cardColor
                            Text {
                                id: coffeeText
                                anchors.left: parent.left
                                anchors.verticalCenter: parent.verticalCenter
                                text: "Coffee"
                                color: Colors.currentTheme.textColor
                                font.pixelSize: outerRectangle.textPixelSize
                            }
                        }
                        Rectangle {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            color: Colors.currentTheme.cardColor
                            CustomSlider {
                                id: coffeeSlider
                                from: 0
                                to: 100
                                value: coffeeAmount
                                liquidAmount: value
                                width: parent.width
                                height: 10
                                anchors.verticalCenter: parent.verticalCenter
                                //! [Value changed]
                                onValueChanged: {
                                    applicationFlow.coffeeAmount = value
                                }
                                //! [Value changed]
                            }
                        }

                    }
                    RowLayout {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Rectangle {
                            Layout.preferredWidth: parent.width / 4
                            Layout.fillHeight: true
                            color: Colors.currentTheme.cardColor
                            Text {
                                id: milkText
                                anchors.left: parent.left
                                anchors.verticalCenter: parent.verticalCenter
                                text: "Milk"
                                color: Colors.currentTheme.textColor
                                font.pixelSize: outerRectangle.textPixelSize
                            }
                        }
                        Rectangle {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            color: Colors.currentTheme.cardColor
                            CustomSlider {
                                id: milkSlider
                                from: 0
                                to: 60
                                value: milkAmount
                                liquidAmount: value
                                width: parent.width
                                height: 10
                                anchors.verticalCenter: parent.verticalCenter
                                onValueChanged: {
                                    applicationFlow.milkAmount = value
                                }
                            }
                        }

                    }
                    RowLayout {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Rectangle {
                            Layout.preferredWidth: parent.width / 4
                            Layout.fillHeight: true
                            color: Colors.currentTheme.cardColor
                            Text {
                                id: foamText
                                anchors.left: parent.left
                                anchors.verticalCenter: parent.verticalCenter
                                text: "Foam"
                                color: Colors.currentTheme.textColor
                                font.pixelSize: outerRectangle.textPixelSize
                            }
                        }
                        Rectangle {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            color: Colors.currentTheme.cardColor
                            CustomSlider {
                                id: foamSlider
                                from: 0
                                to: 60
                                value: foamAmount
                                liquidAmount: value
                                width: parent.width
                                height: 10
                                anchors.verticalCenter: parent.verticalCenter
                                onValueChanged: {
                                    applicationFlow.foamAmount = value
                                }
                            }
                        }

                    }
                    RowLayout {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Rectangle {
                            Layout.preferredWidth: parent.width / 4
                            Layout.fillHeight: true
                            color: Colors.currentTheme.cardColor
                            Text {
                                id: sugarText
                                anchors.left: parent.left
                                anchors.verticalCenter: parent.verticalCenter
                                text: "Sugar"
                                color: Colors.currentTheme.textColor
                                font.pixelSize: outerRectangle.textPixelSize
                            }
                        }
                        Rectangle {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            color: Colors.currentTheme.cardColor
                            Slider {
                                id: sugarSlider
                                snapMode: Slider.SnapAlways
                                stepSize: 0.25
                                value: sugarAmount
                                width: parent.width
                                height: 10
                                anchors.verticalCenter: parent.verticalCenter
                                states: State {
                                    name: "pressed"; when: sugarSlider.pressed
                                    PropertyChanges { target: handle; scale: 1.1 }
                                }

                                transitions: Transition {
                                    NumberAnimation { properties: "scale"; duration: 10; easing.type: Easing.InOutQuad }
                                }
                                onValueChanged: {
                                    applicationFlow.sugarAmount = value
                                }
                                background: Rectangle {
                                    x: sugarSlider.leftPadding
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: sugarSlider.availableWidth
                                    height: 4
                                    radius: 2
                                    color: Colors.currentTheme.background

                                    Rectangle {
                                        id: firstBar
                                        width: parent.width / 4
                                        height: parent.height
                                        color: (sugarSlider.value > 0) ? Colors.green : Colors.grey
                                        radius: 2
                                    }

                                    Rectangle {
                                        id:secondBar
                                        anchors.left: firstBar.right
                                        width: parent.width / 4
                                        height: parent.height
                                        color: (sugarSlider.value > 0.25) ? Colors.green : Colors.grey
                                        radius: 2
                                    }

                                    Rectangle {
                                        id: thirdBar
                                        anchors.left: secondBar.right
                                        width: parent.width / 4
                                        height: parent.height
                                        color: (sugarSlider.value > 0.50) ? Colors.green : Colors.grey
                                        radius: 2
                                    }

                                    Rectangle {
                                        id: fourthBar
                                        anchors.right: parent.right
                                        width: parent.width / 4
                                        height: parent.height
                                        color: (sugarSlider.value > 0.75) ? Colors.green : Colors.grey
                                        radius: 2
                                    }
                                }
                                handle: Rectangle {
                                    id: handle
                                    x: sugarSlider.visualPosition * sugarSlider.availableWidth
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: 14
                                    height: width
                                    radius: 100
                                    color: Colors.green
                                    states: [
                                        State {
                                            name: "small"
                                            when: ((Screen.height * Screen.devicePixelRatio) + (Screen.width * Screen.devicePixelRatio)) < 2000
                                            PropertyChanges {
                                                target: handle
                                                width: 10
                                            }
                                        }
                                    ]

                                    Image {
                                        id: sugarMark
                                        source: "./images/icons/Polygon.svg"
                                        anchors.bottom: parent.top
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        anchors.bottomMargin: 1
                                    }

                                    Rectangle {
                                        id: box
                                        anchors.bottom: sugarMark.top
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        anchors.bottomMargin: 1
                                        implicitWidth: sugarPiecesText.width + 8
                                        implicitHeight: sugarPiecesText.height + 4
                                        radius: 4
                                        color: Colors.currentTheme.background
                                        border.color: Colors.grey
                                        states: [
                                            State {
                                                name: "small"
                                                when: ((Screen.height * Screen.devicePixelRatio) + (Screen.width * Screen.devicePixelRatio)) < 2000
                                                PropertyChanges {
                                                    target: box
                                                    implicitWidth: sugarPiecesText.width + 4
                                                    implicitHeight: sugarPiecesText.height + 2
                                                }
                                            }
                                        ]

                                        Text {
                                            id: sugarPiecesText
                                            property int sugarAmount: 0
                                            anchors.verticalCenter: parent.verticalCenter
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            text: sugarAmount + "p"
                                            font.pixelSize: 12
                                            clip: false
                                            color: Colors.currentTheme.textColor
                                            states: [
                                                State {
                                                    name: "small"
                                                    when: ((Screen.height * Screen.devicePixelRatio) + (Screen.width * Screen.devicePixelRatio)) < 2000
                                                    PropertyChanges {
                                                        target: sugarPiecesText
                                                        font.pixelSize: 8
                                                    }
                                                }
                                            ]
                                        }
                                    }
                                }
                                onMoved: {
                                    sugarPiecesText.sugarAmount = sugarSlider.position * 4
                                }
                            }
                        }

                    }
                }
            }
            MultiEffect {
                source: innerRectangle
                anchors.fill: innerRectangle
                shadowEnabled: true
                shadowColor: Colors.shadow
                shadowOpacity: 0.5
            }
        }
        CustomButton {
            id: confirmButton
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            Layout.minimumWidth: 150
            Layout.minimumHeight: 40
            buttonText: "Start"
            showIcon: false
            onClicked: applicationFlow.confirmButton()
        }
    }
}
