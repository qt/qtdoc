// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts 1.15

Rectangle {
    id: legend
    width: 359
    height: 22
    color: "transparent"

    property alias high: high
    property alias low: low
    property alias open: open
    property alias close: close

    RowLayout {
        anchors.fill: parent
        anchors.rightMargin: 16
        anchors.leftMargin: 16
        spacing: 8

        StockCheckbox {
            id: high
            cbText: "high"
            activeColor: "#33279646"
            activeTextColor: "#279646"
            width: 43
            height: 22
            Layout.preferredHeight: 22
            Layout.preferredWidth: 43
            checked: true
        }
        StockCheckbox {
            id: low
            cbText: "low"
            activeColor: "#33cc5e87"
            activeTextColor: "#CC5E87"
            width: 43
            height: 22
            Layout.preferredHeight: 22
            Layout.preferredWidth: 43
            checked: true
        }
        StockCheckbox {
            id: open
            cbText: "open"
            activeColor: "#33cca35e"
            activeTextColor: "#CCA35E"
            width: 43
            height: 22
            Layout.preferredHeight: 22
            Layout.preferredWidth: 43
        }
        StockCheckbox {
            id: close
            cbText: "close"
            activeColor: "#325e87cc"
            activeTextColor: "#5E87CC"
            width: 43
            height: 22
            Layout.preferredHeight: 22
            Layout.preferredWidth: 43
        }

        Item {
            width: 43
            height: 22
            Layout.fillWidth: true
            Layout.preferredHeight: 22
            Layout.preferredWidth: 43
        }
    }
}
