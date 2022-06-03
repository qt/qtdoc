// Copyright (C) 2017 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause
import QtQuick 2.4
import QtQuick.Layouts 1.3

Flickable {
    id: flickable
    x: 0
    y: 0
    width: 354
    height: 768

    property alias macchiatoButton: macchiatoButton
    property alias latteButton: latteButton
    property alias espressoButton: espressoButton
    property alias cappuccinoButton: cappuccinoButton

    contentWidth: 250
    boundsBehavior: Flickable.StopAtBounds
    contentHeight: 1506
    clip: true

    Rectangle {
        id: background
        x: 0
        width: 354
        height: 1506
        color: "#eec1a2"
    }

    ColumnLayout {
        x: 52
        y: 0
        spacing: 64

        CoffeeButton {
            id: cappuccinoButton
            text: "Cappuccino"
        }

        CoffeeButton {
            id: espressoButton
            text: "Espresso"
            source: "images/icons/coffees/Espresso.png"
        }

        CoffeeButton {
            id: latteButton
            text: "Latte"
            source: "images/icons/coffees/Latte.png"
        }

        CoffeeButton {
            id: macchiatoButton
            text: "Macchiato"
            source: "images/icons/coffees/Macchiato.png"
        }
    }
}
