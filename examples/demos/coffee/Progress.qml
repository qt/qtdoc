// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause
import QtQuick

ProgressForm {
    property alias timer: timer
    property int brewTime
    property int brewingAnimationVelocityFactor: 1200

    //! [Timer]
    Timer {
        id: timer
        interval: brewTime
        running: true
        onTriggered: {
            applicationFlow.onFinished()
        }
    }
    //! [Timer]
    //! [Behavior]
    Behavior on greenBar.width {
        SmoothedAnimation {
            easing.type: Easing.Linear
            velocity: (contentItem.width / brewTime) * 1000
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
            target: cup
            property: "coffeeAmount"
            velocity: (coffeeAmount / brewTime) * brewingAnimationVelocityFactor
        }
        SmoothedAnimation {
            target: cup
            property: "milkAmount"
            velocity: (milkAmount / brewTime) * brewingAnimationVelocityFactor
        }
        SmoothedAnimation {
            target: cup
            property: "foamAmount"
            velocity: (foamAmount / brewTime) * brewingAnimationVelocityFactor
        }
        SmoothedAnimation {
            target: cup
            property: "sugarAmount"
            velocity: (sugarAmount / brewTime) * brewingAnimationVelocityFactor
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
