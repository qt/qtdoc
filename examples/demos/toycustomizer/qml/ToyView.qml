// Copyright (C) 2025 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Layouts

Rectangle {
    id: toyView
    color: "transparent"

    property alias toyIndex: currentToy.index
    property alias toy: currentToy.toy
    property alias accessoryModel: currentToy.accessoryModel

    signal hideRequested
    signal showRequested

    implicitWidth: gridLayout.implicitWidth
    implicitHeight: gridLayout.implicitHeight

    GridLayout {
        id: gridLayout

        columns: 3
        rows: 2
        anchors.fill: parent

        ToyButton {
            id: backButton
            type: ToyButton.Type.Secondary
            textStyle: ApplicationConfig.TextStyle.Button_L
            text: qsTr("Back")
            icon.source: "icons/back.svg"
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            onClicked: toyView.hideRequested()
        }

        Item {
            implicitWidth: currentToy.implicitWidth
            implicitHeight: currentToy.implicitHeight
            Layout.fillWidth: true
            Layout.fillHeight: true

            CurrentToyModel {
                id: currentToy
                anchors.fill: parent
                isMaximized: false
            }
        }

        ToyButton {
            id: maximizeButton
            type: ToyButton.Type.Secondary
            flat: true
            text: qsTr("Maximize")
            color: pressed ? "#1A53DB" : hovered ? "#1C44B1" : "#2269EE"
            icon {
                source: "icons/maximize_circle_fill.svg"
                width: ApplicationConfig.responsiveSize(96)
                height: ApplicationConfig.responsiveSize(96)
            }
            onClicked: toyView.showRequested()
            Layout.alignment: Qt.AlignRight | Qt.AlignTop
        }
    }
}
