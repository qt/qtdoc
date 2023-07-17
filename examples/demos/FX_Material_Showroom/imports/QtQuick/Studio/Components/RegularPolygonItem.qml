// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick 2.10
import QtQuick.Shapes 1.12

/*!
    \qmltype RegularPolygon
    \inqmlmodule QtQuick.Studio.Components
    \since QtQuick.Studio.Components 1.0
    \inherits Shape

    \brief A filled regular polygon with an optional border.
*/

Shape {
    id: root
    width: 200
    height: 200

/*!
    The radius used to draw rounded corners.

    The default value is 10.

    If radius is non-zero, the corners will be rounded, otherwise they will
    be sharp. The radius can also be specified separately for each corner by
    using the \l bottomLeftRadius, \l bottomRightRadius, \l topLeftRadius, and
    \l topRightRadius properties.
*/
    property int radius: 10

/*!
    The gradient of the regular polygon fill color.

    By default, no gradient is enabled and the value is null. In this case, the
    fill uses a solid color based on the value of \l fillColor.

    When set, \l fillColor is ignored and filling is done using one of the
    \l ShapeGradient subtypes.

    \note The \l Gradient type cannot be used here. Rather, prefer using one of
    the advanced subtypes, like \l LinearGradient.
*/
    property alias gradient: path.fillGradient

/*!
    The style of the regular polygon border.

    \value ShapePath.SolidLine
           A solid line. This is the default value.
    \value ShapePath.DashLine
           Dashes separated by a few pixels.
           The \l dashPattern property specifies the dash pattern.

    \sa Qt::PenStyle
*/
    property alias strokeStyle: path.strokeStyle

/*!
    The width of the border of the regular polygon.

    The default value is 4.

    A width of 1 creates a thin line. For no line, use a negative value or a
    transparent color.

    \note The width of the regular polygon's border does not affect the geometry of
    the regular polygon itself or its position relative to other items if anchors are
    used.

    The border is rendered within the regular polygon's boundaries.
*/
    property alias strokeWidth: path.strokeWidth

/*!
    The color used to draw the border of the regular polygon.

    When set to \c transparent, no line is drawn.

    The default value is \c red.

    \sa QColor
*/
    property alias strokeColor: path.strokeColor

/*!
    The dash pattern of the regular polygon border specified as the dashes and the
    gaps between them.

    The dash pattern is specified in units of the pen's width. That is, a dash
    with the length 5 and width 10 is 50 pixels long.

    The default value is (4, 2), meaning a dash of 4 * \l strokeWidth pixels
    followed by a space of 2 * \l strokeWidth pixels.

    \sa QPen::setDashPattern()
*/
    property alias dashPattern: path.dashPattern


    property alias joinStyle: path.joinStyle

/*!
    The regular polygon fill color.

    A gradient for the fill can be specified by using \l gradient. If both a
    color and a gradient are specified, the gradient is used.

    When set to \c transparent, no filling occurs.

    The default value is \c white.
*/
    property alias fillColor: path.fillColor

/*!
    The starting point of the dash pattern for the regular polygon border.

    The offset is measured in terms of the units used to specify the dash
    pattern. For example, a pattern where each stroke is four units long,
    followed by a gap of two units, will begin with the stroke when drawn
    as a line. However, if the dash offset is set to 4.0, any line drawn
    will begin with the gap. Values of the offset up to 4.0 will cause part
    of the stroke to be drawn first, and values of the offset between 4.0 and
    6.0 will cause the line to begin with part of the gap.

    The default value is 0.

    \sa QPen::setDashOffset()
*/
    property alias dashOffset: path.dashOffset

/*!
    Number of sides on the polygon.
*/
    property int sideCount: 6

    layer.enabled: root.antialiasing
    layer.smooth: root.antialiasing
    layer.samples: root.antialiasing ? 4 : 0

    // This is used to make the bounding box of the item a bit bigger so it will draw sharp edges
    // in case of large stroke width instead of cutting it off.
    Item {
        anchors.fill: parent
        anchors.margins: -root.strokeWidth
    }

    ShapePath {
        id: path

        joinStyle: ShapePath.MiterJoin
        strokeWidth: 4
        strokeColor: "red"
        startX: 0
        startY: 0
    }

    onSideCountChanged: root.constructPolygon()
    onRadiusChanged: {
        // Only construct polygon if radius changed from 0 to 1 or vice versa.
        if ((root.radius + root.__previousRadius) === 1)
            root.constructPolygon()

        root.__previousRadius = root.radius
    }
    Component.onCompleted: root.constructPolygon()

    property real __centerX: root.width / 2
    property real __centerY: root.height / 2
    property real __radius: Math.min(root.width, root.height) / 2

    property int __previousRadius: root.radius

    property int minRadius: 0
    property int maxRadius: root.__radius * Math.cos(root.toRadians(180.0 / root.sideCount))

    property int __actualRadius: Math.max(root.minRadius, Math.min(root.maxRadius, root.radius))

    function constructPolygon() {
        root.clearPathElements()

        if (root.radius === 0)
            root.constructNonRoundedPolygonPath()
        else
            root.constructRoundedPolygonPath()
    }

    function toRadians(degrees) {
        return degrees * (Math.PI / 180.0)
    }

    function constructNonRoundedPolygonPath() {
        for (var cornerNumber = 0; cornerNumber < root.sideCount; cornerNumber++) {
            let angleToCorner = root.toRadians(cornerNumber * (360.0 / root.sideCount))

            if (cornerNumber === 0) {
                path.startX = Qt.binding(function() {
                    return root.__centerX + root.__radius * Math.cos(0)
                })
                path.startY = Qt.binding(function() {
                    return root.__centerY + root.__radius * Math.sin(0)
                })
            } else {
                let pathLine = Qt.createQmlObject('import QtQuick 2.15; PathLine {}', path)
                pathLine.x = Qt.binding(function() {
                    return root.__centerX + root.__radius * Math.cos(angleToCorner)
                })
                pathLine.y = Qt.binding(function() {
                    return root.__centerY + root.__radius * Math.sin(angleToCorner)
                })
                path.pathElements.push(pathLine)
            }
        }

        // Close the polygon
        var pathLineClose = Qt.createQmlObject('import QtQuick 2.15; PathLine {}', path)
        pathLineClose.x = Qt.binding(function() { return path.startX } )
        pathLineClose.y = Qt.binding(function() { return path.startY } )
        path.pathElements.push(pathLineClose)
    }

    property real __halfInteriorCornerAngle: 90 - (180.0 / root.sideCount)
    property real __halfCornerArcSweepAngle: 90 - root.__halfInteriorCornerAngle
    property real __distanceToCornerArcCenter: root.__radius - root.__actualRadius /
                                               Math.sin(root.toRadians(root.__halfInteriorCornerAngle))

    function constructRoundedPolygonPath() {
        for (var cornerNumber = 0; cornerNumber < root.sideCount; cornerNumber++) {
            let angleToCorner = cornerNumber * (360.0 / root.sideCount)

            let pathArc = Qt.createQmlObject('import QtQuick 2.15; PathArc {
                                                property real centerX;
                                                property real centerY }', path)
            pathArc.centerX = Qt.binding(function() {
                return root.__centerX + root.__distanceToCornerArcCenter
                        * Math.cos(root.toRadians(angleToCorner))
            })
            pathArc.centerY = Qt.binding(function() {
                return root.__centerY + root.__distanceToCornerArcCenter
                        * Math.sin(root.toRadians(angleToCorner))
            })
            pathArc.x = Qt.binding(function() {
                return pathArc.centerX + root.__actualRadius
                        * (Math.cos(root.toRadians(angleToCorner + root.__halfCornerArcSweepAngle)))
            })
            pathArc.y = Qt.binding(function() {
                return pathArc.centerY + root.__actualRadius
                        * (Math.sin(root.toRadians(angleToCorner + root.__halfCornerArcSweepAngle)))
            })
            pathArc.radiusX = Qt.binding(function() { return root.__actualRadius })
            pathArc.radiusY = Qt.binding(function() { return root.__actualRadius })

            if (cornerNumber === 0) {
                path.startX = Qt.binding(function() {
                    return pathArc.centerX + root.__actualRadius
                            * (Math.cos(root.toRadians(angleToCorner - root.__halfCornerArcSweepAngle)))
                })
                path.startY = Qt.binding(function() {
                    return pathArc.centerY + root.__actualRadius
                            * (Math.sin(root.toRadians(angleToCorner - root.__halfCornerArcSweepAngle)))
                })
            } else {
                let pathLine = Qt.createQmlObject('import QtQuick 2.15; PathLine {}', path)
                pathLine.x = Qt.binding(function() {
                    return pathArc.centerX + root.__actualRadius
                            * (Math.cos(root.toRadians(angleToCorner - root.__halfCornerArcSweepAngle)))
                })
                pathLine.y = Qt.binding(function() {
                    return pathArc.centerY + root.__actualRadius
                            * (Math.sin(root.toRadians(angleToCorner - root.__halfCornerArcSweepAngle)))
                })
                path.pathElements.push(pathLine)
            }

            path.pathElements.push(pathArc)
        }

        // Close the polygon
        var pathLineClose = Qt.createQmlObject('import QtQuick 2.15; PathLine {}', path)
        pathLineClose.x = Qt.binding(function() { return path.startX} )
        pathLineClose.y = Qt.binding(function() { return path.startY} )
        path.pathElements.push(pathLineClose)
    }

    function clearPathElements() {
        for (var i = 0; i !== path.pathElements.length; ++i)
            path.pathElements[i].destroy()

        path.pathElements = []
    }
}
