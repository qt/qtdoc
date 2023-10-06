// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only WITH Qt-GPL-exception-1.0

import QtQuick
import QtQuick3D
import ComponentBundles.MaterialBundle

Node {
    id: root

    property int stateController: 0
    property real emisive: 0

    // Resources
    property url textureData: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/SUV_CarConfig/images/textureData.jpg"
    property url textureData6: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/SUV_CarConfig/images/textureData6.png"
    property url textureData8: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/SUV_CarConfig/images/textureData8.jpg"
    property url textureData45: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/SUV_CarConfig/images/textureData45.png"
    property url textureData13: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/SUV_CarConfig/images/textureData13.png"
    property url textureData26: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/SUV_CarConfig/images/textureData26.jpg"
    property url textureData37: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/SUV_CarConfig/images/textureData37.png"
    property url textureData68: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/SUV_CarConfig/images/textureData68.png"
    property url textureData70: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/SUV_CarConfig/images/textureData70.png"
    property url textureData72: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/SUV_CarConfig/images/textureData72.png"
    property alias suv_backLights_materialEmissiveFactorx: suv_backLights_material.emissiveFactor.x

    scale.z: 10
    scale.y: 10
    scale.x: 10

    Texture {
        id: _3_texture

        generateMipmaps: true
        mipFilter: Texture.Linear
        source: root.textureData
    }

    Texture {
        id: _0_texture

        generateMipmaps: true
        mipFilter: Texture.Linear
        source: root.textureData6
    }

    Texture {
        id: _1_texture

        generateMipmaps: true
        mipFilter: Texture.Linear
        source: root.textureData8
    }
    Texture {

        id: _4_texture

        generateMipmaps: true
        mipFilter: Texture.Linear
        source: root.textureData26
    }

    Texture {
        id: _2_texture

        generateMipmaps: true
        mipFilter: Texture.Linear
        source: root.textureData13
    }

    Texture {
        id: _5_texture

        generateMipmaps: true
        mipFilter: Texture.Linear
        source: root.textureData37
    }

    Texture {
        id: _6_texture

        generateMipmaps: true
        mipFilter: Texture.Linear
        source: root.textureData45
    }

    Texture {
        id: _7_texture

        generateMipmaps: true
        mipFilter: Texture.Linear
        source: root.textureData68
    }

    Texture {
        id: _8_texture

        generateMipmaps: true
        mipFilter: Texture.Linear
        source: root.textureData70
    }

    Texture {
        id: _9_texture

        generateMipmaps: true
        mipFilter: Texture.Linear
        source: root.textureData72
    }

    Node {
        id: suv

        Model {
            id: glow_backlight

            x: -0.6548800468444824
            y: 1.1143490076065063
            visible: false
            z: -2.167485475540161
            scale.x: 0.00999999
            scale.y: 0.00999999
            scale.z: 0.00999999
            source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/SUV_CarConfig/meshes/glow_1.mesh"
            materials: glow_Backlights_material
        }

        Model {
            id: glow_FrontLight

            visible: false
            source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/SUV_CarConfig/meshes/plane_004.mesh"
            materials: glow_FrontLight_material
        }

        Model {
            id: licensePlate

            y: 0.9461314678192139
            visible: false
            z: -2.3568108081817627
            rotation: Qt.quaternion(0.984526, 0.175237, 0, 0)
            source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/SUV_CarConfig/meshes/plane.mesh"
            materials: numberplate_material
        }

        Model {
            id: qtLogo

            y: 0.8477120995521545
            z: 2.4329633712768555
            rotation: Qt.quaternion(0.752374, 0.658736, 0, 0)
            scale.x: 0.141352
            scale.y: 0.141352
            scale.z: 0.141352
            source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/SUV_CarConfig/meshes/plane_002.mesh"
            materials: suv_rim_material
        }
        Model {
            id: suv_BackRedLights

            scale.x: 0.00999999
            scale.y: 0.00999999
            scale.z: 0.00999999
            source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/SUV_CarConfig/meshes/suv_WhiteLightGlass_low_1.mesh"
            materials: suv_backLights_material
        }

        Model {
            id: suv_BBreakLight

            rotation: Qt.quaternion(0.707107, -0.707107, 0, 0)
            scale.x: 1
            scale.y: 1
            scale.z: 1
            source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/SUV_CarConfig/meshes/suv_BackBreakLightr_low.mesh"
            materials: suv_BrakeRearLight_material
        }

        Model {
            id: suv_FrontChrome

            rotation: Qt.quaternion(0.707107, -0.707107, 0, 0)
            scale.x: 1
            scale.y: 1
            scale.z: 1
            source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/SUV_CarConfig/meshes/suv_FrontGrill_low_001.mesh"
            materials: suv_Chrome_material
        }

        Model {
            id: suv_FrontGrill

            source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/SUV_CarConfig/meshes/generic_SUV_2022_uv_game_custom_090.mesh"
            z: -0.01435
            materials: frontGrill_material
        }

        Model {
            id: suv_Glass

            scale.x: 0.00999999
            scale.y: 0.00999999
            scale.z: 0.00999999
            source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/SUV_CarConfig/meshes/glass.mesh"
            materials: glassMat
            receivesReflections: true
        }

        Model {
            id: suv_Headlights

            scale.x: 0.00999999
            scale.y: 0.00999999
            scale.z: 0.00999999
            source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/SUV_CarConfig/meshes/suv_Headlights_low_001.mesh"
            materials: suv_FrontLights_material
            receivesReflections: true
        }

        Model {
            id: suv_Headlights_low

            scale.x: 0.00999999
            scale.y: 0.00999999
            scale.z: 0.00999999
            source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/SUV_CarConfig/meshes/suv_Headlights_low.mesh"
            materials: [
                suv_SmallLights_material,
                suv_SmallLights_material
            ]
        }

        Model {
            id: suv_Hull

            scale.x: 0.00999999
            scale.y: 0.00999999
            scale.z: 0.00999999
            source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/SUV_CarConfig/meshes/generic_SUV_2022_uv_game_custom_003.mesh"
            materials: carPaint
            receivesReflections: true
        }

        Model {
            id: suv_Insides

            rotation: Qt.quaternion(0.707107, -0.707107, 0, 0)
            scale.x: 1
            scale.y: 1
            scale.z: 1
            source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/SUV_CarConfig/meshes/suv_BackLeftInnerDoor_low.mesh"
            materials: suv_inside_material
        }

        Model {
            id: suv_Rims

            x: -0
            y: -0
            scale.x: 0.00999999
            scale.y: 0.00999999
            scale.z: 0.00999999
            source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/SUV_CarConfig/meshes/suv_BackLeftDoorFrames_low.mesh"
            receivesReflections: true
            z: -0.00971
            materials: suv_Plastic_material
        }

        Model {
            id: suv_SideBlinkers

            source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/SUV_CarConfig/meshes/generic_SUV_2022_uv_game_custom_032.mesh"
            materials: suv_YellowLights_material
        }

        Model {
            id: tire_RimChrome

            x: -0.840537428855896
            y: 0.38042742013931274
            z: 1.5861561298370361
            rotation: Qt.quaternion(0.707106, 0, 0.707107, 0)
            scale.x: 1.05
            scale.y: 1.05
            scale.z: 1.05
            source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/SUV_CarConfig/meshes/newTire_Qt_low_003.mesh"
            materials: suv_rim_material
        }

        Model {
            id: tire_Rubber

            x: 0.8405910134315491
            y: 0.38042742013931274
            z: -1.4529887437820435
            rotation: Qt.quaternion(0.707107, 0, -0.707107, 0)
            scale.x: 1.05
            scale.y: 1.05
            scale.z: 1.05
            source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/SUV_CarConfig/meshes/newTire_Qt_low_005.mesh"
            materials: tireMaterial_material
        }

        Model {
            id: tireBreakDisc

            x: -0.840537428855896
            y: 0.38042742013931274
            z: 1.5861561298370361
            rotation: Qt.quaternion(0.7078, -0.706413, 0, 0)
            scale.x: 1.05
            scale.y: 1.05
            scale.z: 1.05
            source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/SUV_CarConfig/meshes/tireBreakDisc.mesh"
            materials: [suv_Plastic_material, suv_Chrome_material]
        }
    }

    Node {
        id: __materialLibrary__

        PrincipledMaterial {
            id: suv_backLights_material

            opacity: 0.566
            emissiveFactor.x: emisive
            objectName: "suv_backLights_material"
            baseColor: "#ffcc1414"
            baseColorMap: _4_texture
            alphaMode: PrincipledMaterial.Default
        }

        PrincipledMaterial {
            id: suv_Chrome_material

            objectName: "suv_Chrome_material"
            baseColor: "#707070"
            metalness: 0.9
            roughness: 0.65
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Opaque
        }

        PrincipledMaterial {
            id: frontGrill_material

            baseColor: "#646464"
            objectName: "frontGrill_material"
            baseColorMap: _5_texture
            metalness: 1
            roughness: 0.18515396118164062
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Blend
        }

        PrincipledMaterial {
            id: suv_Windows_material

            specularReflectionMap: piecenb41
            objectName: "suv_Windows_material"
            baseColor: "#bf000000"
            roughness: 0.52484
            alphaMode: PrincipledMaterial.Blend
        }

        PrincipledMaterial {
            id: suv_FrontLights_material

            opacity: 0.45
            clearcoatAmount: 1
            baseColor: "#525252"
            objectName: "suv_FrontLights_material"
            metalness: 1
            roughness: 0.12197801470756531
            alphaMode: PrincipledMaterial.Blend
        }

        PrincipledMaterial {
            id: glow_Backlights_material

            objectName: "glow_Backlights_material"
            baseColor: "#ffcccccc"
            baseColorMap: _0_texture
            metalness: 1
            roughness: 1
            emissiveMap: _1_texture
            emissiveFactor.x: 1
            emissiveFactor.y: 1
            emissiveFactor.z: 1
            alphaMode: PrincipledMaterial.Blend
        }

        PrincipledMaterial {
            id: suv_BrakeRearLight_material

            objectName: "suv_BrakeRearLight_material"
            baseColor: "#ffcc0100"
            roughness: 0.1
            alphaMode: PrincipledMaterial.Opaque
        }

        PrincipledMaterial {
            id: suv_SmallLights_material

            opacity: 0.5
            objectName: "suv_SmallLights_material"
            baseColor: "#484848"
            roughness: 0.1
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Blend
        }

        PrincipledMaterial {
            id: suv_OuterPaint_material

            objectName: "suv_OuterPaint_material"
            baseColor: "#ff000000"
            roughness: 0.10000000149011612
            alphaMode: PrincipledMaterial.Opaque
            clearcoatAmount: 1
            clearcoatRoughnessAmount: 0.029999999329447746
        }

        PrincipledMaterial {
            id: suv_inside_material

            objectName: "suv_inside_material"
            baseColor: "#ff020202"
            roughness: 0.8356143832206726
            alphaMode: PrincipledMaterial.Opaque
        }

        PrincipledMaterial {
            id: suv_Plastic_material

            cullMode: Material.NoCulling
            objectName: "suv_Plastic_material"
            baseColor: "#ff020202"
            roughness: 0.45
            alphaMode: PrincipledMaterial.Opaque
        }

        PrincipledMaterial {
            id: glow_FrontLight_material

            opacity: 1
            depthDrawMode: Material.AlwaysDepthDraw
            blendMode: PrincipledMaterial.Screen
            objectName: "glow_FrontLight_material"
            baseColorMap: _2_texture
            roughness: 1
            emissiveMap: _2_texture
            emissiveFactor.x: 3
            emissiveFactor.y: 3
            emissiveFactor.z: 3
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Blend
        }

        PrincipledMaterial {
            id: suv_YellowLights_material

            opacity: 0.5
            objectName: "suv_YellowLights_material"
            baseColor: "#6b4d40"
            roughness: 0.1
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Blend
        }

        PrincipledMaterial {
            id: suv_rim_material

            objectName: "suv_rim_material"
            baseColor: "#636363"
            metalness: 0.9
            roughness: 0.4
            cullMode: Material.BackFaceCulling
            alphaMode: PrincipledMaterial.Opaque
        }

        PrincipledMaterial {
            id: tireMaterial_material

            attenuationColor: "#4c4c4c"
            specularAmount: 0.10055
            baseColor: "#4f4f4f"
            objectName: "tireMaterial_material"
            baseColorMap: _7_texture
            metalness: 0
            roughness: 0.88289
            normalMap: _9_texture
            alphaMode: PrincipledMaterial.Opaque
        }

        PrincipledMaterial {
            id: numberplate_material

            objectName: "numberplate_material"
            baseColor: "#ffcccccc"
            baseColorMap: _3_texture
            metalness: 1
            roughness: 0.3136363625526428
            alphaMode: PrincipledMaterial.Opaque
        }

        PrincipledMaterial {
            id: qtEmblem_material

            objectName: "qtEmblem_material"
            baseColor: "#ff86e9b3"
            metalness: 1
            alphaMode: PrincipledMaterial.Opaque
        }

        CarPaintMaterial {
            id: carPaint

            roughness: 0
            secondaryColor: "#1e1e1e"
            baseColor: "#000000"
            objectName: "Car Paint"
        }

        Texture {
            id: piecenb41
            source: "images/piece-nb-41.hdr"
            mappingMode: Texture.LightProbe
        }

        SpecularGlossyMaterial {
            id: glassMat

            opacity: 0.792
            specularColor: "#3f3f3f"
            depthDrawMode: Material.AlwaysDepthDraw
            albedoColor: "#000000"
            cullMode: Material.NoCulling
            objectName: "Glass"
        }
    }

    states: [
        State {
            name: "black"
            when: stateController == 0
        },
        State {
            name: "white"
            when: stateController == 1

            PropertyChanges {
                target: carPaint
                roughness: 0.2
                clearcoat: 0.5
                baseColor: "#a6a6a6"
            }
        },
        State {
            name: "yellow"
            when: stateController == 2

            PropertyChanges {
                target: carPaint
                roughness: 0.1
                baseColor: "#de8517"
            }
        },
        State {
            name: "red"
            when: stateController == 3

            PropertyChanges {
                target: carPaint
                baseColor: "#a21010"
            }
        }
    ]
}
