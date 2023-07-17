// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick 2.9

/*!
    \qmltype FlipableItem
    \inqmlmodule QtQuick.Studio.Components
    \since QtQuick.Studio.Components 1.0

    \brief Provides a surface that can be flipped.

    A Flipable type can be visibly \e flipped between its front and back sides,
    like a card. The front and back sides are specified by using any two types
    inside the Flipable type. The type with the higher z-order is the front
    side. The \l opacityFront and \l opacityBack properties are used to hide
    and show either the front or back side of the item at a time.

    The \l flipAngle property is used to animate the angle of the type to
    produce the flipping effect. The value of the \l rotationalAxis property
    determines which axis the type is rotated around.

    \section2 Example Usage

    You can use the Flipable component in \QDS to create an item that can be
    flipped. In this example, the two sides of the item show ISO 7000 icons.

    \image studio-flipable.png

    The QML code looks as follows:

    \code
    FlipableItem {
        id: flipable
        width: 90
        height: 89
        opacityBack: 0

        IsoItem {
            id: arrowIsoIcon
            color: "#808080"
            anchors.fill: parent
            source: "./iso-icons/iso_grs_7000_4_0251.dat"
        }

        IsoItem {
            id: questionIsoIcon
            color: "#808080"
            anchors.fill: parent
            source: "./iso-icons/iso_grs_7000_4_0435.dat"
        }
    }
    \endcode
*/

Flipable {
    id: flipable
    width: 240
    height: 240

/*!
    The flip angle in degrees.

    The minimum value is -360 and the maximum value is 360 degrees.
*/
    property alias flipAngle: rotation.angle

/*!
    The opacity of the front side of the type.

    The opacity can be set between 0 and 1 to hide or show the items on the
    front side of the type.
*/
    property real opacityFront: 1

/*!
    The opacity of the back side of the type.

    The opacity can be set between 0 and 1 to hide or show the items on the
    back side of the type.
*/
    property real opacityBack: 1

/*!
    Whether the type is rotated around the x-axis or y-axis.

    This property is set to 0 to rotate the type around the x-axis or to
    1 to rotate around the y-axis.
*/
    property int rotationalAxis: 1 // 0: x-axis, 1: y-axis

    Binding {
        target: flipable.front
        value: opacityFront
        property: "opacity"
        when: flipable.front !== undefined
    }

    Binding {
        target: flipable.back
        value: opacityBack
        property: "opacity"
        when: flipable.back !== undefined
    }

/*!
    Whether the type has been flipped.

    This property is set to \c true when the type is flipped.
*/
    property bool flipped: false

    Component.onCompleted: {
        flipable.front = flipable.children[0]
        flipable.back = flipable.children[1]
    }

    transform: Rotation {
        id: rotation
        origin.x: flipable.width/2
        origin.y: flipable.height/2
        axis.x: flipable.rotationalAxis === 0 ? 1 : 0
        axis.y: flipable.rotationalAxis === 1 ? 1 : 0
        axis.z: 0
        angle: 0    // the default angle
    }
}
