// Copyright (C) 2017 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick

//! [0]
BrewingForm {
    id: root
    function start() {
        animation.start()
    }

    signal finished()

    SequentialAnimation {
        id: animation
        PauseAnimation {
            duration: 1500
        }
        PropertyAction {
            target: root
            property: "state"
            value: "coffee"
        }
        PauseAnimation {
            duration: 1500
        }
        PropertyAction {
            target: root
            property: "state"
            value: "milk"
        }
        PauseAnimation {
            duration: 1500
        }
        ScriptAction {
            script: root.finished()
        }
    }

    Behavior on cup.coffeeAmount {
        PropertyAnimation {

        }
    }

    Behavior on cup.milkAmount {
        PropertyAnimation {
        }
    }
}
//! [0]
