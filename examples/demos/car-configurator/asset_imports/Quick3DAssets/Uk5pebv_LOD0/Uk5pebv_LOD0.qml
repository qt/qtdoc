// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick3D

Node {
    id: rootNode

    Model {
        id: aset_nature_rock_M_uk5pebv_LOD0

        source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/Uk5pebv_LOD0/meshes/aset_nature_rock_M_uk5pebv_LOD0.mesh"

        PrincipledMaterial {
            id: defaultMaterial_material

            emissiveFactor.z: 1
            emissiveFactor.y: 1
            emissiveFactor.x: 1
            emissiveMap: uk5pebv_2K_Albedo
            roughness: 1
            roughnessMap: uk5pebv_2K_Roughness
            normalMap: uk5pebv_2K_Normal_LOD0
            baseColorMap: uk5pebv_2K_Albedo

            Texture {
                id: uk5pebv_2K_Albedo

                source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/Uk5pebv_LOD0/images/uk5pebv_2K_Albedo.jpg"
            }

            Texture {
                id: uk5pebv_2K_Normal_LOD0

                source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/Uk5pebv_LOD0/images/uk5pebv_2K_Normal_LOD0.jpg"
            }

            Texture {
                id: uk5pebv_2K_Roughness

                source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/Uk5pebv_LOD0/images/uk5pebv_2K_Roughness.jpg"
            }
        }
        materials: [
            defaultMaterial_material
        ]
    }
}
