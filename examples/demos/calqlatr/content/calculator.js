// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

.pragma library

let curVal = 0
let memory = 0
let lastOp = ""
let previousOperator = ""
let digits = ""

function isOperationDisabled(op) {
    if (digits === "" && !((op >= "0" && op <= "9") || op === "."))
        return true
    else if (op === '=' && previousOperator.length !== 1)
        return true
    else if (op === "." && digits.toString().search(/\./) !== -1) {
        return true
    } else if (op === "√" &&  digits.toString().search(/-/) !== -1) {
        return true
    } else {
        return false
    }
}

function digitPressed(op, display) {
    if (isOperationDisabled(op))
        return
    if (digits.toString().length >= display.maxDigits)
        return
    if (lastOp.toString().length === 1 && ((lastOp >= "0" && lastOp <= "9") || lastOp === ".") ) {
        digits = digits + op.toString()
        display.appendDigit(op.toString())
    } else {
        digits = op
        display.appendDigit(op.toString())
    }
    lastOp = op
}

function operatorPressed(op, display) {
    if (isOperationDisabled(op))
        return
    lastOp = op

    if (op === "±") {
            digits = Number(digits.valueOf() * -1)
            display.setDigit(display.displayNumber(digits))
            return
        }

    if (previousOperator === "+") {
        digits = Number(digits.valueOf()) + Number(curVal.valueOf())
    } else if (previousOperator === "−") {
        digits = Number(curVal.valueOf()) - Number(digits.valueOf())
    } else if (previousOperator === "×") {
        digits = Number(curVal) * Number(digits.valueOf())
    } else if (previousOperator === "÷") {
        digits = Number(curVal) / Number(digits.valueOf())
    }

    if (op === "+" || op === "−" || op === "×" || op === "÷") {
        previousOperator = op
        curVal = digits.valueOf()
        digits = ""
        display.displayOperator(previousOperator)
        return
    }

    if (op === "=") {
        display.newLine("=", digits.valueOf())
    }

    curVal = 0
    previousOperator = ""

    if (op === "1/x") {
        digits = (1 / digits.valueOf()).toString()
    } else if (op === "x^2") {
        digits = (digits.valueOf() * digits.valueOf()).toString()
    } else if (op === "Abs") {
        digits = (Math.abs(digits.valueOf())).toString()
    } else if (op === "Int") {
        digits = (Math.floor(digits.valueOf())).toString()
    } else if (op === "√") {
        digits = Number(Math.sqrt(digits.valueOf()))
        display.newLine("√", digits.valueOf())
    } else if (op === "mc") {
        memory = 0;
    } else if (op === "m+") {
        memory += digits.valueOf()
    } else if (op === "mr") {
        digits = memory.toString()
    } else if (op === "m-") {
        memory = digits.valueOf()
    } else if (op === "backspace") {
        digits = digits.toString().slice(0, -1)
        display.clear()
        display.appendDigit(digits)
    } else if (op === "Off") {
        Qt.quit();
    }

    // Reset the state on 'C' operator or after
    // an error occurred
    if (op === "C" || display.isError) {
        display.clear()
        curVal = 0
        memory = 0
        lastOp = ""
        digits = ""
    }
}

