// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause
import QtQuick

SettingsForm {
    rectangle.states: [
        State {
            name: "smallerFont"
            when: ((Screen.height * Screen.devicePixelRatio)
                   + (Screen.width * Screen.devicePixelRatio)) < 2000
            PropertyChanges {
                target: rectangle
                textPixelSize: 14
            }
        }
    ]
    sugarSlider.states: State {
        name: "pressed"
        when: sugarSlider.pressed
        PropertyChanges {
            target: handle
            scale: 1.1
        }
    }
    handle.states: [
        State {
            name: "small"
            when: ((Screen.height * Screen.devicePixelRatio)
                   + (Screen.width
                      * Screen.devicePixelRatio)) < 2000
            PropertyChanges {
                target: handle
                width: 10
            }
        }
    ]
    box.states: [
        State {
            name: "small"
            when: ((Screen.height * Screen.devicePixelRatio)
                   + (Screen.width
                      * Screen.devicePixelRatio)) < 2000
            PropertyChanges {
                target: box
                implicitWidth: sugarText.width + 4
                implicitHeight: sugarText.height + 2
            }
        }
    ]
    sugarText.states: [
        State {
            name: "small"
            when: ((Screen.height * Screen.devicePixelRatio) + (Screen.width * Screen.devicePixelRatio)) < 2000
            PropertyChanges {
                target: sugarText
                font.pixelSize: 8
            }
        }
    ]
    sugarSlider.onMoved: {
        sugarText.sugarAmount = sugarSlider.position * 4
    }
    confirmButton.onClicked: applicationFlow.confirmButton()
    //! [Value changed]
    coffeeSlider.onValueChanged: {
        applicationFlow.coffeeAmount = coffeeSlider.value
    }
    //! [Value changed]
    milkSlider.onValueChanged: {
        applicationFlow.milkAmount = milkSlider.value
    }
    foamSlider.onValueChanged: {
        applicationFlow.foamAmount = foamSlider.value
    }
    sugarSlider.onValueChanged: {
        applicationFlow.sugarAmount = sugarSlider.value
    }
}
