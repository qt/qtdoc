// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick 2.10
import QtQuick.Shapes 1.12

/*!
    \qmltype BorderItem
    \inqmlmodule QtQuick.Studio.Components
    \since QtQuick.Studio.Components 1.0
    \inherits Shape

    \brief A border drawn in four segments: left, top, right, and bottom.

    The Border type is used to create borders out of four segments: left,
    top, right, and bottom. The \l drawLeft, \l drawTop, \l drawRight, and
    \l drawBottom properties can be used to determine whether each of the
    segments is visible.

    The \l borderMode property determines whether the border is drawn along
    the inside or outside edge of the item, or on top of the edge.

    The \l radius property specifies whether the border corners are rounded.
    The radius can also be specified separately for each corner. Because this
    introduces curved edges to the corners, it may be appropriate to set the
    \c antialiasing property that is inherited from \l Item to improve the
    appearance of the border.

    The \l joinStyle property specifies how to connect two border line segments.

    The \l strokeColor, \l strokeWidth, and \l strokeStyle properties specify
    the appearance of the border line. The \l dashPattern and \l dashOffset
    properties specify the appearance of dashed lines.

    The \l capStyle property specifies whether line ends are square or
    rounded.

    \section2 Example Usage

    You can use the Border component in \QDS to create different kinds of
    borders.

    \image studio-border.png

    The QML code looks as follows:

    \code
    BorderItem {
        id: openLeft
        width: 99
        height: 99
        antialiasing: true
        drawLeft: false
        strokeColor: "gray"
    }

    BorderItem {
        id: openTop
        width: 99
        height: 99
        antialiasing: true
        strokeColor: "#808080"
        drawTop: false
    }

    BorderItem {
        id: asymmetricalCorners
        width: 99
        height: 99
        antialiasing: true
        bottomLeftRadius: 0
        topRightRadius: 0
        strokeColor: "#808080"
    }

    BorderItem {
        id: dashedBorder
        width: 99
        height: 99
        antialiasing: true
        strokeStyle: 4
        strokeColor: "#808080"
    }
    \endcode
*/

