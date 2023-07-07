// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick 2.15

GroupItem {
    id: root

    property int thickness: 45

    property int arrowSize: 80

    property int radius: 5
    property color color: "#b6b3b3"

    property alias begin: arc.begin
    property alias end: arc.end

    property bool flip: false

    transform: Scale {
        xScale: root.flip ? -1 : 1
        origin.x: root.width / 2
        origin.y: root.height / 2
    }

    ArcItem {
        id: arc
        x: 0
        y: 16
        width: 300
        height: 300
        capStyle: root.radius > 2 ? 32 : 0
        end: 180
        strokeWidth: root.thickness
        strokeColor: root.color
        fillColor: "#00000000"

        Item {
            anchors.fill: parent
            rotation: arc.end
            TriangleItem {
                id: triangle3
                x: root.width / 2

                y: -root.thickness / 2
                width: root.arrowSize
                height: root.arrowSize
                strokeWidth: -1
                rotation: 90
                radius: root.radius

                fillColor: root.color
            }
        }
    }
}
