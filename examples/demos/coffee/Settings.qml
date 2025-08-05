// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause
import QtQuick

SettingsForm {
    id: settingsForm

    required property ApplicationFlow appFlow
    required property CoffeeConfig coffeeConfig

    foamAmount: coffeeConfig.foamAmount
    milkAmount: coffeeConfig.milkAmount
    coffeeAmount: coffeeConfig.coffeeAmount
    state: Config.mode

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
        when: settingsForm.sugarSlider.pressed
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
    confirmButton.onClicked: appFlow.confirmButton()
    //! [Value changed]
    coffeeSlider.onValueChanged: {
        coffeeConfig.coffeeAmount = coffeeSlider.value
    }
    //! [Value changed]
    milkSlider.onValueChanged: {
        coffeeConfig.milkAmount = milkSlider.value
    }
    foamSlider.onValueChanged: {
        coffeeConfig.foamAmount = foamSlider.value
    }
    sugarSlider.onValueChanged: {
        coffeeConfig.sugarAmount = sugarSlider.value
    }
}
