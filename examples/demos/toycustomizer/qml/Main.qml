// Copyright (C) 2025 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

pragma ComponentBehavior: Bound

ApplicationWindow {
    // TODO: set height and width
    visible: true
    title: qsTr("Toy Customizer")

    background: Rectangle {
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#DAEBFF" }
            GradientStop { position: 0.25; color: "#DAEBFF" }
            GradientStop { position: 0.65; color: "#91C9FF" }
            GradientStop { position: 0.80; color: "#91C9FF" }
            GradientStop { position: 1.0; color: "#A2D1FF" }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        // TODO: add ToyHeader
        StackView {
            id: stackView
            // TODO: set initialItem
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }
}
