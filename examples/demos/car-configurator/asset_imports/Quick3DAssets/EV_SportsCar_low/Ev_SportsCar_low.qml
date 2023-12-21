// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick3D
import ComponentBundles.MaterialBundle

Node {
    id: node

    property int stateController: 0

    // Resources
    property url textureData: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/EV_SportsCar_low/maps/textureData.jpg"
    property url textureData53: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/EV_SportsCar_low/maps/textureData53.jpg"
    property url textureData108: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/EV_SportsCar_low/maps/textureData108.jpg"
    property url textureData6: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/EV_SportsCar_low/maps/textureData6.png"
    property url textureData48: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/EV_SportsCar_low/maps/textureData48.jpg"
    property url textureData8: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/EV_SportsCar_low/maps/textureData8.jpg"
    property url textureData50: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/EV_SportsCar_low/maps/textureData50.jpg"
    property url textureData42: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/EV_SportsCar_low/maps/textureData42.jpg"
    property url textureData56: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/EV_SportsCar_low/maps/textureData56.jpg"
    property url textureData30: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/EV_SportsCar_low/maps/textureData30.jpg"
    property url textureData63: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/EV_SportsCar_low/maps/textureData63.jpg"
    property url textureData45: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/EV_SportsCar_low/maps/textureData45.jpg"
    property url textureData67: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/EV_SportsCar_low/maps/textureData67.jpg"
    property url textureData74: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/EV_SportsCar_low/maps/textureData74.jpg"
    property url textureData17: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/EV_SportsCar_low/maps/textureData17.png"
    property url textureData90: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/EV_SportsCar_low/maps/textureData90.jpg"
    property url textureData105: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/EV_SportsCar_low/maps/textureData105.png"
    property bool lightsOn: true
    Texture {
        id: _0_texture
        generateMipmaps: true
        mipFilter: Texture.Linear
        source: node.textureData6
    }
    Texture {
        id: _1_texture
        pivotV: 1
        positionV: 4
        scaleU: 5
        scaleV: 5
        generateMipmaps: true
        mipFilter: Texture.Linear
        source: node.textureData8
    }
    Texture {
        id: _5_texture
        generateMipmaps: true
        mipFilter: Texture.Linear
        source: node.textureData42
    }
    Texture {
        id: _10_texture
        generateMipmaps: true
        mipFilter: Texture.Linear
        source: node.textureData56
    }
    Texture {
        id: _6_texture
        generateMipmaps: true
        mipFilter: Texture.Linear
        source: node.textureData45
    }
    Texture {
        id: _9_texture
        generateMipmaps: true
        mipFilter: Texture.Linear
        source: node.textureData53
    }
    Texture {
        id: _2_texture
        generateMipmaps: true
        mipFilter: Texture.Linear
        source: node.textureData17
    }
    Texture {
        id: _7_texture
        generateMipmaps: true
        mipFilter: Texture.Linear
        source: node.textureData48
    }
    Texture {
        id: _3_texture
        generateMipmaps: true
        mipFilter: Texture.Linear
        source: node.textureData
    }
    Texture {
        id: _13_texture
        generateMipmaps: true
        mipFilter: Texture.Linear
        source: node.textureData74
    }
    Texture {
        id: _8_texture
        generateMipmaps: true
        mipFilter: Texture.Linear
        source: node.textureData50
    }
    Texture {
        id: _14_texture
        generateMipmaps: true
        mipFilter: Texture.Linear
        source: node.textureData90
    }
    Texture {
        id: _12_texture
        generateMipmaps: true
        mipFilter: Texture.Linear
        source: node.textureData67
    }
    Texture {
        id: _15_texture
        generateMipmaps: true
        mipFilter: Texture.Linear
        source: node.textureData105
    }
    Texture {
        id: _11_texture
        generateMipmaps: true
        mipFilter: Texture.Linear
        source: node.textureData63
    }
    Texture {
        id: _16_texture
        generateMipmaps: true
        mipFilter: Texture.Linear
        source: node.textureData108
    }
    Texture {
        id: _4_texture
        generateMipmaps: true
        mipFilter: Texture.Linear
        source: node.textureData30
    }

    // Nodes:
    Node {
        id: root_object
        objectName: "ROOT"
        Model {
            id: body
            objectName: "Body"
            y: 0.6449694037437439
            source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/EV_SportsCar_low/meshes/body_mesh.mesh"
            castsShadows: true
            receivesShadows: true
            materials: [
                carPaint_material,
                carPaintBlackBump_material,
                metalDark_material9,
                plasticBlack_material,
                chrome_material11,
                glassLights_material12,
                glassRedLights_material13,
                glassLightsIllum_material14,
                glassTextured_material,
                intCarpet_material18
            ]
        }
        Model {
            id: chargingCap
            objectName: "ChargingCap"
            y: 1.004989743232727
            z: -1.5241049528121948
            rotation: Qt.quaternion(0.845673, -0.533702, 0, 0)
            scale.x: 1
            scale.y: 1
            scale.z: 1
            source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/EV_SportsCar_low/meshes/chargingCap_mesh.mesh"
            materials: [
                carPaint_material23,
                plasticBlack_material24
            ]
        }
        Model {
            id: headlights
            objectName: "Headlights"
            y: 0.5664713978767395
            z: 1.7861577272415161
            source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/EV_SportsCar_low/meshes/headlights_mesh.mesh"
            materials: [
                plasticBlack_material24,
                chrome_material,
                chromeLightsBMP_material,
                glassLightsLens_material,
                glassLights_material,
                metalDark_material
            ]
        }
        Model {
            id: hood
            objectName: "Hood"
            y: 0.7891814112663269
            z: 0.6023856401443481
            source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/EV_SportsCar_low/meshes/hood_mesh.mesh"
            materials: [
                carPaint_material23,
                plasticBlack_material24,
                chrome_material
            ]
        }
        Model {
            id: interior
            objectName: "Interior"
            y: 0.7498878240585327
            z: 0.1537650227546692
            source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/EV_SportsCar_low/meshes/interior_mesh.mesh"
            materials: [
                plasticBlack_material24,
                chrome_material,
                metalMirror_material,
                intCarpet_material,
                intAlcanataraGrey_material,
                intLeatherBlack_material,
                intSeatBelt_material,
                intButtons_material,
                intGrillBump_material
            ]
        }
        Model {
            id: dash
            objectName: "Dash"
            y: 0.6341137886047363
            z: 0.24422581493854523
            source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/EV_SportsCar_low/meshes/dash_mesh.mesh"
            materials: [
                metalDark_material,
                plasticBlack_material24,
                chrome_material,
                glassLights_material,
                glassRedLights_material,
                glassLightsIllum_material,
                intAlcanataraGrey_material,
                intLeatherBlack_material,
                intAluminiumBrushed_material,
                intStitchesRed_material,
                intLeatherSeatsPattern_material,
                intButtons_material,
                intGrillBump_material
            ]
        }
        Model {
            id: seats
            objectName: "Seats"
            y: 0.6852515935897827
            z: -0.17120154201984406
            source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/EV_SportsCar_low/meshes/seats_mesh.mesh"
            materials: [
                metalDark_material,
                plasticBlack_material24,
                aluminium_material,
                plasticRed_material,
                intLeatherPerforatedBlack_material,
                intLeatherBlack_material
            ]
        }
        Model {
            id: steeringWheel
            objectName: "SteeringWheel"
            x: 0.35999995470046997
            y: 0.7381047606468201
            z: 0.3709505796432495
            source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/EV_SportsCar_low/meshes/steeringWheel_mesh.mesh"
            materials: [
                plasticBlack_material24,
                chrome_material,
                intLeatherBlack_material,
                intAluminiumBrushed_material,
                intButtons_material
            ]
        }
        Model {
            id: taillights
            objectName: "Taillights"
            y: 0.7833704948425293
            z: -1.7988189458847046
            source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/EV_SportsCar_low/meshes/taillights_mesh.mesh"
            materials: [
                plasticBlack_material24,
                chrome_material,
                glassRedLights_material,
                glassLights_material,
                tailLightsIllum_material
            ]
        }
        Model {
            id: trunkLid
            objectName: "TrunkLid"
            y: 1.1552858352661133
            z: -0.5674706697463989
            source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/EV_SportsCar_low/meshes/trunkLid_mesh.mesh"
            materials: [
                carPaint_material23,
                carPaintBlackBump_material82,
                metalDark_material,
                plasticBlack_material24
            ]
        }
        Model {
            id: wingFlaps
            objectName: "WingFlaps"
            y: 0.41297996044158936
            z: 0.16267994046211243
            source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/EV_SportsCar_low/meshes/mesh_014_mesh.mesh"
            materials: [
                metalDark_material
            ]
        }
        Model {
            id: brakeDiskRearLeft
            objectName: "BrakeDiskRearLeft"
            x: 0.00032216310501098633
            y: 0.3521454930305481
            z: -1.3741973638534546
            source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/EV_SportsCar_low/meshes/mesh_016_mesh.mesh"
            materials: [
                wheelBrakeDisk_material
            ]
        }
        Model {
            id: hoodEngineCover
            objectName: "HoodEngineCover"
            y: 0.5375130772590637
            z: 1.4772337675094604
            source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/EV_SportsCar_low/meshes/hoodEngineCover_mesh.mesh"
            materials: [
                plasticBlack_material24,
                intCarpet_material
            ]
        }
        Model {
            id: trunkEngineCover
            objectName: "TrunkEngineCover"
            y: 0.7631296515464783
            z: -0.810766875743866
            source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/EV_SportsCar_low/meshes/trunkEngineCover_mesh.mesh"
            materials: [
                plasticBlack_material24,
                intCarpet_material
            ]
        }
        Model {
            id: brakeDiskFrLeft
            objectName: "BrakeDiskFrLeft"
            y: 0.3521455228328705
            z: 1.2830324172973633
            source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/EV_SportsCar_low/meshes/mesh_021_mesh.mesh"
            materials: [
                wheelBrakeDisk_material
            ]
        }
        Model {
            id: brakeCaliperFrLeft
            objectName: "BrakeCaliperFrLeft"
            y: 0.352143794298172
            z: 1.283031940460205
            source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/EV_SportsCar_low/meshes/brakeCaliperFrLeft_mesh.mesh"
            materials: [
                plasticBlack_material24,
                wheelCaliper_material
            ]
        }
        Model {
            id: brakeCaliperBkLeft
            objectName: "BrakeCaliperBkLeft"
            y: 0.352143794298172
            z: -1.374194860458374
            source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/EV_SportsCar_low/meshes/brakeCaliperBkLeft_mesh.mesh"
            materials: [
                plasticBlack_material24,
                wheelCaliper_material
            ]
        }
        Model {
            id: wheelFrLeft
            objectName: "WheelFrLeft"
            x: 0.8290001153945923
            y: 0.3521455228328705
            z: 1.2830325365066528
            source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/EV_SportsCar_low/meshes/wheelFrLeft_mesh.mesh"
            materials: [
                wheelTireBump_material,
                wheelRimBlack_material,
                chrome_material,
                carPaint_material23
            ]
        }
        Model {
            id: wheelBkLeft
            objectName: "WheelBkLeft"
            x: 0.8666445016860962
            y: 0.3521454632282257
            z: -1.3748871088027954
            source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/EV_SportsCar_low/meshes/wheelBkLeft_mesh.mesh"
            materials: [
                wheelTireBump_material,
                wheelRimBlack_material,
                chrome_material,
                carPaint_material23
            ]
        }
        Model {
            id: doorLeft
            objectName: "DoorLeft"
            x: 0.8845329880714417
            y: 0.6892746090888977
            z: 0.8587785363197327
            source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/EV_SportsCar_low/meshes/doorLeft_mesh.mesh"
            materials: [
                carPaint_material23,
                metalDark_material,
                plasticBlack_material24,
                chrome_material,
                glassLights_material,
                glassRedLights_material,
                chromeLightsBMP_material,
                glassLightsIllum_material,
                metalMirror_material,
                aluminium_material,
                glassWindsSide_material,
                intAlcanataraGrey_material,
                intLeatherBlack_material,
                plasticRed_material,
                intLeatherSeatsPattern_material,
                intButtons_material,
                intGrillBump_material
            ]
        }
        Model {
            id: doorRight
            objectName: "DoorRight"
            x: -0.8845332264900208
            y: 0.6892746090888977
            z: 0.8587785363197327
            source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/EV_SportsCar_low/meshes/doorRight_mesh.mesh"
            materials: [
                carPaint_material23,
                metalDark_material,
                plasticBlack_material24,
                chrome_material,
                glassLights_material,
                glassRedLights_material,
                chromeLightsBMP_material,
                glassLightsIllum_material,
                metalMirror_material,
                aluminium_material,
                glassWindsSide_material,
                intAlcanataraGrey_material,
                intLeatherBlack_material,
                plasticRed_material,
                intLeatherSeatsPattern_material,
                intButtons_material,
                intGrillBump_material
            ]
        }
        Model {
            id: wheelFrRight
            objectName: "WheelFrRight"
            x: -0.8290001153945923
            y: 0.3521454930305481
            z: 1.2830324172973633
            source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/EV_SportsCar_low/meshes/wheelFrRight_mesh.mesh"
            materials: [
                wheelTireBump_material,
                wheelRimBlack_material,
                chrome_material,
                carPaint_material23
            ]
        }
        Model {
            id: wheelBkRight
            objectName: "WheelBkRight"
            x: -0.8660000562667847
            y: 0.3521454632282257
            z: -1.3748869895935059
            source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/EV_SportsCar_low/meshes/wheelBkRight_mesh.mesh"
            materials: [
                wheelTireBump_material,
                wheelRimBlack_material,
                chrome_material,
                carPaint_material23
            ]
        }
    }

    Node {
        id: __materialLibrary__

        PrincipledMaterial {
            id: chrome_material
            objectName: "Chrome"
            baseColor: "#ff5a5a5a"
            metalness: 1
            roughness: 0.10000000149011612
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Opaque
            indexOfRefraction: 1.4500000476837158
        }

        PrincipledMaterial {
            id: chromeLightsBMP_material
            objectName: "ChromeLightsBMP"
            baseColor: "#ffff4c4c"
            metalness: 1
            roughness: 0.2136363983154297
            normalMap: _4_texture
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Opaque
            indexOfRefraction: 1.4500000476837158
        }

        PrincipledMaterial {
            id: glassTextured_material
            objectName: "GlassTextured"
            baseColor: "#ff0f0f0f"
            baseColorMap: _2_texture
            metalness: 1
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Blend
            indexOfRefraction: 1.4500000476837158
        }

        PrincipledMaterial {
            id: glassLightsLens_material
            objectName: "GlassLightsLens"
            baseColor: lightsOn? "#ffffff" : "#b3141313"
            metalness: 1
            roughness: 1
            emissiveFactor.z: lightsOn ? 1 : 0
            emissiveFactor.y: lightsOn ? 1 : 0
            emissiveFactor.x: lightsOn ? 1 : 0
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Opaque
            indexOfRefraction: 1.4500000476837158
        }

        PrincipledMaterial {
            id: glassLights_material
            objectName: "GlassLights"
            baseColor: "#26141313"
            metalness: 1
            roughness: 0.11977168917655945
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Blend
            indexOfRefraction: 1.4500000476837158
        }

        PrincipledMaterial {
            id: metalDark_material
            objectName: "MetalDark"
            baseColor: "#ff040404"
            metalness: 1
            roughness: 0.33000001311302185
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Opaque
            indexOfRefraction: 1.4500000476837158
        }

        PrincipledMaterial {
            id: metalMirror_material
            objectName: "MetalMirror"
            baseColor: "#ff5a5a5a"
            metalness: 1
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Opaque
            indexOfRefraction: 1.4500000476837158
        }

        PrincipledMaterial {
            id: intCarpet_material
            objectName: "IntCarpet"
            baseColorMap: _3_texture
            metalness: 1
            roughness: 0.6722149848937988
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Opaque
            indexOfRefraction: 1.4500000476837158
        }

        PrincipledMaterial {
            id: intAlcanataraGrey_material
            objectName: "intAlcanataraGrey"
            baseColorMap: _5_texture
            metalness: 1
            roughness: 0.5
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Opaque
            indexOfRefraction: 1.4500000476837158
        }

        PrincipledMaterial {
            id: intSeatBelt_material
            objectName: "IntSeatBelt"
            baseColorMap: _7_texture
            metalness: 1
            roughness: 0.25
            normalMap: _8_texture
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Opaque
            indexOfRefraction: 1.4500000476837158
        }

        PrincipledMaterial {
            id: intButtons_material
            objectName: "intButtons"
            baseColorMap: _9_texture
            roughness: 0.05000000074505806
            emissiveMap: _9_texture
            emissiveFactor.x: 1
            emissiveFactor.y: 1
            emissiveFactor.z: 1
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Opaque
            indexOfRefraction: 1.4500000476837158
        }

        PrincipledMaterial {
            id: intGrillBump_material
            objectName: "intGrillBump"
            baseColor: "#ff202020"
            metalness: 1
            roughness: 0.4000000059604645
            normalMap: _10_texture
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Opaque
            indexOfRefraction: 1.4500000476837158
        }

        PrincipledMaterial {
            id: intLeatherBlack_material
            objectName: "intLeatherBlack"
            baseColor: "#ff121212"
            metalness: 1
            roughness: 0.44999998807907104
            normalMap: _6_texture
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Opaque
            indexOfRefraction: 1.4500000476837158
        }

        PrincipledMaterial {
            id: carPaintBlackBump_material
            objectName: "CarPaintBlackBump"
            baseColor: "#ff050505"
            baseColorMap: _0_texture
            roughness: 0.4954545497894287
            normalMap: _1_texture
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Blend
            indexOfRefraction: 1.4500000476837158
        }

        PrincipledMaterial {
            id: glassRedLights_material
            objectName: "GlassRedLights"
            baseColor: "#80250000"
            metalness: 1
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Blend
            indexOfRefraction: 1.4500000476837158
        }

        PrincipledMaterial {
            id: glassLightsIllum_material
            baseColor: "#ffffff"
            emissiveFactor.z: 1
            emissiveFactor.y: 1
            emissiveFactor.x: 1
            objectName: "GlassLightsIllum"
            metalness: 1
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Opaque
            indexOfRefraction: 1.4500000476837158
        }

        PrincipledMaterial {
            id: intAluminiumBrushed_material
            objectName: "intAluminiumBrushed"
            baseColorMap: _11_texture
            metalness: 1
            roughness: 0.20000000298023224
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Opaque
            indexOfRefraction: 1.4500000476837158
        }

        PrincipledMaterial {
            id: metalDark_material9
            objectName: "MetalDark"
            baseColor: "#ff040404"
            metalness: 1
            roughness: 0.33000001311302185
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Opaque
            indexOfRefraction: 1.4500000476837158
        }

        PrincipledMaterial {
            id: plasticBlack_material
            objectName: "PlasticBlack"
            baseColor: "#ff151515"
            metalness: 1
            roughness: 0.30000001192092896
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Opaque
            indexOfRefraction: 1.4500000476837158
        }

        PrincipledMaterial {
            id: intStitchesRed_material
            objectName: "intStitchesRed"
            baseColor: "#ff7a0000"
            metalness: 1
            roughness: 0.6000000238418579
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Blend
            indexOfRefraction: 1.4500000476837158
        }

        PrincipledMaterial {
            id: intLeatherSeatsPattern_material
            objectName: "intLeatherSeatsPattern"
            baseColor: "#ff121212"
            metalness: 1
            roughness: 0.44999998807907104
            normalMap: _12_texture
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Opaque
            indexOfRefraction: 1.4500000476837158
        }

        PrincipledMaterial {
            id: chrome_material11
            objectName: "Chrome"
            baseColor: "#ff5a5a5a"
            metalness: 1
            roughness: 0.10000000149011612
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Opaque
            indexOfRefraction: 1.4500000476837158
        }

        PrincipledMaterial {
            id: glassLights_material12
            objectName: "GlassLights"
            baseColor: "#26141313"
            metalness: 1
            roughness: 0.11977168917655945
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Blend
            indexOfRefraction: 1.4500000476837158
        }

        PrincipledMaterial {
            id: aluminium_material
            objectName: "Aluminium"
            baseColor: "#ff808080"
            metalness: 1
            roughness: 0.20000000298023224
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Opaque
            indexOfRefraction: 1.4500000476837158
        }

        PrincipledMaterial {
            id: plasticRed_material
            objectName: "PlasticRed"
            baseColor: "#ff630000"
            roughness: 0.40297383069992065
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Opaque
            indexOfRefraction: 1.4500000476837158
        }

        PrincipledMaterial {
            id: intLeatherPerforatedBlack_material
            objectName: "intLeatherPerforatedBlack"
            baseColor: "#ff121212"
            metalness: 1
            roughness: 0.3499999940395355
            normalMap: _13_texture
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Opaque
            indexOfRefraction: 1.4500000476837158
        }

        PrincipledMaterial {
            id: glassRedLights_material13
            objectName: "GlassRedLights"
            baseColor: "#80250000"
            metalness: 1
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Blend
            indexOfRefraction: 1.4500000476837158
        }

        PrincipledMaterial {
            id: glassLightsIllum_material14
            objectName: "GlassLightsIllum"
            metalness: 1
            emissiveFactor.x: 1
            emissiveFactor.y: 1
            emissiveFactor.z: 1
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Opaque
            indexOfRefraction: 1.4500000476837158
        }

        PrincipledMaterial {
            id: tailLightsIllum_material
            objectName: "TailLightsIllum"
            baseColor: lightsOn? "#ffff7132" : "#000000"
            metalness: 1
            roughness: 0.858578622341156
            emissiveFactor.x: lightsOn? 1 : 0
            emissiveFactor.y: lightsOn? 0.443137 : 0
            emissiveFactor.z: lightsOn? 0.196078 : 0
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Opaque
            indexOfRefraction: 1.4500000476837158

        }

        PrincipledMaterial {
            id: carPaintBlackBump_material82
            objectName: "CarPaintBlackBump"
            baseColor: "#ff050505"
            baseColorMap: _0_texture
            roughness: 0.4954545497894287
            normalMap: _1_texture
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Blend
            indexOfRefraction: 1.4500000476837158
        }

        PrincipledMaterial {
            id: wheelBrakeDisk_material
            objectName: "WheelBrakeDisk"
            baseColorMap: _14_texture
            metalness: 1
            roughness: 0.3499999940395355
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Opaque
            indexOfRefraction: 1.4500000476837158
        }

        PrincipledMaterial {
            id: carPaint_material_Custom
            objectName: "CarPaint"
            baseColor: "#131313"
            roughness: 0.10000000149011612
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Opaque
            clearcoatAmount: 1
            clearcoatRoughnessAmount: 0.029999999329447746
            indexOfRefraction: 1.4500000476837158
        }
        CarPaintMaterial {
                    id: carPaint_material

                    roughness: 0
                    secondaryColor: "#1e1e1e"
                    baseColor: "#000000"
                    objectName: "Car Paint"
                }

        PrincipledMaterial {
            id: intCarpet_material18
            objectName: "IntCarpet"
            baseColorMap: _3_texture
            metalness: 1
            roughness: 0.6722149848937988
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Opaque
            indexOfRefraction: 1.4500000476837158
        }

        PrincipledMaterial {
            id: wheelCaliper_material
            objectName: "WheelCaliper"
            baseColor: "#ff800000"
            metalness: 1
            roughness: 0.44999998807907104
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Opaque
            indexOfRefraction: 1.4500000476837158
        }

        PrincipledMaterial {
            id: wheelTireBump_material
            objectName: "WheelTireBump"
            baseColor: "#ff171717"
            metalness: 1
            roughness: 0.6000000238418579
            normalMap: _15_texture
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Opaque
        }

        PrincipledMaterial {
            id: carPaint_material23
            objectName: "CarPaint"
            baseColor: "#131313"
            roughness: 0.10000000149011612
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Opaque
            clearcoatAmount: 1
            clearcoatRoughnessAmount: 0.029999999329447746
            indexOfRefraction: 1.4500000476837158
        }

        PrincipledMaterial {
            id: wheelRimBlack_material
            objectName: "WheelRimBlack"
            baseColorMap: _16_texture
            metalness: 1
            roughness: 0.3499999940395355
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Opaque
            clearcoatAmount: 1
            clearcoatRoughnessAmount: 0.029999999329447746
            indexOfRefraction: 1.4500000476837158
        }

        PrincipledMaterial {
            id: plasticBlack_material24
            objectName: "PlasticBlack"
            baseColor: "#ff151515"
            metalness: 1
            roughness: 0.30000001192092896
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Opaque
            indexOfRefraction: 1.4500000476837158
        }

        PrincipledMaterial {
            id: glassWindsSide_material
            objectName: "GlassWindsSide"
            baseColor: "#40121212"
            metalness: 1
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Blend
            indexOfRefraction: 1.4500000476837158
        }
    }
    states: [
        State {
            name: "black"
            when: stateController == 0

            PropertyChanges {
                target: carPaint_material
                roughness: 0.2
            }

            PropertyChanges {
                target: body
                receivesShadows: false
                castsShadows: false
            }

            PropertyChanges {
                target: chargingCap
                receivesShadows: false
                castsShadows: false
            }

            PropertyChanges {
                target: headlights
                receivesShadows: false
                castsShadows: false
            }

            PropertyChanges {
                target: hood
                receivesShadows: false
                castsShadows: false
            }

            PropertyChanges {
                target: interior
                receivesShadows: false
                castsShadows: false
            }

            PropertyChanges {
                target: dash
                receivesShadows: false
                castsShadows: false
            }

            PropertyChanges {
                target: seats
                receivesShadows: false
                castsShadows: false
            }

            PropertyChanges {
                target: steeringWheel
                receivesShadows: false
                castsShadows: false
            }

            PropertyChanges {
                target: taillights
                receivesShadows: false
                castsShadows: false
            }

            PropertyChanges {
                target: trunkLid
                receivesShadows: false
                castsShadows: false
            }

            PropertyChanges {
                target: wingFlaps
                receivesShadows: false
                castsShadows: false
            }

            PropertyChanges {
                target: brakeDiskRearLeft
                receivesShadows: false
                castsShadows: false
            }

            PropertyChanges {
                target: hoodEngineCover
                receivesShadows: false
                castsShadows: false
            }

            PropertyChanges {
                target: trunkEngineCover
                receivesShadows: false
                castsShadows: false
            }

            PropertyChanges {
                target: brakeDiskFrLeft
                receivesShadows: false
                castsShadows: false
            }

            PropertyChanges {
                target: brakeCaliperFrLeft
                receivesShadows: false
                castsShadows: false
            }

            PropertyChanges {
                target: brakeCaliperBkLeft
                receivesShadows: false
                castsShadows: false
            }

            PropertyChanges {
                target: wheelFrLeft
                receivesShadows: false
                castsShadows: false
            }

            PropertyChanges {
                target: wheelBkLeft
                receivesShadows: false
                castsShadows: false
            }

            PropertyChanges {
                target: doorRight
                receivesShadows: false
                castsShadows: false
            }

            PropertyChanges {
                target: doorLeft
                receivesShadows: false
                castsShadows: false
            }

            PropertyChanges {
                target: wheelFrRight
                receivesShadows: false
                castsShadows: false
            }

            PropertyChanges {
                target: wheelBkRight
                receivesShadows: false
                castsShadows: false
            }
        },
        State {
            name: "white"
            when: stateController == 1

            PropertyChanges {
                target: carPaint_material23
                roughness: 0.2
                clearcoat: 0.5
                baseColor: "#a6a6a6"
            }
            PropertyChanges {
                target: carPaint_material
                roughness: 0.2
                clearcoat: 0.5
                baseColor: "#a6a6a6"
            }

        },
        State {
            name: "yellow"
            when: stateController == 2

            PropertyChanges {
                target: carPaint_material23
                roughness: 0.1
                baseColor: "#de8517"
            }
            PropertyChanges {
                target: carPaint_material
                roughness: 0.1
                baseColor: "#de8517"
            }
        },
        State {
            name: "red"
            when: stateController == 3

            PropertyChanges {
                target: carPaint_material23
                baseColor: "#a21010"
            }
            PropertyChanges {
                target: carPaint_material
                baseColor: "#a21010"
            }
        }
    ]
}
