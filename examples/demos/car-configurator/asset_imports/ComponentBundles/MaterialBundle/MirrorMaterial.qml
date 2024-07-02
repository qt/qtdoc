// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only WITH Qt-GPL-exception-1.0

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
