// Copyright (C) 2016 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick

Image {
    id: container
    property bool on: false

    source: "images/busy.png"; visible: container.on
    NumberAnimation on rotation { running: container.on; from: 0; to: 360; loops: Animation.Infinite; duration: 1200 }
}
