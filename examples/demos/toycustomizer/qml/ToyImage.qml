// Copyright (C) 2025 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick

Item {
    id: root

    property alias sourceSize: image.sourceSize
    property alias source: image.source
    property alias smooth: image.smooth
    property alias color: shaderEffect.color
    property bool colorize: false

    implicitHeight: image.implicitHeight
    implicitWidth: image.implicitWidth

    Image {
        id: image
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        visible: root.visible && !root.colorize
    }

    ShaderEffectSource {
        id: shaderEffectSource
        sourceItem: image
    }

    ShaderEffect {
        id: shaderEffect
        property variant source: shaderEffectSource
        property color color: "black"
        anchors.fill: image
        fragmentShader: "shaders/coloroverlay.frag.qsb"
        visible: root.visible && root.colorize
    }
}