Shape {
    id: root
    width: 200
    height: 150

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
    The radius of the top left border corner.

    \sa radius
*/
    property int topLeftRadius: root.radius

/*!
    The radius of the bottom left border corner.

    \sa radius
*/
    property int bottomLeftRadius: root.radius

/*!
    The radius of the top right border corner.

    \sa radius
*/
    property int topRightRadius: root.radius

/*!
    The radius of the bottom right border corner.

    \sa radius
*/
    property int bottomRightRadius: root.radius

/*!
    Whether the border corner is beveled.
*/
    property bool bevel: false

/*!
    The bevel of the top left border corner.

    \sa bevel
*/
    property bool topLeftBevel: root.bevel

/*!
    The bevel of the top right border corner.

    \sa bevel
*/
    property bool topRightBevel: root.bevel

/*!
    The bevel of the bottom right border corner.

    \sa bevel
*/
    property bool bottomRightBevel: root.bevel

/*!
    The bevel of the bottom left border corner.

    \sa bevel
*/
    property bool bottomLeftBevel: root.bevel

/*!
    The style of the border line.

    \value ShapePath.SolidLine
           A solid line. This is the default value.
    \value ShapePath.DashLine
           Dashes separated by a few pixels.
           The \l dashPattern property specifies the dash pattern.

    \sa Qt::PenStyle
*/
    property alias strokeStyle: path.strokeStyle

/*!
    The width of the border line.

    When set to a negative value, no line is drawn.

    The default value is 4.
*/
    property alias strokeWidth: path.strokeWidth

/*!
    The color of the border line.

    When set to \c transparent, no line is drawn.

    The default value is \c red.

    \sa QColor
*/
    property alias strokeColor: path.strokeColor

/*!
    The dash pattern of the border line specified as the dashes and the gaps
    between them.

    The dash pattern is specified in units of the pen's width. That is, a dash
    with the length 5 and width 10 is 50 pixels long.

    Each dash is also subject to cap styles, and therefore a dash of 1 with
    square cap set will extend 0.5 pixels out in each direction resulting in
    a total width of 2.

    The default \l capStyle is \c {ShapePath.SquareCap}, meaning that a square
    line end covers the end point and extends beyond it by half the line width.

    The default value is (4, 2), meaning a dash of 4 * \l strokeWidth pixels
    followed by a space of 2 * \l strokeWidth pixels.

    \sa QPen::setDashPattern()
*/
    property alias dashPattern: path.dashPattern

/*!
    The join style used to connect two border line segments.

    \value ShapePath.MiterJoin
           The outer edges of the lines are extended to meet at an angle, and
           this area is filled.
    \value ShapePath.BevelJoin
           The triangular notch between the two lines is filled.
           This is the default value.
    \value ShapePath.RoundJoin
           A circular arc between the two lines is filled.

    \sa Qt::PenJoinStyle
*/
    property alias joinStyle: path.joinStyle

/*!
    The starting point of the dash pattern for the border line.

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
    The cap style of the line.

    \value ShapePath.FlatCap
           A square line end that does not cover the end point of the line.
    \value ShapePath.SquareCap
           A square line end that covers the end point and extends beyond it
           by half the line width. This is the default value.
    \value ShapePath.RoundCap
           A rounded line end.

    \sa Qt::PenCapStyle
*/
    property alias capStyle: path.capStyle

    //property alias fillColor: path.fillColor

/*!
    Whether the top border is visible.

    The border segment is drawn if this property is set to \c true.
*/
    property bool drawTop: true

/*!
    Whether the bottom border is visible.

    The border segment is drawn if this property is set to \c true.
*/
    property bool drawBottom: true

/*!
    Whether the right border is visible.

    The border segment is drawn if this property is set to \c true.
*/
    property bool drawRight: true

/*!
    Whether the left border is visible.

    The border segment is drawn if this property is set to \c true.
*/
    property bool drawLeft: true

    layer.enabled: root.antialiasing
    layer.smooth: root.antialiasing
    layer.samples: root.antialiasing ? 4 : 0

/*!
    Where the border is drawn.

    \value Border.Inside
           The border is drawn along the inside edge of the item and does not
           affect the item width.
           This is the default value.
    \value Border.Middle
           The border is drawn over the edge of the item and does not
           affect the item width.
    \value Border.Outside
           The border is drawn along the outside edge of the item and increases
           the item width by the value of \l strokeWidth.

    \sa strokeWidth
*/
    property int borderMode: 0

    property real borderOffset: {
        if (root.borderMode === 0)
            return root.strokeWidth * 0.5
        if (root.borderMode === 1)
            return 0

        return -root.strokeWidth * 0.5
    }

/*!
    The property changes the way border radius is calculated.
    Deactivated by default.
*/
    property bool adjustBorderRadius: false

    Item {
        anchors.fill: parent
        anchors.margins: {
            if (root.borderMode === 0)
                return 0
            if (root.borderMode === 1)
                return -root.strokeWidth * 0.5

            return -root.strokeWidth
        }
    }

    ShapePath {
        id: path

        property int __maxRadius: Math.floor(Math.min(root.width, root.height) / 2)
        property int __topLeftRadius: Math.min(root.topLeftRadius, path.__maxRadius)
        property int __topRightRadius: Math.min(root.topRightRadius, path.__maxRadius)
        property int __bottomRightRadius: Math.min(root.bottomRightRadius, path.__maxRadius)
        property int __bottomLeftRadius: Math.min(root.bottomLeftRadius, path.__maxRadius)

        readonly property real __borderRadiusAdjustment: {
            if (root.adjustBorderRadius) {
                if (root.borderMode === 1)
                    return (root.strokeWidth * 0.5)
                if (root.borderMode === 2)
                    return root.strokeWidth
            }
            return 0
        }

        joinStyle: ShapePath.MiterJoin

        strokeWidth: 4
        strokeColor: "red"
        fillColor: "transparent"

        startX: path.__topLeftRadius + root.borderOffset + path.__borderRadiusAdjustment
        startY: root.borderOffset
    }

    onDrawTopChanged: root.constructBorderItem()
    onDrawRightChanged: root.constructBorderItem()
    onDrawBottomChanged: root.constructBorderItem()
    onDrawLeftChanged: root.constructBorderItem()

    function constructBorderItem() {
        root.clearPathElements()

        // Top line
        if (root.drawTop) {
            let pathLine = Qt.createQmlObject('import QtQuick 2.15; PathLine {}', path)
            pathLine.x = Qt.binding(function() { return root.width - path.__topRightRadius - root.borderOffset - path.__borderRadiusAdjustment })
            pathLine.y = Qt.binding(function() { return root.borderOffset })
            path.pathElements.push(pathLine)
        } else {
            let pathMove = Qt.createQmlObject('import QtQuick 2.15; PathMove {}', path)
            pathMove.x = Qt.binding(function() { return root.width - root.borderOffset })
            pathMove.y = Qt.binding(function() { return path.__topRightRadius + root.borderOffset + path.__borderRadiusAdjustment })
            path.pathElements.push(pathMove)
        }

        // Top right corner
        if (root.drawTop && root.drawRight) {
            let pathArc = Qt.createQmlObject('import QtQuick 2.15; PathArc {}', path)
            pathArc.x = Qt.binding(function() { return root.width - root.borderOffset })
            pathArc.y = Qt.binding(function() { return path.__topRightRadius + root.borderOffset + path.__borderRadiusAdjustment })
            pathArc.radiusX = Qt.binding(function() { return root.topRightBevel ? 50000 : path.__topRightRadius + path.__borderRadiusAdjustment })
            pathArc.radiusY = Qt.binding(function() { return root.topRightBevel ? 50000 : path.__topRightRadius + path.__borderRadiusAdjustment })
            path.pathElements.push(pathArc)
        }

        // Right line
        if (root.drawRight) {
            let pathLine = Qt.createQmlObject('import QtQuick 2.15; PathLine {}', path)
            pathLine.x = Qt.binding(function() { return root.width - root.borderOffset })
            pathLine.y = Qt.binding(function() { return root.height - path.__bottomRightRadius - root.borderOffset - path.__borderRadiusAdjustment })
            path.pathElements.push(pathLine)
        } else {
            let pathMove = Qt.createQmlObject('import QtQuick 2.15; PathMove {}', path)
            pathMove.x = Qt.binding(function() { return root.width - path.__bottomRightRadius - root.borderOffset - path.__borderRadiusAdjustment })
            pathMove.y = Qt.binding(function() { return root.height - root.borderOffset })
            path.pathElements.push(pathMove)
        }

        // Bottom right corner
        if (root.drawBottom && root.drawRight) {
            let pathArc = Qt.createQmlObject('import QtQuick 2.15; PathArc {}', path)
            pathArc.x = Qt.binding(function() { return root.width - path.__bottomRightRadius - root.borderOffset - path.__borderRadiusAdjustment })
            pathArc.y = Qt.binding(function() { return root.height - root.borderOffset })
            pathArc.radiusX = Qt.binding(function() { return root.bottomRightBevel ? 50000 : path.__bottomRightRadius + path.__borderRadiusAdjustment })
            pathArc.radiusY = Qt.binding(function() { return root.bottomRightBevel ? 50000 : path.__bottomRightRadius + path.__borderRadiusAdjustment })
            path.pathElements.push(pathArc)
        }

        // Bottom line
        if (root.drawBottom) {
            let pathLine = Qt.createQmlObject('import QtQuick 2.15; PathLine {}', path)
            pathLine.x = Qt.binding(function() { return path.__bottomLeftRadius + root.borderOffset + path.__borderRadiusAdjustment })
            pathLine.y = Qt.binding(function() { return root.height - root.borderOffset })
            path.pathElements.push(pathLine)
        } else {
            let pathMove = Qt.createQmlObject('import QtQuick 2.15; PathMove {}', path)
            pathMove.x = Qt.binding(function() { return root.borderOffset })
            pathMove.y = Qt.binding(function() { return root.height - path.__bottomLeftRadius - root.borderOffset - path.__borderRadiusAdjustment })
            path.pathElements.push(pathMove)
        }

        // Bottom left corner
        if (root.drawBottom && root.drawLeft) {
            let pathArc = Qt.createQmlObject('import QtQuick 2.15; PathArc {}', path)
            pathArc.x = Qt.binding(function() { return root.borderOffset })
            pathArc.y = Qt.binding(function() { return root.height - path.__bottomLeftRadius - root.borderOffset - path.__borderRadiusAdjustment })
            pathArc.radiusX = Qt.binding(function() { return root.bottomLeftBevel ? 50000 : path.__bottomLeftRadius + path.__borderRadiusAdjustment })
            pathArc.radiusY = Qt.binding(function() { return root.bottomLeftBevel ? 50000 : path.__bottomLeftRadius + path.__borderRadiusAdjustment })
            path.pathElements.push(pathArc)
        }

        // Left line
        if (root.drawLeft) {
            let pathLine = Qt.createQmlObject('import QtQuick 2.15; PathLine {}', path)
            pathLine.x = Qt.binding(function() { return root.borderOffset })
            pathLine.y = Qt.binding(function() { return path.__topLeftRadius + root.borderOffset + path.__borderRadiusAdjustment })
            path.pathElements.push(pathLine)
        }
        // No need to use PathMove, if left line shouldn't be drawn we just leave the shape open.

        // Top left corner
        if (root.drawTop && root.drawLeft) {
            let pathArc = Qt.createQmlObject('import QtQuick 2.15; PathArc {}', path)
            pathArc.x = Qt.binding(function() { return path.__topLeftRadius + root.borderOffset + path.__borderRadiusAdjustment })
            pathArc.y = Qt.binding(function() { return root.borderOffset })
            pathArc.radiusX = Qt.binding(function() { return root.topLeftBevel ? 50000 : path.__topLeftRadius + path.__borderRadiusAdjustment })
            pathArc.radiusY = Qt.binding(function() { return root.topLeftBevel ? 50000 : path.__topLeftRadius + path.__borderRadiusAdjustment })
            path.pathElements.push(pathArc)
        }
    }

    function clearPathElements() {
        for (var i = 0; i !== path.pathElements.length; ++i)
            path.pathElements[i].destroy()

        path.pathElements = []
    }

    Component.onCompleted: root.constructBorderItem()
}
