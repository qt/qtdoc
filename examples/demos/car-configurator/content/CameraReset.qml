// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick

Item {
    width: 1920
    height: 1080

    property vector3d position: Qt.vector3d(0, 0, 0)
    property vector3d rotation: Qt.vector3d(0, 0, 0)

    function resetPosition(pos) {
        pos = position
    }

    function resetRotation(rot) {
        rot = rotation
    }
}
