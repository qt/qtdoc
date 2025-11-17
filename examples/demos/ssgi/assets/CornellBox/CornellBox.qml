// Copyright (C) 2022 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick3D
import QtQuick3D.Helpers

Node {
    id: node

    visible: false

    property list<vector3d> cameraPositions: [
        Qt.vector3d(0, 100, 300),
        Qt.vector3d(72.1542, 224.708, -71.7909),
        Qt.vector3d(-216.724, 83.6405, 200.725)
    ]

    property list<vector3d> cameraRotations: [
        Qt.vector3d(0, 0, 0),
        Qt.vector3d(-63.034, 117.714, 0),
        Qt.vector3d(-1.47937, 315.361 - 360, 0)
    ]

    property int cameraIndex : 0

    PointLight {
        bakeMode: node.lightBakeMode
        y: 190
        brightness: node.dirLightBrightness
        castsShadow: true
        shadowFactor: node.shadowFactor
        shadowBias: 20
        softShadowQuality: node.softShadowQuality
        shadowMapQuality: node.shadowMapQuality
        pcfFactor: node.pcfFactor
    }

    // Common
    property Lightmapper lightmapper: Lightmapper {
        source: "qrc:/assets/lightmaps/" + node.lightmapSource
        samples: node.samples
        texelsPerUnit: node.texelsPerUnit
        bounces: node.bounces
        denoiseSigma: node.denoiseSigma
        indirectLightFactor: node.indirectLightFactor
    }
    property string lightmapSource: "cornell-box/lm_cornellBox.bin"
    property bool enableLightmaps: true
    property real indirectLightFactor: 2.5
    property int samples: 2048
    property real texelsPerUnit: 2.0
    property int bounces: 3
    property real denoiseSigma: 8
    property int lightBakeMode: node.enableLightmaps ? Light.BakeModeAll : Light.BakeModeDisabled

    property real shadowFactor: 90
    property int shadowMapQuality: Light.ShadowMapQualityUltra
    property int softShadowQuality: Light.PCF16
    property real pcfFactor: 1

    property real ssgiIndirectLightBoost: 1

    // Environment
    property int backgroundMode: SceneEnvironment.Color
    property Texture lightProbe: null

    property real probeExposure: 1.0

    // Directional light
    property real dirLightX: -11.0
    property real dirLightY: -160
    property real dirLightBrightness: 1.0


    // Materials
    PrincipledMaterial {
        id: floor_material
        baseColor: "#ffb9b5ad"
        roughness: 0.9
        alphaMode: PrincipledMaterial.Opaque
    }
    PrincipledMaterial {
        id: ceiling_material
        baseColor: "#ffb9b5ad"
        roughness: 0.9
        alphaMode: PrincipledMaterial.Opaque
    }
    PrincipledMaterial {
        id: backWall_material
        baseColor: "#ffb9b5ad"
        roughness: 0.9
        alphaMode: PrincipledMaterial.Opaque
    }
    PrincipledMaterial {
        id: rightWall_material
        baseColor: "#ff247317"
        roughness: 0.9
        alphaMode: PrincipledMaterial.Opaque
    }
    PrincipledMaterial {
        id: leftWall_material
        baseColor: "#ffa1110d"
        roughness: 0.9
        alphaMode: PrincipledMaterial.Opaque
    }
    PrincipledMaterial {
        id: shortBox_material
        baseColor: "#ffb9b5ad"
        roughness: 0.9
        alphaMode: PrincipledMaterial.Opaque
    }
    PrincipledMaterial {
        id: tallBox_material
        baseColor: "#ffb9b5ad"
        roughness: 0.9
        alphaMode: PrincipledMaterial.Opaque
    }
    PrincipledMaterial {
        id: light_material
        baseColor: "#ffc7c7c7"
        roughness: 0.9
        emissiveFactor: Qt.vector3d(1, 1, 1)
        alphaMode: PrincipledMaterial.Opaque
    }
    PrincipledMaterial {
        id: _material
        metalness: 1
        roughness: 1
        alphaMode: PrincipledMaterial.Opaque
    }
    // end of Materials

    Model {
        id: cornellBox_Original
        rotation: Qt.quaternion(0.707107, 0.707107, 0, 0)
        scale: Qt.vector3d(100, 100, 100)
        source: "qrc:/assets/CornellBox/cornellBox.mesh"
        receivesReflections: true
        usedInBakedLighting: node.enableLightmaps
        bakedLightmap: BakedLightmap {
            enabled: node.enableLightmaps
            key: "cornellBox"
        }
        materials: [
            floor_material,
            ceiling_material,
            backWall_material,
            rightWall_material,
            leftWall_material,
            shortBox_material,
            tallBox_material,
            light_material
        ]
    }
}
