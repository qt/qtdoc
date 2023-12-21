// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick3D

CustomMaterial {
    id: carpaint

    property color baseColor: "#3137fd"
    property color secondaryColor: "#035096"
    property real roughness: 0.1
    property real clearcoat: 1
    property real metalness: 0
    property real specular: 0
    property real flakes: 1
    property real vcoloron: 1
    property real opacity: 1
    property TextureInput flakesNormal: flaketexture

    cullMode: Material.NoCulling
    fragmentShader: Qt.resolvedUrl("shaders/carmat_simple_nf.frag")
    vertexShader: Qt.resolvedUrl("shaders/carmat_simple_nf.vert")
    depthDrawMode: Material.AlwaysDepthDraw
    objectName: "Car Paint"

    TextureInput {
        id: flaketexture

        texture: noiseMap
        enabled: true
    }

    Texture {
        id: noiseMap

        source: "images/LDR_RGB1_3.png"
        mipFilter: Texture.None
        magFilter: Texture.None
        scaleV: 10
        generateMipmaps: false
        scaleU: 10
        minFilter: Texture.None
    }
}
