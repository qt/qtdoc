// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only WITH Qt-GPL-exception-1.0

import QtQuick
import QtQuick3D

Node {
    id: root

    Node {
        id: suv_mew

        Model {
            id: suv_BackLightContainers

            source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/SUV_CarConfig_NewParts/meshes/generic_SUV_2022_uv_game_custom_004.mesh"
            materials: suv_Plastic_material
        }
        Model {
            id: suv_BackLowerRedLight

            source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/SUV_CarConfig_NewParts/meshes/generic_SUV_2022_uv_game_custom_026.mesh"
            materials: suv_BackRedLightInterior_material
        }
        Model {
            id: suv_BottomGlareCover

            scale.x: 0.00999999
            scale.y: 0.00999999
            scale.z: 0.00999999
            source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/SUV_CarConfig_NewParts/meshes/suv_BackLeftDoorFrames_low_001.mesh"
            materials: suv_Plastic_Mat_material
        }
        Model {
            id: suv_FrontBlinker
            source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/SUV_CarConfig_NewParts/meshes/generic_SUV_2022_uv_game_custom_031.mesh"
            materials: suv_BlinkerInterior_material
        }
        Model {
            id: suv_FrontGrillDarkPlate_001

            rotation: Qt.quaternion(0.707107, -0.707107, 0, 0)
            scale.x: 1
            scale.y: 1
            scale.z: 1
            source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/SUV_CarConfig_NewParts/meshes/suv_FrontGrill_low_004.mesh"
            materials: suv_Plastic_material
        }
        Model {
            id: suv_FrontLightContainers

            source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/SUV_CarConfig_NewParts/meshes/generic_SUV_2022_uv_game_custom_189.mesh"
            materials: suv_Plastic_material
        }
        Model {
            id: suv_Headlights_Inner

            source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/SUV_CarConfig_NewParts/meshes/generic_SUV_2022_uv_game_custom_149.mesh"
            materials: suv_LightInterior_material
        }
        Model {
            id: suv_Headlights_low_002

            scale.x: 0.00999999
            scale.y: 0.00999999
            scale.z: 0.00999999
            source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/SUV_CarConfig_NewParts/meshes/suv_Headlights_low_004.mesh"
            materials: suv_BlinkerInterior_material
        }
        Model {
            id: suv_LowerLights_Inner

            source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/SUV_CarConfig_NewParts/meshes/generic_SUV_2022_uv_game_custom_151.mesh"
            materials: suv_LowerLightInterior_material
        }
        Model {
            id: suv_LowerLights_Inner_001

            source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/SUV_CarConfig_NewParts/meshes/generic_SUV_2022_uv_game_custom_014.mesh"
            materials: suv_LowerLightInterior_material
        }
        Model {
            id: suv_TrunkLight_low

            source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/SUV_CarConfig_NewParts/meshes/generic_SUV_2022_uv_game_custom_074.mesh"
            materials: suv_BackLightInterior_material
        }
    }

    Node {
        id: __materialLibrary__

        PrincipledMaterial {
            id: suv_Plastic_material

            objectName: "suv_Plastic_material"
            baseColor: "#ff020202"
            roughness: 0.4
            alphaMode: PrincipledMaterial.Opaque
        }

        PrincipledMaterial {
            id: suv_BackRedLightInterior_material

            objectName: "suv_BackRedLightInterior_material"
            baseColor: "#ffccc495"
            roughness: 0.5
            emissiveFactor.x: 1
            emissiveFactor.y: 1
            emissiveFactor.z: 1
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Opaque
        }

        PrincipledMaterial {
            id: suv_Plastic_Mat_material

            objectName: "suv_Plastic_Mat_material"
            baseColor: "#ff020202"
            roughness: 1
            alphaMode: PrincipledMaterial.Opaque
        }

        PrincipledMaterial {
            id: suv_BlinkerInterior_material

            objectName: "suv_BlinkerInterior_material"
            baseColor: "#ffccc495"
            roughness: 0.5
            emissiveFactor.x: 1
            emissiveFactor.y: 1
            emissiveFactor.z: 1
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Opaque
        }

        PrincipledMaterial {
            id: suv_LightInterior_material

            objectName: "suv_LightInterior_material"
            baseColor: "#d8d8d7"
            roughness: 0.5
            emissiveFactor.x: 0
            emissiveFactor.y: 0
            emissiveFactor.z: 0
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Opaque
        }

        PrincipledMaterial {
            id: suv_LowerLightInterior_material

            objectName: "suv_LowerLightInterior_material"
            baseColor: "#ffccc495"
            roughness: 0.5
            emissiveFactor.x: 1
            emissiveFactor.y: 1
            emissiveFactor.z: 1
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Opaque
        }

        PrincipledMaterial {
            id: suv_BackLightInterior_material

            objectName: "suv_BackLightInterior_material"
            baseColor: "#ffccc495"
            roughness: 0.5
            emissiveFactor.x: 1
            emissiveFactor.y: 1
            emissiveFactor.z: 1
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Opaque
        }
    }

    states: [
        State {
            name: "State1"
            when: !btnLight.checked
        },
        State {
            name: "State2"
            when: btnLight.checked

            PropertyChanges {
                target: suv_LightInterior_material
                lighting: PrincipledMaterial.NoLighting
                emissiveFactor.z: 2
                emissiveFactor.y: 2
                emissiveFactor.x: 2
                baseColor: "#ffffff"
            }
        }
    ]
}
