// Copyright (C) 2024 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick3D

Node {
    id: node

    // Nodes:
    Model {
        id: hood
        objectName: "Hood"
        y: 0.7891814112663269
        z: 0.6023856401443481
        source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/Hood/meshes/hood_mesh.mesh"
        materials: [
            carPaint_001_material,
            plasticBlack_001_material,
            chrome_001_material
        ]
    }

    Node {
        id: __materialLibrary__

        PrincipledMaterial {
            id: carPaint_001_material
            objectName: "CarPaint.001"
            baseColor: "#ffb10000"
            roughness: 0.10000000149011612
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Opaque
            clearcoatAmount: 1
            clearcoatRoughnessAmount: 0.029999999329447746
            indexOfRefraction: 1.4500000476837158
        }

        PrincipledMaterial {
            id: plasticBlack_001_material
            objectName: "PlasticBlack.001"
            baseColor: "#ff151515"
            metalness: 1
            roughness: 0.30000001192092896
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Opaque
        }

        PrincipledMaterial {
            id: chrome_001_material
            objectName: "Chrome.001"
            baseColor: "#ff5a5a5a"
            metalness: 1
            roughness: 0.10000000149011612
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Opaque
        }
    }

    // Animations:
}
