// Copyright (C) 2017 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause


pragma Singleton
import QtQuick

QtObject {
    property FontLoader fontLoader: FontLoader {
        id: fontLoader
        source: "TitilliumWeb-Regular.ttf"
    }
    readonly property alias fontFamily: fontLoader.name

    readonly property int width: 1024
    readonly property int height: 768
    readonly property int leftSideBarWidth: 366
    readonly property int defaultX: 0

    readonly property color backgroundColor: "#443224"
    readonly property int defaultMargin: 8
}
