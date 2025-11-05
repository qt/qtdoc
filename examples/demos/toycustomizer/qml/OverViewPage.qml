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

        spacing: ApplicationConfig.responsiveSize(80)
        visible: ApplicationConfig.isPortrait

        anchors {
            fill: parent
            topMargin: ApplicationConfig.responsiveSize(200)
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.leftMargin: ApplicationConfig.responsiveSize(400)
            Layout.rightMargin: ApplicationConfig.responsiveSize(400)
            Layout.minimumHeight: breakdownAndConfirmItem.implicitHeight
            Layout.minimumWidth: orderBreakdownLayout.implicitWidth
            Column {
                id: breakdownAndConfirmItem
                spacing: ApplicationConfig.responsiveSize(152)
                anchors.centerIn: parent
                LayoutItemProxy {
                    target: orderBreakdownLayout
                }
                LayoutItemProxy {
                    target: confirmButton
                    visible: overViewPage.buttonsVisible
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
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
            target: orderDetailsItem
            Layout.alignment: Qt.AlignBottom
            Layout.fillWidth: true
        }
    }

    /* Grid Layout for landscape mode */
    GridLayout {
        id: landscapeLayout

        visible: !ApplicationConfig.isPortrait
        columns: 2
        rowSpacing: ApplicationConfig.responsiveSize(80)
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }

        columnSpacing: {
            const prefSpacing = ApplicationConfig.responsiveSize(400)
            const prefWidth = orderBreakdownLayout.width + orderDetailsItem.width + prefSpacing
            const minMargins = ApplicationConfig.responsiveSize(100)
            const parentWidth = parent.width - 2 * minMargins
            const availableWidth = parentWidth - prefWidth
            if (availableWidth > 0)
                return prefSpacing
            const minSpacing = ApplicationConfig.responsiveSize(60)
            return Math.max(prefSpacing + availableWidth, minSpacing)
        }

        state: height < parent.height ? "" : "narrow"
        states: State {
            name: "narrow"
            AnchorChanges {
                target: landscapeLayout
                anchors {
                    verticalCenter: undefined
                    top: landscapeLayout.parent.top
                }
            }
        }

        LayoutItemProxy {
            target: backButton
            visible: overViewPage.buttonsVisible
        }

        Column {
            spacing: ApplicationConfig.responsiveSize(140)
            Layout.rowSpan: 2
            Layout.row: 0
            Layout.column: 1
            LayoutItemProxy {
                target: orderBreakdownLayout
            }
            LayoutItemProxy {
                target: confirmButton
                visible: overViewPage.buttonsVisible
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        LayoutItemProxy {
            target: orderDetailsItem
            Layout.row: overViewPage.buttonsVisible ? 1 : 0
            Layout.column: 0
        }
    }

    GridLayout {
        id: orderBreakdownLayout

        columns: 4

        ToyLabel {
            id: subTotal
            textStyle: ApplicationConfig.TextStyle.H3_Light
            text: qsTr("SubTotal")
        }
        Item {
            implicitHeight: 2
            implicitWidth: ApplicationConfig.responsiveSize(720)
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

        ToyLabel {
            id: delivery
            textStyle: ApplicationConfig.TextStyle.H3_Light
            text: qsTr("Delivery")
            Layout.row: 1
            Layout.column: 0
        }
        ToyLabel {
            id: deliveryPrice
            textStyle: ApplicationConfig.TextStyle.H3_Light
            text: qsTr("0")
            Layout.row: 1
            Layout.column: 2
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
            Layout.row: 1
            Layout.column: 3
        }

        Rectangle {
            id: separator
            color: "#162655"
            implicitHeight: ApplicationConfig.responsiveSize(8)
            Layout.fillWidth: true
            Layout.columnSpan: 4
            Layout.row: 2
            Layout.column: 0
        }

        ToyLabel {
            id: total
            textStyle: ApplicationConfig.TextStyle.H3_Light
            text: qsTr("Total")
            Layout.row: 3
            Layout.column: 0
        }
        ToyLabel {
            id: totalPrice
            textStyle: ApplicationConfig.TextStyle.H3_Light
            text: `${orderGrid.totalPrice}`
            Layout.row: 3
            Layout.column: 2
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
            Layout.row: 3
            Layout.column: 3
        }
    }

    Rectangle {
        id: orderDetailsItem

        readonly property real paddings: ApplicationConfig.responsiveSize(180)

        implicitWidth: orderGrid.implicitWidth + 2 * paddings
        implicitHeight: orderGrid.implicitHeight + 2 * paddings

        radius: ApplicationConfig.responsiveSize(56)
        bottomLeftRadius: ApplicationConfig.isPortrait ? 0 : radius
        bottomRightRadius: ApplicationConfig.isPortrait ? 0 : radius
        color: "white"

        OrderGrid {
            id: orderGrid
            implicitWidth: ApplicationConfig.responsiveSize(1760)
            implicitHeight: ApplicationConfig.responsiveSize(1170)
            accessoryModel: overViewPage.accessoryModel
            anchors.centerIn: parent
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
