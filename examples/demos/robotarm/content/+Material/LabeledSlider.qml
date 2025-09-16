// Copyright (C) 2025 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Slider {
    property string labelText: qsTr("Text")
    required property real sliderWidth
    stepSize: 1

    Layout.preferredWidth: sliderWidth

    Label {
        text: parent.labelText
        anchors.left: parent.left
        anchors.bottom: parent.top
        bottomPadding: -12
    }
    Label {
        text: parent.value
        anchors.right: parent.right
        anchors.bottom: parent.top
        bottomPadding: -12
    }
}
