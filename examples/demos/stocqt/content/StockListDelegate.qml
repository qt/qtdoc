// Copyright (C) 2017 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Layouts
import "."

Rectangle {
    height: 102
    width: parent.width
    color: "transparent"
    MouseArea {
        anchors.fill: parent;
        onClicked: {
            if (view.currentIndex == index)
                mainRect.currentIndex = 1;
            else
                view.currentIndex = index;
        }
    }
    GridLayout {
        id: stockGrid
        columns: 3
        rows: 2
        anchors.fill: parent

        Text {
            id: stockIdText
            Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
            Layout.leftMargin: 10
            color: "#000000"
            font.family: Settings.fontFamily
            font.pointSize: 20
            font.weight: Font.Bold
            verticalAlignment: Text.AlignVCenter
            text: stockId
        }

        Text {
            id: stockValueText
            Layout.preferredWidth: 100
            Layout.alignment: Qt.AlignRight | Qt.AlignBottom
            color: "#000000"
            font.family: Settings.fontFamily
            font.pointSize: 20
            font.bold: true
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
            text: value
        }
        Text {
            id: stockValueChangeText
            Layout.preferredWidth: 135
            Layout.rightMargin: 10
            Layout.alignment: Qt.AlignRight | Qt.AlignBottom
            color: "#328930"
            font.family: Settings.fontFamily
            font.pointSize: 20
            font.bold: true
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
            text: change
            onTextChanged: (text) => {
                if (parseFloat(text) >= 0.0)
                    color = "#328930";
                else
                    color = "#d40000";
            }
        }
        Text {
            id: stockNameText
            Layout.preferredWidth: 300
            Layout.leftMargin: 10
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            color: "#000000"
            font.family: Settings.fontFamily
            font.pointSize: 16
            font.bold: false
            elide: Text.ElideRight
            maximumLineCount: 1
            verticalAlignment: Text.AlignVCenter
            text: name
        }

        Item {Layout.fillWidth: true }

        Text {
            id: stockValueChangePercentageText
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignRight | Qt.AlignTop
            Layout.rightMargin: 10
            color: "#328930"
            font.family: Settings.fontFamily
            font.pointSize: 18
            font.bold: false
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
            text: changePercentage
            onTextChanged: (text) => {
                if (parseFloat(text) >= 0.0)
                    color = "#328930";
                else
                    color = "#d40000";
            }
        }
    }

    Rectangle {
        id: endingLine
        anchors.top: stockGrid.bottom
        height: 1
        width: parent.width
        color: "#d7d7d7"
    }
}

