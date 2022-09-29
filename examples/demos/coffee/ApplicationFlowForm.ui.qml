// Copyright (C) 2017 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause
import QtQuick 2.4
import Coffee 1.0

Rectangle {
    id: root
    width: Constants.width
    height: Constants.height
    property alias choosingCoffee: choosingCoffee
    property alias brewing: brewing
    property alias emptyCup: emptyCup

    color: Constants.backgroundColor

    state: intital

    EmptyCupForm {
        id: emptyCup
        x: Constants.width
        y: 0
    }

    Brewing {
        id: brewing
        x: Constants.width * 2
        y: 0
    }

    ChoosingCoffee {
        id: choosingCoffee
    }

    states: [
        State {
            name: "initial"
        },
        State {
            name: "selection"

            PropertyChanges {
                target: choosingCoffee
                selected: true
                x: Constants.defaultX
            }
        },
        State {
            name: "settings"

            PropertyChanges {
                target: choosingCoffee
                x: -Constants.leftSideBarWidth
                selected: false
                inSettings: true
            }

            PropertyChanges {
                target: emptyCup
                x: Constants.width
                y: 0
            }

            PropertyChanges {
                target: brewing
                x: Constants.width * 2
                y: 0
            }
        },
        State {
            name: "empty cup"

            PropertyChanges {
                target: emptyCup
                x: 0
            }

            PropertyChanges {
                target: choosingCoffee
                x: -Constants.width - Constants.leftSideBarWidth
                inSettings: true
                selected: false
            }

            PropertyChanges {
                target: brewing
                x: Constants.width
            }
        },
        State {
            name: "brewing"

            PropertyChanges {
                target: emptyCup
                x: -Constants.width
            }

            PropertyChanges {
                target: brewing
                x: 0
            }

            PropertyChanges {
                target: choosingCoffee
                x: -Constants.width * 2 - Constants.leftSideBarWidth
            }
        },
        State {
            name: "finished"

            PropertyChanges {
                target: emptyCup
                x: -Constants.width
                y: 0
                visible: false
            }

            PropertyChanges {
                target: brewing
                x: 0
            }

            PropertyChanges {
                target: choosingCoffee
                x: -Constants.leftSideBarWidth - Constants.width
                questionVisible: true
                inSettings: true
            }
        },
        State {
            name: "start"

            PropertyChanges {
                target: emptyCup
                x: 0
                visible: false
            }

            PropertyChanges {
                target: brewing
                x: Constants.width
                y: 0
            }

            PropertyChanges {
                target: choosingCoffee
                x: 0
                inSettings: true
            }
        }
    ]
}
