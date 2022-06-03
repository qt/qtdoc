// Copyright (C) 2017 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Layouts
import "."

Rectangle {
    id: root
    color: "transparent"

    property var stock: null

    GridLayout {
        id: stockInfoLayout
        anchors.fill: parent
        columns: 2
        rows: 3
        rowSpacing: 4

        Text {
            id: stockIdText
            color: "#000000"
            font.family: Settings.fontFamily
            font.pointSize: 28
            font.weight: Font.DemiBold
            text: root.stock.stockId
            Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
            Layout.leftMargin: 10
        }

        Text {
            id: price
            color: "#6d6d6d"
            font.family: Settings.fontFamily
            font.pointSize: 28
            font.weight: Font.DemiBold
            text: parseFloat(root.stock.stockPrice).toFixed(2);
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
            Layout.leftMargin: 5
        }

        Text {
            id: stockNameText
            color: "#0c0c0c"
            font.family: Settings.fontFamily
            font.pointSize: 16
            elide: Text.ElideRight
            maximumLineCount: 3
            wrapMode: Text.WordWrap
            text: root.stock.stockName
            Layout.leftMargin: 10
            Layout.columnSpan: 2
            Layout.alignment: Qt.AlignLeft
        }


        Text {
            id: priceChange
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.leftMargin: 10
            color: root.stock.stockPriceChanged < 0 ? "#d40000" : "#328930"
            font.family: Settings.fontFamily
            font.pointSize: 18
            text: parseFloat(root.stock.stockPriceChanged).toFixed(2);
        }

        Text {
            id: priceChangePercentage
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            color: root.stock.stockPriceChanged < 0 ? "#d40000" : "#328930"
            font.family: Settings.fontFamily
            font.pointSize: 18
            font.weight: Font.DemiBold
            Layout.fillWidth: true
            text: "(" +
                  parseFloat(root.stock.stockPriceChanged /
                             (root.stock.stockPrice - root.stock.stockPriceChanged) * 100.0).toFixed(2) +
                  "%)"
        }
    }
}
