// Copyright (C) 2025 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick3D
import QtQuick3D.Effects
import QtQuick3D.Helpers

View3D {
    id: view3D

    property alias isAnimationRunning: toyAnimations.isAnimationRunning

    anchors.fill: parent
    z: -1
    environment: extendedSceneEnvironment

    PrincipledMaterial {
        id: defaultMaterial
        roughness: 1
        alphaMode: PrincipledMaterial.Opaque
        objectName: "Default Material"
        baseColor: "#add6ff"
    }

    Texture {
        id: studio_small_01_4k
        source: "images/studio_small_01_4k.hdr"
        objectName: "Studio small 01 4k"
    }

    Node {
        id: scene

        PerspectiveCamera {
            id: sceneCamera
            y: 105
            z: 160
            clipFar: 2000
            clipNear: 1
            frustumCullingEnabled: false
            fieldOfView: 65
            eulerRotation.x: -5
        }

        ToyAnimations {
            id: toyAnimations
        }

        SpotLight {
            id: spotlight
            x: -28.94
            y: 1236.083
            visible: true
            color: "#e7e7e7"
            shadowBias: 5
            quadraticFade: 0.3
            innerConeAngle: 26
            coneAngle: 71
            linearFade: 1.4
            brightness: 16
            shadowMapQuality: Light.ShadowMapQualityVeryHigh
            shadowFactor: 93
            castsShadow: true
            eulerRotation.x: -80
            z: 510.89325
        }
    }

    ExtendedSceneEnvironment {
        id: extendedSceneEnvironment
        clearColor: "#add6ff"
        probeOrientation.y: 179
        probeHorizon: 0.2
        antialiasingQuality: SceneEnvironment.High
        fxaaEnabled: true
        antialiasingMode: SceneEnvironment.MSAA
        glowUseBicubicUpscale: true
        glowQualityHigh: true
        glowEnabled: false
        probeExposure: 1
        backgroundMode: SceneEnvironment.Transparent
        lightProbe: studio_small_01_4k
        exposure: 1.12117
        aoSoftness: 48.16217
        aoDistance: 15
        aoStrength: 94
        aoEnabled: true
    }
}
