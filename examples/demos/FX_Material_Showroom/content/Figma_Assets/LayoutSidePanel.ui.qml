// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick

Rectangle {
    id: layoutSidePanel
    width: 1920
    height: 1080
    color: "#00ffffff"
    border.color: "#00ffffff"

    Material_pop_up {
        id: material_pop_up
        x: 0
        y: 0
        width: 636
        height: 1080
        clip: true
        state: "state_type_Materials"
    }

    LabelQt {
        id: labelQt
        x: 1644
        y: 972
        width: 248
        height: 80
    }
}

/*##^##
Designer {
    D{i:0;uuid:"751cad8e-e09f-5bc0-8892-9425429e1d58"}D{i:1;uuid:"5ef21d17-7d2a-52e7-bc56-01caf4363781"}
D{i:2;uuid:"0b85865c-5a98-58ce-b526-856fd3a1631d"}
}
##^##*/

