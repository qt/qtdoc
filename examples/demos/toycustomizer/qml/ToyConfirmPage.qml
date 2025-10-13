// Copyright (C) 2025 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
    id: root

    property int toyIndex: -1
    property var __modelData: ToyModel.get(root.toyIndex) ?? null
    property int __price: root.__modelData ? root.__modelData.originalPrice : 0
    property int __discount: root.__modelData ? root.__modelData.discountPercent : 0

    signal cancelled
    signal confirmed

    background: Item { visible: false }

    ToyButton {
        type: ToyButton.Type.Secondary
        textStyle: ApplicationConfig.TextStyle.Button_L
        text: qsTr("Back")
        icon.source: "icons/back.svg"
        anchors {
            left: gridBackgroundRect.left
            bottom: gridBackgroundRect.top
            bottomMargin: ApplicationConfig.responsiveSize(ApplicationConfig.isPortrait ? 49 : 80)
        }
        onClicked: root.cancelled()
    }

    Rectangle {
        id: gridBackgroundRect
        radius: ApplicationConfig.responsiveSize(56)
        color: "white"
        anchors {
            fill: ApplicationConfig.isPortrait ? portraitGridLayout : landscapeGridLayout
            topMargin: ApplicationConfig.responsiveSize(520)
            leftMargin: ApplicationConfig.responsiveSize(-120)
            rightMargin: ApplicationConfig.responsiveSize(-120)
            bottomMargin: ApplicationConfig.responsiveSize(-157)
        }
    }

    // GridLayout for portrait mode
    GridLayout {
        id: portraitGridLayout
        visible: ApplicationConfig.isPortrait
        columns: 2
        columnSpacing: ApplicationConfig.responsiveSize(64)
        width: {
            const minWidth = ApplicationConfig.responsiveSize(1760)
            if (ApplicationConfig.isPortrait)
                return minWidth
            const horMargin = ApplicationConfig.responsiveSize(778)
            const breakpointWidth = minWidth + 2 * horMargin
            if (root.width < breakpointWidth)
                return minWidth
            else
                return root.width - 2 * horMargin
        }

        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
            leftMargin: ApplicationConfig.responsiveSize(320)
            rightMargin: ApplicationConfig.responsiveSize(320)
        }

        LayoutItemProxy {
            target: toyImage
            Layout.columnSpan: 2
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            LayoutItemProxy {
                target: toyNameLabel
            }
            LayoutItemProxy {
                target: reviewsRow
            }
            LayoutItemProxy {
                target: descriptionLabel
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }

        ColumnLayout {
            Layout.fillHeight: true
            LayoutItemProxy {
                visible: root.__discount > 0
                target: discountRow
            }
            LayoutItemProxy {
                id: portraitPriceLayoutItem
                target: priceRow
                Layout.minimumWidth: target.implicitWidth
            }
            LayoutItemProxy {
                target: confirmButton
                Layout.topMargin: ApplicationConfig.responsiveSize(100)
                Layout.preferredWidth: Math.max(portraitPriceLayoutItem.width,
                                                confirmButton.implicitWidth)
            }
            Item {
                implicitWidth: 2
                Layout.fillHeight: true
            }
        }
    }

    // GridLayout for landscape mode
    GridLayout {
        id: landscapeGridLayout
        visible: !ApplicationConfig.isPortrait
        columns: 3
        width: {
            const minWidth = ApplicationConfig.responsiveSize(1964)
            if (ApplicationConfig.isPortrait)
                return minWidth
            const horMargin = ApplicationConfig.responsiveSize(778)
            const breakpointWidth = minWidth + 2 * horMargin
            if (root.width < breakpointWidth)
                return minWidth
            else
                return root.width - 2 * horMargin
        }
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
            leftMargin: ApplicationConfig.responsiveSize(778)
            rightMargin: ApplicationConfig.responsiveSize(778)
        }

        LayoutItemProxy {
            target: toyImage
            implicitWidth: ApplicationConfig.responsiveSize(1270)
            Layout.alignment: Qt.AlignCenter
            Layout.fillWidth: true
        }
        Item {
            implicitHeight: 2
            Layout.fillWidth: true
        }
        ColumnLayout {
            Layout.fillHeight: true
            Layout.topMargin: ApplicationConfig.responsiveSize(522)
            spacing: 0
            Item {
                implicitWidth: 2
                Layout.fillHeight: true
            }
            LayoutItemProxy {
                visible: root.__discount > 0
                target: discountRow
                Layout.alignment: Qt.AlignLeft
            }
            LayoutItemProxy {
                id: landscapePriceLayoutItem
                target: priceRow
                Layout.alignment: Qt.AlignLeft
            }
            LayoutItemProxy {
                target: confirmButton
                Layout.topMargin: ApplicationConfig.responsiveSize(80)
                Layout.preferredWidth: landscapePriceLayoutItem.width
            }
            Item {
                implicitWidth: 2
                Layout.fillHeight: true
            }
        }
        ColumnLayout {
            Layout.fillWidth: true
            Layout.columnSpan: 3
            LayoutItemProxy {
                target: toyNameLabel
            }
            LayoutItemProxy {
                target: reviewsRow
            }
            LayoutItemProxy {
                target: descriptionLabel
                Layout.fillHeight: true
                Layout.fillWidth: true
            }
        }
    }

    // Items
    ToyImage {
        id: toyImage
        source: root.__modelData ? root.__modelData.image : ""
        sourceSize {
            width: ApplicationConfig.responsiveSize(856)
            height: ApplicationConfig.responsiveSize(1150)
        }
    }
    ToyLabel {
        id: toyNameLabel
        text: root.__modelData ? root.__modelData.name : ""
        textStyle: ApplicationConfig.TextStyle.H2_Bold
    }
    Row {
        id: reviewsRow
        spacing: 8
        ToyLabel {
            text: qsTr("%1 reviews").arg(root.__modelData ? root.__modelData.reviews : 0)
            textStyle: ApplicationConfig.TextStyle.H3
        }
        ToyLabel {
            text: qsTr("★%1").arg(root.__modelData ? root.__modelData.rating : 0)
            textStyle: ApplicationConfig.TextStyle.H3
        }
    }
    ToyLabel {
        id: descriptionLabel
        wrapMode: Text.WordWrap
        textStyle: ApplicationConfig.TextStyle.Body_L
        color: "#6A6A8D"
        text: root.__modelData ? root.__modelData.description : ""
    }
    Row {
        id: discountRow
        spacing: ApplicationConfig.responsiveSize(24)
        ToyLabel {
            textStyle: ApplicationConfig.TextStyle.Price_ML
            text: qsTr("%1").arg(root.__price)
            font.strikeout: true
            color: "#6A6A8D"
        }
        ToyLabel {
            textStyle: ApplicationConfig.TextStyle.Price_ML
            text: qsTr("%1%").arg(-root.__discount)
            color: "#6A6A8D"
        }
    }
    Row {
        id: priceRow
        spacing: ApplicationConfig.responsiveSize(17)
        ToyLabel {
            id: priceLabel
            textStyle: ApplicationConfig.isPortrait ? ApplicationConfig.TextStyle.Price_XL
                                                    : ApplicationConfig.TextStyle.Price_XXL
            text: root.__discount > 0 ? `${root.__price * (1 - root.__discount / 100)}`
                                      : `${root.__price}`
        }
        ToyImage {
            height: parent.height * 0.7
            source: "images/qtCoins"
            color: priceLabel.color
            colorize: true
            anchors.bottom: parent.bottom
        }
    }
    ToyButton {
        id: confirmButton
        textStyle: ApplicationConfig.TextStyle.Button_L
        text: qsTr("Confirm choice")
        onClicked: root.confirmed()
    }

    Connections {
        target: ToyModel
        function onDataChanged() {
            root.__modelDataChanged()
        }
    }
}
