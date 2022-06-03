// Copyright (C) 2016 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick

//![0]
MouseArea {
    anchors.fill: parent
    onClicked: {
        var scenePos = mapToItem(null, mouseX, mouseY);
        console.log("MouseArea was clicked at scene pos " + scenePos);
    }
}
//![0]
