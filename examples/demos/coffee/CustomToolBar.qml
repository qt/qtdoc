// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause
import QtQuick

CustomToolBarForm {
    backButton.onClicked: applicationFlow.backButton()
    themeButton.onClicked: applicationFlow.themeButton()
    backButton.states: State {
        name: "pressed"
        when: backButton.pressed
        PropertyChanges {
            target: backButton
            scale: 1.1
        }
    }
    themeButton.states: State {
        name: "pressed"
        when: themeButton.pressed
        PropertyChanges {
            target: themeButton
            scale: 1.1
        }
    }

}
