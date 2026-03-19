// Copyright (C) 2026 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick

Rectangle {
    id: background
    opacity: 0.9
    radius: background.height * 0.2
    gradient: Gradient {
        GradientStop { position: 0.0; color: "#00414A" }
        GradientStop { position: 1.0; color: "#0C1C1F" }
    }

    Loader {
        id: loader
        anchors.fill: parent
        source: background.visible ? "LightningAnimation.qml" : ""
        width: 2 * background.width / 3
        height: width
        Binding {
            target: loader.item
            property: "animations.loops"
            value: Animation.Infinite
            when: loader.item && (loader.status === Loader.Ready)
        }
    }

    Image {
        anchors.centerIn: parent
        source: "icons/lightning.png"
        visible: loader.status === Loader.Error
        width: 2 * background.width / 3
        height: width
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 12

        text: qsTr("Click to start")
        font.pixelSize: 12
        color: "#C0F5DA"
    }

    TapHandler {
        onTapped: background.visible = false
    }
}

