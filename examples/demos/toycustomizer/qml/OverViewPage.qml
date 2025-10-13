// Copyright (C) 2025 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
    id: overViewPage

    property bool buttonsVisible: true
    property alias toyIndex: orderGrid.toyIndex
    property alias accessoryModel: orderGrid.accessoryModel
    signal confirmed
    signal cancelled

    background: Item { visible: false }

    /* Column Layout for portrait mode */
    ColumnLayout {
        id: portraitLayout

        visible: ApplicationConfig.isPortrait

        anchors {
            fill: parent
            topMargin: ApplicationConfig.responsiveSize(200)
            leftMargin: ApplicationConfig.responsiveSize(-200)
            rightMargin: ApplicationConfig.responsiveSize(-200)
        }

        LayoutItemProxy {
            target: breakdownAndConfirm
            implicitHeight: ApplicationConfig.responsiveSize(268)
            implicitWidth: ApplicationConfig.responsiveSize(1152)
            Layout.minimumWidth: ApplicationConfig.responsiveSize(1152)
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            Layout.fillWidth: true
            Layout.leftMargin: ApplicationConfig.responsiveSize(304)
            Layout.rightMargin: ApplicationConfig.responsiveSize(304)
        }

        LayoutItemProxy {
            target: confirmButton
            visible: overViewPage.buttonsVisible
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: ApplicationConfig.responsiveSize(152)
        }
        Item {
            implicitHeight: confirmButton.implicitHeight
            visible: !overViewPage.buttonsVisible
        }

        LayoutItemProxy {
            target: backButton
            visible: overViewPage.buttonsVisible
            Layout.leftMargin: ApplicationConfig.responsiveSize(80)
        }
        Item {
            implicitHeight: backButton.implicitHeight
            visible: !overViewPage.buttonsVisible
        }

        LayoutItemProxy {
            target: backgroundRectangle
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.topMargin: ApplicationConfig.responsiveSize(80)
            Layout.minimumHeight: ApplicationConfig.responsiveSize(1350)
        }
    }

    /* Grid Layout for landscape mode */
    GridLayout {
        id: landscapeLayout

        readonly property int minimumWidth: ApplicationConfig.responsiveSize(3528)

        visible: !ApplicationConfig.isPortrait
        columns: 2
        rowSpacing: ApplicationConfig.responsiveSize(80)
        columnSpacing: {
            const preferredSpacing = ApplicationConfig.responsiveSize(400)
            const diffWidth = overViewPage.width - minimumWidth
            if (diffWidth > 0)
                return preferredSpacing
            return Math.max(preferredSpacing + diffWidth, 0)
        }

        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
            topMargin: ApplicationConfig.responsiveSize(120)
            leftMargin: horizontalMargin()
            rightMargin: horizontalMargin()
        }

        function horizontalMargin() {
            return ApplicationConfig.responsiveSize(440)
        }

        Row {
            Layout.columnSpan: 2
            LayoutItemProxy {
                target: backButton
                visible: overViewPage.buttonsVisible
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            }
        }
        LayoutItemProxy {
            target: backgroundRectangle
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.minimumHeight: ApplicationConfig.responsiveSize(1360)
            Layout.minimumWidth: ApplicationConfig.responsiveSize(2100)
        }
        LayoutItemProxy {
            target: breakdownAndConfirm
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.minimumHeight: ApplicationConfig.responsiveSize(1350)
            Layout.minimumWidth: ApplicationConfig.responsiveSize(1300)
        }
    }

    ColumnLayout {
        id: breakdownAndConfirm

        RowLayout {
            Layout.fillWidth: true
            ToyLabel {
                id: subTotal
                Layout.alignment: Qt.AlignLeft
                textStyle: ApplicationConfig.TextStyle.H3_Light
                text: qsTr("SubTotal")
            }
            Item {
                Layout.fillWidth: true
            }
            ToyLabel {
                id: subTotalPrice
                textStyle: ApplicationConfig.TextStyle.H3_Light
                text: `${orderGrid.totalPrice}`
            }
            ToyImage {
                Layout.alignment: Qt.AlignRight
                source: "icons/currency.svg"
                color: subTotalPrice.color
                colorize: true
                sourceSize {
                    width: ApplicationConfig.responsiveSize(142)
                    height: ApplicationConfig.responsiveSize(32)
                }
            }
        }
        RowLayout {
            Layout.preferredHeight: delivery.height
            Layout.fillWidth: true
            ToyLabel {
                id: delivery
                Layout.alignment: Qt.AlignLeft
                textStyle: ApplicationConfig.TextStyle.H3_Light
                text: qsTr("Delivery")
            }
            Item {
                Layout.fillWidth: true
            }
            ToyLabel {
                id: deliveryPrice
                textStyle: ApplicationConfig.TextStyle.H3_Light
                text: qsTr("0")
            }
            ToyImage {
                Layout.alignment: Qt.AlignRight
                source: "icons/currency.svg"
                color: deliveryPrice.color
                colorize: true
                sourceSize {
                    width: ApplicationConfig.responsiveSize(142)
                    height: ApplicationConfig.responsiveSize(32)
                }
            }
        }
        Rectangle {
            id: separator
            Layout.fillWidth: true
            Layout.preferredHeight: ApplicationConfig.responsiveSize(5)
            color: "#162655"
        }
        RowLayout {
            Layout.preferredHeight: total.height
            Layout.fillWidth: true
            ToyLabel {
                id: total
                Layout.alignment: Qt.AlignLeft
                textStyle: ApplicationConfig.TextStyle.H3_Light
                text: qsTr("Total")
            }
            Item {
                Layout.fillWidth: true
            }
            ToyLabel {
                id: totalPrice
                textStyle: ApplicationConfig.TextStyle.H3_Light
                text: `${orderGrid.totalPrice}`
            }
            ToyImage {
                Layout.alignment: Qt.AlignRight
                source: "icons/currency.svg"
                color: totalPrice.color
                colorize: true
                sourceSize {
                    width: ApplicationConfig.responsiveSize(142)
                    height: ApplicationConfig.responsiveSize(32)
                }
            }
        }
        LayoutItemProxy {
            target: confirmButton
            visible: buttonsVisible && !ApplicationConfig.isPortrait
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: ApplicationConfig.responsiveSize(140)
        }
    }

    Rectangle {
        id: backgroundRectangle

        radius: ApplicationConfig.responsiveSize(56)
        bottomLeftRadius: ApplicationConfig.isPortrait ? 0 : radius
        bottomRightRadius: ApplicationConfig.isPortrait ? 0 : radius
        color: "white"

        state: ApplicationConfig.isPortrait ? "portraitAnchored" : "landscapeAnchored"
        states: [
            State {
                name: "portraitAnchored"
                AnchorChanges {
                    target: orderGrid
                    anchors.top: backgroundRectangle.top
                }
                PropertyChanges {
                    target: orderGrid
                    anchors {
                        topMargin: ApplicationConfig.responsiveSize(200)
                        leftMargin: ApplicationConfig.responsiveSize(180)
                        rightMargin: ApplicationConfig.responsiveSize(180)
                    }
                }
            },
            State {
                name: "landscapeAnchored"
                AnchorChanges {
                    target: orderGrid
                    anchors.verticalCenter: backgroundRectangle.verticalCenter
                }
                PropertyChanges {
                    target: orderGrid
                    anchors {
                        topMargin: ApplicationConfig.responsiveSize(0)
                        leftMargin: ApplicationConfig.responsiveSize(200)
                        rightMargin: ApplicationConfig.responsiveSize(200)
                    }
                }
            }
        ]

        OrderGrid {
            id: orderGrid
            implicitWidth: ApplicationConfig.responsiveSize(1760)
            implicitHeight: ApplicationConfig.responsiveSize(1170)
            accessoryModel: overViewPage.accessoryModel
            anchors {
                left: parent.left
                right: parent.right
            }
        }
    }

    ToyButton {
        id: confirmButton
        visible: false
        type: ToyButton.Type.Primary
        textStyle: ApplicationConfig.TextStyle.Button_L
        text: qsTr("Confirm order")
        onClicked: overViewPage.confirmed()
    }

    ToyButton {
        id: backButton
        visible: false
        type: ToyButton.Type.Secondary
        textStyle: ApplicationConfig.TextStyle.Button_L
        icon.source: "icons/shirt.svg"
        text: qsTr("Back")
        onClicked: overViewPage.cancelled()
    }
}
