// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick3D

PrincipledMaterial {
    id: mirror

    cullMode: Material.NoCulling
    clearcoatAmount: 1
    specularAmount: 1
    baseColor: "#ffffff"
    objectName: "Mirror"
    metalness: 1
    roughness: 0
}
