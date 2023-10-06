// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only WITH Qt-GPL-exception-1.0

import QtQuick
import QtQuick3D

Node {
    id: root

    Model {
        id: aset_nature_rock_M_ventdee_LOD0

        source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/Ventdee_LOD0/meshes/aset_nature_rock_M_ventdee_LOD0.mesh"

        PrincipledMaterial {
            id: _mat_Default_OBJ_material

            roughness: 1
            roughnessMap: ventdee_2K_Roughness
            normalMap: ventdee_2K_Normal_LOD0
            baseColorMap: ventdee_2K_Albedo

            Texture {
                id: ventdee_2K_Albedo

                source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/Ventdee_LOD0/images/ventdee_2K_Albedo.jpg"
            }

            Texture {
                id: ventdee_2K_Normal_LOD0

                source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/Ventdee_LOD0/images/ventdee_2K_Normal_LOD0.jpg"
            }

            Texture {
                id: ventdee_2K_Roughness

                source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/Ventdee_LOD0/images/ventdee_2K_Roughness.jpg"
            }
        }
        materials: [
            _mat_Default_OBJ_material
        ]
    }
}
