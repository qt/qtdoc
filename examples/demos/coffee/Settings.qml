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
    property string coffeeName: ""
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
                target: rectangle
                Layout.row: 1
                Layout.preferredWidth: root.width / 1.12
                Layout.preferredHeight: root.height / 3
            }
            PropertyChanges {
                target: confirmButton
                Layout.alignment: Qt.AlignHCenter
                Layout.row: 2
                Layout.preferredWidth: applicationFlow.width / 2.2
                Layout.preferredHeight: applicationFlow.height / 16
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
                Layout.rightMargin: root.width / 20
            }

            PropertyChanges {
                target: rectangle
                Layout.preferredWidth: root.width / 2.75
                Layout.preferredHeight: root.height / 1.5
                Layout.leftMargin: root.width / 20
                Layout.alignment: Qt.AlignBottom
                Layout.column: 2
            }
            PropertyChanges {
                target: confirmButton
                Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
                Layout.row: 1
                Layout.columnSpan: 3
                Layout.preferredWidth: applicationFlow.width / 4
                Layout.preferredHeight: applicationFlow.height / 8
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
            id: rectangle
            radius: 8
            gradient: Colors.greyBorder
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            Layout.minimumHeight: 200
            Layout.minimumWidth: 250
            Rectangle {
                id: rectangle2
                radius: 8
                color: Colors.currentTheme.cardColor
                width: parent.width - 2
                height: parent.height - 2
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter

                ColumnLayout {
                    id: column
                    anchors.fill: parent
                    anchors.margins: 20

                    RowLayout {
                        Text {
                            text: "Coffee"
                            color: Colors.currentTheme.textColor
                            font.pixelSize: 16
                            Layout.alignment: Qt.AlignVCenter
                            Layout.fillWidth: true
                            Layout.preferredWidth: 30
                        }
                        CustomSlider {
                            id: coffeeSlider
                            from: 0
                            to: 100
                            value: coffeeAmount
                            liquidAmount: value
                            Layout.alignment: Qt.AlignVCenter
                            Layout.fillWidth: true
                            Layout.preferredWidth: 70
                            Layout.preferredHeight: column.height / 4
                            onValueChanged: {
                                applicationFlow.coffeeAmount = value
                            }
                        }
                    }
                    RowLayout {
                        Text {
                            text: "Milk"
                            color: Colors.currentTheme.textColor
                            font.pixelSize: 16
                            Layout.alignment: Qt.AlignVCenter
                            Layout.fillWidth: true
                            Layout.preferredWidth: 30
                        }
                        CustomSlider {
                            id: milkSlider
                            from: 0
                            to: 60
                            value: milkAmount
                            liquidAmount: value
                            Layout.alignment: Qt.AlignVCenter
                            Layout.fillWidth: true
                            Layout.preferredWidth: 70
                            Layout.preferredHeight: column.height / 4
                            onValueChanged: {
                                applicationFlow.milkAmount = value
                            }
                        }
                    }
                    RowLayout {
                        Text {
                            text: "Foam"
                            color: Colors.currentTheme.textColor
                            font.pixelSize: 16
                            Layout.alignment: Qt.AlignVCenter
                            Layout.fillWidth: true
                            Layout.preferredWidth: 30
                        }
                        CustomSlider {
                            id: foamSlider
                            from: 0
                            to: 60
                            value: foamAmount
                            liquidAmount: value
                            Layout.alignment: Qt.AlignVCenter
                            Layout.fillWidth: true
                            Layout.preferredWidth: 70
                            Layout.preferredHeight: column.height / 4
                            onValueChanged: {
                                applicationFlow.foamAmount = value
                            }
                        }
                    }
                    RowLayout {
                        Text {
                            text: "Sugar"
                            color: Colors.currentTheme.textColor
                            font.pixelSize: 16
                            Layout.alignment: Qt.AlignVCenter
                            Layout.fillWidth: true
                            Layout.preferredWidth: 30
                        }
                        Slider {
                            id: sugarSlider
                            snapMode: Slider.SnapAlways
                            stepSize: 0.25
                            value: sugarAmount
                            Layout.preferredWidth: foamSlider.width
                            Layout.preferredHeight: column.height / 4
                            Layout.alignment: Qt.AlignVCenter
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
                                    color: (sugarSlider.value > 0) ? "#1FC974" : "#585858"
                                    radius: 2
                                }

                                Rectangle {
                                    id:secondBar
                                    anchors.left: firstBar.right
                                    width: parent.width / 4
                                    height: parent.height
                                    color: (sugarSlider.value > 0.25) ? "#1FC974" : "#585858"
                                    radius: 2
                                }

                                Rectangle {
                                    id: thirdBar
                                    anchors.left: secondBar.right
                                    width: parent.width / 4
                                    height: parent.height
                                    color: (sugarSlider.value > 0.50) ? "#1FC974" : "#585858"
                                    radius: 2
                                }

                                Rectangle {
                                    id: fourthBar
                                    anchors.right: parent.right
                                    width: parent.width / 4
                                    height: parent.height
                                    color: (sugarSlider.value > 0.75) ? "#1FC974" : "#585858"
                                    radius: 2
                                }
                            }
                            handle: Rectangle {
                                id: handle
                                x: sugarSlider.visualPosition * sugarSlider.availableWidth
                                anchors.verticalCenter: parent.verticalCenter
                                implicitWidth: 14
                                implicitHeight: 14
                                radius: 100
                                color: "#1FC974"

                                Image {
                                    id: sugarMark
                                    source: "./images/icons/Polygon.svg"
                                    anchors.bottom: parent.top
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.bottomMargin: 3
                                }

                                Rectangle {
                                    anchors.bottom: sugarMark.top
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.bottomMargin: 3
                                    implicitWidth: sugarText.width + 8
                                    implicitHeight: sugarText.height + 4
                                    radius: 4
                                    color: Colors.currentTheme.background
                                    border.color: "#4F4A4A"

                                    Text {
                                        id: sugarText
                                        property int sugarAmount: 0
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        text: sugarAmount + "p"
                                        font.pixelSize: 12
                                        clip: false
                                        color: Colors.currentTheme.textColor
                                    }
                                }
                            }
                            onMoved: {
                                sugarText.sugarAmount = sugarSlider.position * 4
                            }
                        }
                    }
                }
            }
            MultiEffect {
                source: rectangle2
                anchors.fill: rectangle2
                shadowEnabled: true
                shadowColor: "white"
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
