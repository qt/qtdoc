// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Shapes

Shape {
    id: svgPathItem

    width: 200
    height: 200

    property alias gradient: shape.fillGradient
    property alias strokeStyle: shape.strokeStyle
    property alias strokeWidth: shape.strokeWidth
    property alias strokeColor: shape.strokeColor
    property alias dashPattern: shape.dashPattern
    property alias joinStyle: shape.joinStyle
    property alias fillColor: shape.fillColor
    property alias path: pathSvg.path
    property alias dashOffset: shape.dashOffset

    layer.enabled: antialiasing
    layer.smooth: antialiasing
    layer.textureSize: Qt.size(width * 2, height * 2)

    ShapePath {
        id: shape
        PathSvg {
            id: pathSvg
        }
    }
}
