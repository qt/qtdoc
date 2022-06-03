// Copyright (C) 2017 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Layouts
import "."

Rectangle {
    id: root
    color: "transparent"

    property bool drawOpenPrice: false
    property bool drawClosePrice: false
    property bool drawHighPrice: true
    property bool drawLowPrice: true

    property string openColor: "#face20"
    property string closeColor: "#14aaff"
    property string highColor: "#80c342"
    property string lowColor: "#f30000"
    property string volumeColor: "#14aaff"

    GridLayout {
        id: settingsGrid
        rows: 5
        columns: 3
        rowSpacing: 4
        anchors.fill: parent

        Item {
            Layout.fillHeight: true
            Layout.columnSpan: 3
        }

        Text {
            id: openText
            color: "#000000"
            font.family: Settings.fontFamily
            font.pointSize: 19
            text: "Open"
            Layout.leftMargin: 10
        }
        Rectangle {
            Layout.preferredHeight: 4
            Layout.preferredWidth: 114
            color: openColor
        }
        CheckBox {
            id: openButton
            buttonEnabled: false
            onButtonEnabledChanged: drawOpenPrice = buttonEnabled
            Layout.rightMargin: 10
        }

        Text {
            id: closeText
            Layout.leftMargin: 10
            color: "#000000"
            font.family: Settings.fontFamily
            font.pointSize: 19
            text: "Close"
        }
        Rectangle {
            Layout.preferredHeight: 4
            Layout.preferredWidth: 114
            color: closeColor
        }
        CheckBox {
            id: closeButton
            buttonEnabled: false
            onButtonEnabledChanged: drawClosePrice = buttonEnabled
            Layout.rightMargin: 10
        }

        Text {
            id: highText
            Layout.leftMargin: 10
            color: "#000000"
            font.family: Settings.fontFamily
            font.pointSize: 19
            text: "High"
        }
        Rectangle {
            Layout.preferredHeight: 4
            Layout.preferredWidth: 114
            color: highColor
        }
        CheckBox {
            id: highButton
            buttonEnabled: true
            onButtonEnabledChanged: drawHighPrice = buttonEnabled
            Layout.rightMargin: 10
        }

        Text {
            id: lowText
            Layout.leftMargin: 10
            color: "#000000"
            font.family: Settings.fontFamily
            font.pointSize: 19
            text: "Low"
        }
        Rectangle {
            Layout.preferredHeight: 4
            Layout.preferredWidth: 114
            color: lowColor
        }

        CheckBox {
            id: lowButton
            buttonEnabled: true
            onButtonEnabledChanged: drawLowPrice = buttonEnabled
            Layout.rightMargin: 10
        }
    }
}
