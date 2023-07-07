// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick 2.9
import QtQuick.Shapes 1.12

/*!
    \qmltype PieItem
    \inqmlmodule QtQuick.Studio.Components
    \since QtQuick.Studio.Components 1.0
    \inherits Shape

    \brief A pie.

    The Pie type is used to create a pie slice, a pie that is missing slices,
    or just the pie rind (similar to an \l ArcItem), depending on the \l begin
    and \l end property values and the \l hideLine value.

    The filling of the pie is painted using either a solid fill color, specified
    using the \l fillColor property, or a gradient, defined using one of the
    \l ShapeGradient subtypes and set using the \l gradient property.
    If both a color and a gradient are specified, the gradient is used.

    The \l strokeColor, \l strokeWidth, and \l strokeStyle properties specify
    the appearance of the pie outline. The \l dashPattern and \l dashOffset
    properties specify the appearance of dashed lines.

    The \l capStyle property specifies whether line ends are square or
    rounded.

    Because a pie has curved edges, it may be appropriate to set the
    \c antialiasing property that is inherited from \l Item to improve
    its appearance.

    \section2 Example Usage

    You can use the Pie component in \QDS to create different kinds of pies.

    \image studio-pie.png

    The QML code looks as follows:

    \code
        PieItem {
        id: pieSlice
        antialiasing: true
        strokeColor: "gray"
        fillColor: "light gray"
    }

    PieItem {
        id: pie
        end: 300
        fillColor: "#d3d3d3"
        strokeColor: "#808080"
        antialiasing: true
    }

    PieItem {
        id: pieRind
        strokeWidth: 4
        capStyle: 32
        hideLine: true
        end: 300
        strokeColor: "#808080"
        antialiasing: true
    }
    \endcode
*/

Shape {
    id: root

    implicitWidth: 100
    implicitHeight: 100

/*!
    The gradient of the pie fill color.

    By default, no gradient is enabled and the value is null. In this case, the
    fill uses a solid color based on the value of \l fillColor.

    When set, \l fillColor is ignored and filling is done using one of the
    \l ShapeGradient subtypes.

    \note The \l Gradient type cannot be used here. Rather, prefer using one of
    the advanced subtypes, like \l LinearGradient.
*/
    property alias gradient: path.fillGradient

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
    The width of the line.

    When set to a negative value, no line is drawn.

    The default value is 4.
*/
    property alias strokeWidth: path.strokeWidth

/*!
    The color of the line.

    When set to \c transparent, no line is drawn.

    The default value is \c red.

    \sa QColor
*/
    property alias strokeColor: path.strokeColor

/*!
    The dash pattern of the line specified as the dashes and the gaps between
    them.

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
    property alias joinStyle: path.joinStyle

/*!
    The pie fill color.

    If \l hideLine is \c false, a pie slice is drawn using the values of the
    \l begin and \l end properties and filled with this color.

    If \l hideLine is \c true, just the pie rind is drawn and the area between
    the \l begin and \l end points is filled.

    A gradient for the fill can be specified by using \l gradient. If both a
    color and a gradient are specified, the gradient is used.

    When set to \c transparent, no filling occurs.

    The default value is \c white.
*/
    property alias fillColor: path.fillColor

/*!
    The starting point of the dash pattern for the line.

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

/*!
    The position in degrees where the pie begins.

    The default value is 0.

    To create a circle, set the value of this property to 0 and the value of the
    \l end property to 360.
*/
    property real begin: 0

/*!
    The position in degrees where the pie ends.

    The default value is 90.

    To create a circle, set the value of this property to 360 and the value of
    the \l begin property to 0.
*/
    property real end: 90

/*!
    The area between \l begin and \l end.
*/
    property real alpha: root.clamp(root.end - root.begin, 0, 359.9)

    layer.enabled: root.antialiasing
    layer.smooth: root.antialiasing
    layer.samples: root.antialiasing ? 4 : 0

    function clamp(num, min, max) {
        return Math.max(min, Math.min(num, max))
    }

/*!
    Whether to draw a pie slice or just the pie rind (similar to an \l ArcItem).
*/
    property bool hideLine: {
        if (root.alpha <= 0)
            return true
        if (root.alpha >= 359)
            return true
        return false
    }

    function toRadians(degrees) {
        return degrees * (Math.PI / 180.0)
    }

    function polarToCartesianX(centerX, centerY, radius, angleInDegrees) {
        return centerX + radius * Math.cos(root.toRadians(angleInDegrees))
    }

    function polarToCartesianY(centerX, centerY, radius, angleInDegrees) {
        return centerY + radius * Math.sin(root.toRadians(angleInDegrees))
    }

    ShapePath {
        id: path

        property real __xRadius: root.width / 2 - root.strokeWidth / 2
        property real __yRadius: root.height / 2 - root.strokeWidth / 2

        property real __xCenter: root.width / 2
        property real __yCenter: root.height / 2

        strokeColor: "red"
        capStyle: ShapePath.FlatCap

        strokeWidth: 4

        startX: root.hideLine ? root.polarToCartesianX(path.__xCenter, path.__yCenter, path.__xRadius, root.begin - 90)
                              : path.__xCenter
        startY: root.hideLine ? root.polarToCartesianY(path.__xCenter, path.__yCenter, path.__yRadius, root.begin - 90)
                              : path.__yCenter

        PathLine {
            x: root.polarToCartesianX(path.__xCenter, path.__yCenter, path.__xRadius, root.begin - 90)
            y: root.polarToCartesianY(path.__xCenter, path.__yCenter, path.__yRadius, root.begin - 90)
        }

        PathArc {
            id: arc

            x: root.polarToCartesianX(path.__xCenter, path.__yCenter, path.__xRadius, root.begin + root.alpha - 90)
            y: root.polarToCartesianY(path.__xCenter, path.__yCenter,  path.__yRadius, root.begin + root.alpha - 90)

            radiusY: path.__yRadius;
            radiusX: path.__xRadius;

            useLargeArc: root.alpha > 180
        }

        PathLine {
            x: root.hideLine ? root.polarToCartesianX(path.__xCenter, path.__yCenter, path.__xRadius, root.begin + root.alpha - 90)
                             : path.__xCenter
            y: root.hideLine ? root.polarToCartesianY(path.__xCenter, path.__yCenter,  path.__yRadius, root.begin + root.alpha - 90)
                             : path.__yCenter
        }
    }
}

