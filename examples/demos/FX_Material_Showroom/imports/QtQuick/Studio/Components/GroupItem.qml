// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick 2.0

/*!
    \qmltype GroupItem
    \inqmlmodule QtQuick.Studio.Components
    \since QtQuick.Studio.Components 1.0
    \inherits Item

    \brief A group item that gets its size from its children.

    The Group type is an \l Item type extended with the size property. The value
    of size is automatically calculated to fit the children of the group.

    \section2 Example Usage

    You can use the Group type to specify the size of one or several items.

    \image studio-group.png

    The QML code looks as follows:

    \code
    GroupItem {
        id: group

        Rectangle {
        id: rectangle
        width: 200
        height: 200
        color: "#c2c2c2"
        }

        Rectangle {
        id: rectangle1
        x: 140
        y: 140
        width: 200
        height: 200
        color: "#000000"
        }
    }
    \endcode
*/

Item {
    implicitWidth: Math.max(16, childrenRect.width + childrenRect.x)
    implicitHeight: Math.max(16, childrenRect.height + childrenRect.y)
}
