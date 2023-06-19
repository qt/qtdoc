// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick3D
import QtQuick3D.Physics

StaticRigidBody {
    // table radius: 0.482967cm
    property real tableRadius: 30
    property real scaleAll: tableRadius / 0.482967 // HACK: QTBUG-114183
    eulerRotation: Qt.vector3d(-90, 0, 0)
    position: Qt.vector3d(0, -50, 0)

    collisionShapes: TriangleMeshShape {
        scale: Qt.vector3d(1, 1, 1).times(scaleAll)
        source: "meshes/side_Table_Pine_LOD0_M_Side_Table_Natural_Wenge_Wood_4K_0.mesh"
    }

    RoundTable {
        scale: Qt.vector3d(1, 1, 1).times(scaleAll)
    }
}
