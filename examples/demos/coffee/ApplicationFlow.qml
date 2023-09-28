// Copyright (C) 2017 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import Coffee

ApplicationFlowForm {
    id: applicationFlow
    state: "initial"

    property int animationDuration: 400

//! [0]
    choosingCoffee.brewButtonSelection.onClicked: {
        applicationFlow.state = "settings"
        applicationFlow.choosingCoffee.milkSlider.value = applicationFlow.choosingCoffee.sideBar.currentMilk
        applicationFlow.choosingCoffee.sugarSlider.value = 2
    }
//! [0]


    choosingCoffee.sideBar.onCoffeeSelected: {
        applicationFlow.state = "selection"
    }

    choosingCoffee.backButton.onClicked: {
        applicationFlow.state = "selection"
    }

//! [2]
    choosingCoffee.brewButton.onClicked: {
        applicationFlow.state = "empty cup"
    }
//! [2]

//! [1]
    emptyCup.continueButton.onClicked: {
        applicationFlow.state = "brewing"
        brewing.coffeeName = choosingCoffee.sideBar.currentCoffee
        brewing.start()
    }
//! [1]

    brewing.onFinished: {
        finalAnimation.start()
    }

    SequentialAnimation {
        id: finalAnimation

        PropertyAction {
            target: applicationFlow
            property: "state"
            value: "finished"
        }

        PauseAnimation {
            duration: 1000
        }

        PropertyAction {
            target: applicationFlow
            property: "state"
            value: "start"
        }

        PauseAnimation {
            duration: applicationFlow.animationDuration
        }

        PauseAnimation {
            duration: 400
        }
    }


    Behavior on choosingCoffee.x {
        PropertyAnimation {
            duration: applicationFlow.animationDuration
            easing.type: Easing.InOutQuad
        }
    }


    Behavior on emptyCup.x {
        PropertyAnimation {
            duration: applicationFlow.animationDuration
            easing.type: Easing.InOutQuad
        }
    }

    Behavior on brewing.x {
        PropertyAnimation {
            duration: applicationFlow.animationDuration
            easing.type: Easing.InOutQuad
        }
    }

}
