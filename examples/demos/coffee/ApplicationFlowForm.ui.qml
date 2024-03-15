// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Rectangle {
    // Height, width and any other size related properties containing odd looking float or other dividers
    // that do not seem to have any logical origin are just arbitrary and based on original design
    // and/or personal preference on what looks nice.
    id: root
    color: Colors.currentTheme.background
    property string previousState: ""
    property string coffeeName: ""
    property alias home: home
    property alias choosingCoffee: choosingCoffee
    property alias settings: settings
    property alias insert: insert
    property alias ready: ready
    property alias toolbar: toolbar
    property alias progress: progress
    property alias stack: stack
    property alias coffeeText: coffeeText
    property int progressBarValue: 0
    property string progressCupState: "0"
    property int cappuccinos: 4
    property int lattes: 5
    property int espressos: 6
    property int macchiatos: 4

    CustomToolBar {
        id: toolbar
        anchors.topMargin: parent.height / 80
        width: parent.width
        height: 35
        anchors.top: parent.top
    }
    Text {
        id: coffeeText
        text: "Coffee Selection"
        font.pixelSize: 24
        font.family: "Titillium Web"
        font.weight: 700
        color: Colors.currentTheme.textColor
        anchors.top: toolbar.bottom
        anchors.topMargin: parent.height / 20
        leftPadding: 20
    }
    //! [Stack view]
    StackView {
        id: stack
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: parent.height / 20
        initialItem: Home {
            id: home
            visible: true
            state: applicationFlow.mode
        }
        pushEnter: Transition {
            PropertyAnimation {
                property: "x"
                from: stack.width
                to: 0
                duration: 400
            }
        }
        //! [Stack view]
        pushExit: Transition {
            PropertyAnimation {
                property: "x"
                from: 0
                to: -stack.width
                duration: 400
            }
        }
        popEnter: Transition {
            PropertyAnimation {
                property: "x"
                from: -stack.width
                to: 0
                duration: 400
            }
        }
        popExit: Transition {
            PropertyAnimation {
                property: "x"
                from: 0
                to: stack.width
                duration: 400
            }
        }
    }
    Component {
        id: choosingCoffee
        ChoosingCoffee {
            visible: true
            state: applicationFlow.mode
        }
    }
    Component {
        id: settings
        Settings {
            foamAmount: applicationFlow.foamAmount
            milkAmount: applicationFlow.milkAmount
            coffeeAmount: applicationFlow.coffeeAmount
            state: applicationFlow.mode
        }
    }
    Component {
        id: insert
        Insert {
            state: applicationFlow.mode
        }
    }
    Component {
        id: progress
        Progress {
            brewTime: applicationFlow.brewTime
            coffeeAmount: applicationFlow.coffeeAmount
            milkAmount: applicationFlow.milkAmount
            foamAmount: applicationFlow.foamAmount
            sugarAmount: applicationFlow.sugarAmount
            state: applicationFlow.mode
            progressBarValue: root.progressBarValue
            cup.state: root.progressCupState
        }
    }
    Component {
        id: ready
        Ready {
            foamAmount: applicationFlow.foamAmount
            milkAmount: applicationFlow.milkAmount
            coffeeAmount: applicationFlow.coffeeAmount
            sugarAmount: applicationFlow.sugarAmount
            state: applicationFlow.mode
        }
    }
}

