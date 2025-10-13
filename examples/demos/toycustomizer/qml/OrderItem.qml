// Copyright (C) 2025 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Layouts

Item {
    id: orderItem

    required property real oldPrice
    required property real newPrice
    property real __discountPercent: Math.round(Math.max(oldPrice - newPrice, 0) / oldPrice * 100)
    property alias name: toyName.text
    property bool priceVisible: true
    property bool isSelected: false
    property alias label: toyLabel.text
    property alias image: toyImage.source

    RowLayout {
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: separator.top
        }
        ColumnLayout {
            id: layout
            spacing: ApplicationConfig.responsiveSize(20)
            ToyLabel {
                id: toyLabel
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                textStyle: ApplicationConfig.TextStyle.H3_Light
                color: "#6A6A8D"
            }
            RowLayout {
                ToyLabel {
                    id: toyName
                    Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                    textStyle: ApplicationConfig.TextStyle.H3_Light
                }
                Item {
                    // filler
                    implicitHeight: 2
                    Layout.fillWidth: true
                }
                LayoutItemProxy {
                    target: orderItem.isSelected ? selectedItem : notSelectedLabel
                    visible: !orderItem.isSelected || orderItem.priceVisible
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }
            }
            Item {
                // pushes category label and item name to a right height
                Layout.fillHeight: true
            }
        }
        Image {
            id: toyImage
            visible: orderItem.isSelected
            sourceSize {
                width: ApplicationConfig.responsiveSize(190)
                height: ApplicationConfig.responsiveSize(190)
            }
        }
    }

    Rectangle {
        id: separator
        anchors {
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }
        height: ApplicationConfig.responsiveSize(5)
        color: "#D7D6E1"
    }
    ToyLabel {
        id: notSelectedLabel
        visible: !orderItem.isSelected
        text: qsTr("Not Selected")
    }
    ColumnLayout {
        id: selectedItem
        visible: orderItem.isSelected && orderItem.priceVisible
        spacing: 0
        RowLayout {
            id: priceRow
            spacing: ApplicationConfig.responsiveSize(16)
            ToyLabel {
                id: toyPrice
                textStyle: ApplicationConfig.TextStyle.Price_M
                text: `${orderItem.newPrice}`
            }
            ToyImage {
                source: "icons/currency.svg"
                color: toyPrice.color
                colorize: true
                sourceSize {
                    width: ApplicationConfig.responsiveSize(142)
                    height: ApplicationConfig.responsiveSize(32)
                }
            }
        }
        RowLayout {
            visible: orderItem.__discountPercent > 0
            spacing: ApplicationConfig.responsiveSize(16)
            ToyLabel {
                id: originalPrice
                textStyle: ApplicationConfig.TextStyle.Price_S
                color: "#6A6A8D"
                font.strikeout: true
                text: `${orderItem.oldPrice}`
            }
            ToyLabel {
                id: discount
                textStyle: ApplicationConfig.TextStyle.Price_S
                color: "#6A6A8D"
                text: qsTr("%1%").arg(-orderItem.__discountPercent)
            }
        }
        Item {
            // filler
            Layout.fillHeight: true
        }
    }
}
