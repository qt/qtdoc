// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause
import QtQuick

ProgressForm {
    id: progressForm

    required property ApplicationFlow appFlow
    property alias timer: timer
    property int brewTime: appFlow.brewTime
    property int brewingAnimationVelocityFactor: 1200

    coffeeAmount: appFlow.coffeeAmount
    milkAmount: appFlow.milkAmount
    foamAmount: appFlow.foamAmount
    sugarAmount: appFlow.sugarAmount
    state: Config.mode
    progressBarValue: appFlow.progressBarValue
    cup.state: appFlow.progressCupState

    //! [Timer]
    Timer {
        id: timer
        interval: progressForm.brewTime
        running: true
        onTriggered: {
            progressForm.appFlow.onFinished()
        }
    }
    //! [Timer]
    //! [Behavior]
    Behavior on greenBar.width {
        SmoothedAnimation {
            easing.type: Easing.Linear
            velocity: (progressForm.contentItem.width / progressForm.brewTime) * 1000
        }
    }
    //! [Behavior]
    cup.states: [
        State {
            name: "0"
            PropertyChanges {
                target: cup
                coffeeAmount: 0
            }
            PropertyChanges {
                target: cup
                milkAmount: 0
            }
            PropertyChanges {
                target: cup
                foamAmount: 0
            }
            PropertyChanges {
                target: cup
                sugarAmount: 0
            }
        },
        State {
            name: "1"
            PropertyChanges {
                target: cup
                coffeeAmount: root.coffeeAmount
            }
            PropertyChanges {
                target: cup
                milkAmount: root.milkAmount
            }
            PropertyChanges {
                target: cup
                foamAmount: root.foamAmount
            }
            PropertyChanges {
                target: cup
                sugarAmount: root.sugarAmount
            }
        }
    ]
    cup.transitions: Transition {
        from: "0"
        to: "1"
        SmoothedAnimation {
            target: progressForm.cup
            property: "coffeeAmount"
            velocity: (progressForm.coffeeAmount / progressForm.brewTime) * progressForm.brewingAnimationVelocityFactor
        }
        SmoothedAnimation {
            target: progressForm.cup
            property: "milkAmount"
            velocity: (progressForm.milkAmount / progressForm.brewTime) * progressForm.brewingAnimationVelocityFactor
        }
        SmoothedAnimation {
            target: progressForm.cup
            property: "foamAmount"
            velocity: (progressForm.foamAmount / progressForm.brewTime) * progressForm.brewingAnimationVelocityFactor
        }
        SmoothedAnimation {
            target: progressForm.cup
            property: "sugarAmount"
            velocity: (progressForm.sugarAmount / progressForm.brewTime) * progressForm.brewingAnimationVelocityFactor
        }
    }
    caption.states: [
        State {
            name: "small"
            when: ((Screen.height * Screen.devicePixelRatio)
                   + (Screen.width * Screen.devicePixelRatio)) < 2000
            PropertyChanges {
                target: caption
                font.pixelSize: 16
            }
        }
    ]
}
