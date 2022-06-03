// Copyright (C) 2017 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick

SideBarForm {
    id: sideBar
    property string currentCoffee: qsTr("Cappucino")
    signal coffeeSelected
    property real currentMilk: 0
    property real currentCoffeeAmount: 4

    Behavior on currentMilk {
         NumberAnimation { duration: 250 }
    }

    Behavior on currentCoffeeAmount {
         NumberAnimation { duration: 250 }
    }

    macchiatoButton.onClicked: {
        sideBar.currentCoffee = qsTr("Macchiato")
        sideBar.currentMilk = 1
        sideBar.currentCoffeeAmount = 4
        sideBar.coffeeSelected()
    }

    latteButton.onClicked: {
        sideBar.currentCoffee = qsTr("Latte")
        sideBar.currentMilk = 10
        sideBar.currentCoffeeAmount = 3
        sideBar.coffeeSelected()
    }

    espressoButton.onClicked: {
        sideBar.currentCoffee = qsTr("Espresso")
        sideBar.currentMilk = 0
        sideBar.currentCoffeeAmount = 4
        sideBar.coffeeSelected()
    }

//! [0]
    cappuccinoButton.onClicked: {
        sideBar.currentCoffee = qsTr("Cappucino")
        sideBar.currentMilk = 7
        sideBar.currentCoffeeAmount = 3.5
        sideBar.coffeeSelected()
    }
//! [0]
}
