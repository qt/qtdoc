// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick

ListModel {
    id: eventListModel

    ListElement {
        eventId: "enterPressed"
        eventDescription: "Emitted when pressing the enter button"
        shortcut: "Return"
        parameters: "Enter"
    }
}
