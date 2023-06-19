// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick3D
import QtQuick3D.Physics

DynamicRigidBody {
    property real diceWidth: 1.9 // cm
    collisionShapes: BoxShape {
        id: box
        extents: Qt.vector3d(1, 1, 1).times(diceWidth)
    }
    Dice_low {
        scale: Qt.vector3d(2.65, 2.65, 2.65).times(diceWidth)
    }
}
