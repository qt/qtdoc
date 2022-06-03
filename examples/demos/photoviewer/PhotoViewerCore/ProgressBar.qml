// Copyright (C) 2016 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick

Item {
    id: container

    property real progress: 0

    Behavior on opacity { NumberAnimation { duration: 600 } }

    Rectangle { anchors.fill: parent; color: "black"; opacity: 0.5 }

    Rectangle {
        id: fill; color: "white"; height: container.height
        width: container.width * container.progress
    }
}
