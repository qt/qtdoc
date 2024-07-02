// Copyright (C) 2024 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick3D
import Quick3DAssets.InteriorShadow

Node {
    id: node

    // Resources
    property url textureData: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/InteriorShadow/maps/textureData.png"
    Texture {
        id: _0_texture
        generateMipmaps: true
        mipFilter: Texture.Linear
        source: node.textureData
    }

    // Nodes:
    Model {
        id: interior
        objectName: "Interior"
        y: 0.7498878240585327
        z: 0.1537650227546692
        source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/InteriorShadow/meshes/mesh_005_mesh.mesh"
        materials: [
            material_001_material
        ]
    }

    Node {
        id: __materialLibrary__

        PrincipledMaterial {
            id: material_001_material
            baseColor: "#ffffff"
            lighting: PrincipledMaterial.NoLighting
            blendMode: PrincipledMaterial.Multiply
            objectName: "Material.001"
            baseColorMap: _0_texture
            roughness: 0.5
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Blend
        }
    }
}
