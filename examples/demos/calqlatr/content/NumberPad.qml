// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick

Grid {
    columns: 3
    columnSpacing: 32
    rowSpacing: 16

    function updateDimmed(){
        for (let i = 0; i < children.length; i++){
            children[i].dimmed = window.isButtonDisabled(children[i].text)
        }
    }

    component DigitButton: CalculatorButton {
        onPressed: function() {
            window.digitPressed(text)
            updateDimmed()
        }
    }

    component OperatorButton: CalculatorButton {
        onPressed: function() {
            window.operatorPressed(text)
            updateDimmed()
        }
        textColor: "#6da43d"
        dimmable: true
    }

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

    Component.onCompleted: updateDimmed()
}
