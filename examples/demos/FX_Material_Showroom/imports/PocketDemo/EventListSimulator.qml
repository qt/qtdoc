// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Studio.EventSimulator
import QtQuick.Studio.EventSystem

QtObject {
    id: simulator
    property bool active: true

    property Timer __timer: Timer {
        id: timer
        interval: 100
        onTriggered: {
            EventSimulator.show()
        }
    }

    Component.onCompleted: () => {
        EventSystem.init(Qt.resolvedUrl("EventListModel.qml"))
        if (simulator.active)
            timer.start()
    }
}
