// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick 2.12

Item {

    width: 200
    height: 200
    id: root
    property bool flip: false
    property bool rotate: false

    property int thickness: 45

    property int arrowSize: 80

    property int radius: 5
    property color color: "#b6b3b3"

    property bool corner: false

    property bool flipCorner: false

    Item {
        id: content
        implicitWidth: Math.max(16, childrenRect.width + childrenRect.x)
        implicitHeight: Math.max(16, childrenRect.height + childrenRect.y)
        anchors.centerIn: parent

        scale: root.flip ? -1 : 1
        rotation: root.rotate ? 90 : 0

        TriangleItem {
            id: triangle
            x: 0
            y: 0
            anchors.verticalCenter: rectangle.verticalCenter
            rotation: -90
            strokeWidth: -1
            width: root.arrowSize
            height: root.arrowSize
            radius: root.radius
            fillColor: root.color
        }

        RectangleItem {
            id: rectangle
            x: root.arrowSize - root.radius * 2
            //y: ((root.rotate ? root.width : root.height) - root.thickness) / 2
            width: (root.rotate ? root.height : root.width) - (root.arrowSize - root.radius * 2)
            height: root.thickness
            strokeWidth: -1
            radius: root.radius
            fillColor: root.color
        }
        RectangleItem {
            id: rectangle1
            x: 260
            y: 202
            width: root.corner ? root.thickness : 0
            strokeWidth: -1
            height: root.corner ? (root.rotate ? root.width : root.height) / 2 : 0
            anchors.bottom: root.flipCorner ? undefined : rectangle.verticalCenter
            anchors.top: root.flipCorner ? rectangle.verticalCenter : undefined
            anchors.right: rectangle.right
            fillColor: root.color
            visible: root.corner
        }
    }
}
