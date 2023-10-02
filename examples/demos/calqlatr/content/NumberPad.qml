// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

pragma ComponentBehavior: Bound

import QtQuick
import "calculator.js" as CalcEngine

Grid {
    id: root
    columns: 3
    columnSpacing: 2
    rowSpacing: 2

    required property Display display

    function updateDimmed() {
        for (let i = 0; i < children.length; i++) {
            children[i].dimmed = CalcEngine.isOperationDisabled(children[i].text)
        }
    }

    component DigitButton: CalculatorButton {
        onPressed: function() {
            CalcEngine.digitPressed(text, root.display)
            root.updateDimmed()
        }
    }

    component OperatorButton: CalculatorButton {
        onPressed: function() {
            CalcEngine.operatorPressed(text, root.display)
            root.updateDimmed()
        }
        textColor: "#6da43d"
        dimmable: true
    }

    Component.onCompleted: updateDimmed()

    DigitButton {
        text: "7"
    }
    DigitButton {
        text: "8"
    }
    DigitButton {
        text: "9"
    }
    DigitButton {
        text: "4"
    }
    DigitButton {
        text: "5"
    }
    DigitButton {
        text: "6"
    }
    DigitButton {
        text: "1"
    }
    DigitButton {
        text: "2"
    }
    DigitButton {
        text: "3"
    }
    DigitButton {
        text: "0"
    }
    DigitButton {
        text: "."
        dimmable: true
    }
    DigitButton {
        text: " "
    }
    OperatorButton {
        text: "±"
    }
    OperatorButton {
        text: "−"
    }
    OperatorButton {
        text: "+"
    }
    OperatorButton {
        text: "√"
    }
    OperatorButton {
        text: "÷"
    }
    OperatorButton {
        text: "×"
    }
    OperatorButton {
        text: "C"
    }
    OperatorButton {
        text: " "
    }
    OperatorButton {
        text: "="
    }
}
