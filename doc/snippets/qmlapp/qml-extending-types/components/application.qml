// Copyright (C) 2016 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause
//![0]
// application.qml
import QtQuick

Column {
    width: 180
    height: 180
    padding: 1.5
    topPadding: 10.0
    bottomPadding: 10.0
    spacing: 5

    MessageLabel{
        width: parent.width - 2
        msgType: "debug"
    }
    MessageLabel {
        width: parent.width - 2
        message: "This is a warning!"
        msgType: "warning"
    }
    MessageLabel {
        width: parent.width - 2
        message: "A critical warning!"
        msgType: "critical"
    }
}
//![0]
