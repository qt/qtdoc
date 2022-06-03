// Copyright (C) 2017 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Window
import QtQuick.Layouts

Rectangle {
    id: root
    width: 320
    height: 480
    color: "transparent"

    property var stock: null
    property var stocklist: null
    signal settingsClicked

    function update() {
        chart.update()
    }

    Rectangle {
        id: mainRect
        color: "transparent"
        anchors.fill: parent

        GridLayout {
            anchors.fill: parent
            rows: 2
            columns: Screen.primaryOrientation === Qt.PortraitOrientation ? 1 : 2

            StockInfo {
                id: stockInfo
                Layout.alignment: Qt.AlignTop
                Layout.preferredWidth: 400
                Layout.preferredHeight: 160
                stock: root.stock
            }

            StockChart {
                id: chart
                Layout.alignment: Qt.AlignRight
                Layout.margins: 5
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.rowSpan: 2
                stockModel: root.stock
                settings: settingsPanel
            }
            StockSettingsPanel {
                id: settingsPanel
                Layout.alignment: Qt.AlignBottom
                Layout.fillHeight: true
                Layout.preferredWidth: 400
                Layout.bottomMargin: 5
                onDrawOpenPriceChanged: root.update()
                onDrawClosePriceChanged: root.update();
                onDrawHighPriceChanged: root.update();
                onDrawLowPriceChanged: root.update();
            }
        }
    }
}
