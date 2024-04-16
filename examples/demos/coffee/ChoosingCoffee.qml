// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause
import QtQuick

ChoosingCoffeeForm {
    cappuccino.button.onClicked: applicationFlow.cappuccino()
    macchiato.button.onClicked: applicationFlow.macchiato()
    espresso.button.onClicked: applicationFlow.espresso()
    latte.button.onClicked: applicationFlow.latte()
}
