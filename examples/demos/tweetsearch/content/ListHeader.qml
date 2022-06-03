// Copyright (C) 2017 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick

Item {
    height: 60
    width: parent.width

    property bool refresh: state == "pulled" ? true : false

    Row {
        spacing: 6
        height: childrenRect.height
        anchors.centerIn: parent

        Image {
            id: arrow
            source: "resources/icon-refresh.png"
            transformOrigin: Item.Center
            Behavior on rotation { NumberAnimation { duration: 200 } }
        }

        Text {
            id: label
            anchors.verticalCenter: arrow.verticalCenter
            text: "Pull to refresh...    "
            font.pixelSize: 18
            color: "#999999"
        }
    }

    states: [
        State {
            name: "base"; when: mainListView.contentY >= -120
            PropertyChanges { target: arrow; rotation: 180 }
        },
        State {
            name: "pulled"; when: mainListView.contentY < -120
            PropertyChanges { target: label; text: "Release to refresh..." }
            PropertyChanges { target: arrow; rotation: 0 }
        }
    ]
}
