// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

.pragma library

let curVal = 0
let previousOperator = ""
let lastOp = ""
let digits = ""

function isOperationDisabled(op, display) {
    if (digits !== "" && lastOp !== "=" && (op === "π" || op === "e"))
        return true
    if (digits === "" && !((op >= "0" && op <= "9") || op === "π" || op === "e" || op === "AC"))
        return true
    if (op === "bs" && (display.isOperandEmpty() || !((lastOp >= "0" && lastOp <= "9")
                                                      || lastOp === "π" || lastOp === "e" || lastOp === ".")))
        return true
    if (op === '=' && previousOperator.length != 1)
        return true
    if (op === "." && digits.search(/\./) != -1)
        return true
    if (op === "√" &&  digits.search(/-/) != -1)
        return true
    if (op === "AC" && display.isDisplayEmpty())
        return true

    return false
}

function digitPressed(op, display) {
    if (isOperationDisabled(op, display))
        return
    if (lastOp === "π" || lastOp === "e")
        return
    // handle mathematical constants
    if (op === "π") {
        lastOp = op
        digits = Math.PI.toPrecision(display.maxDigits - 1).toString()
        display.appendDigit(digits)
        return
    }
    if (op === "e") {
        lastOp = op
        digits = Math.E.toPrecision(display.maxDigits - 1).toString()
        display.appendDigit(digits)
        return
    }

    // append a digit to another digit or decimal point
    if (lastOp.toString().length === 1 && ((lastOp >= "0" && lastOp <= "9") || lastOp === ".") ) {
        if (digits.length >= display.maxDigits)
            return
        digits = digits + op.toString()
        display.appendDigit(op.toString())
    // else just write a single digit to display
    } else {
        digits = op.toString()
        display.appendDigit(digits)
    }
    lastOp = op
}

function operatorPressed(op, display) {
    if (isOperationDisabled(op, display))
        return

    if (op === "±") {
        digits = Number(digits.valueOf() * -1).toString()
        display.setDigit(display.displayNumber(Number(digits)))
        return
    }

    if (op === "bs") {
        digits = digits.slice(0, -1)
        if (digits === "-")
            digits = ""
        display.backspace()
        return
    }

    lastOp = op

    if (previousOperator === "+") {
        digits = (Number(curVal) + Number(digits.valueOf())).toString()
    } else if (previousOperator === "−") {
        digits = (Number(curVal) - Number(digits.valueOf())).toString()
    } else if (previousOperator === "×") {
        digits = (Number(curVal) * Number(digits.valueOf())).toString()
    } else if (previousOperator === "÷") {
        digits = (Number(curVal) / Number(digits.valueOf())).toString()
    }


    if (op === "+" || op === "−" || op === "×" || op === "÷") {
        previousOperator = op
        curVal = digits.valueOf()
        digits = ""
        display.displayOperator(previousOperator)
        return
    }

    curVal = 0
    previousOperator = ""

    if (op === "=") {
        display.newLine("=", Number(digits))
    }

    if (op === "√") {
        digits = (Math.sqrt(digits.valueOf())).toString()
        display.newLine("√", Number(digits))
    } else if (op === "⅟x") {
        digits = (1 / digits.valueOf()).toString()
        display.newLine("⅟x", Number(digits))
    } else if (op === "x²") {
        digits = (digits.valueOf() * digits.valueOf()).toString()
        display.newLine("x²", Number(digits))
    } else if (op === "x³") {
        digits = (digits.valueOf() * digits.valueOf() * digits.valueOf()).toString()
        display.newLine("x³", Number(digits))
    } else if (op === "|x|") {
        digits = (Math.abs(digits.valueOf())).toString()
        display.newLine("|x|", Number(digits))
    } else if (op === "⌊x⌋") {
        digits = (Math.floor(digits.valueOf())).toString()
        display.newLine("⌊x⌋", Number(digits))
    } else if (op === "sin") {
        digits = Number(Math.sin(digits.valueOf())).toString()
        display.newLine("sin", Number(digits))
    } else if (op === "cos") {
        digits = Number(Math.cos(digits.valueOf())).toString()
        display.newLine("cos", Number(digits))
    } else if (op === "tan") {
        digits = Number(Math.tan(digits.valueOf())).toString()
        display.newLine("tan", Number(digits))
    } else if (op === "log") {
        digits = Number(Math.log10(digits.valueOf())).toString()
        display.newLine("log", Number(digits))
    } else if (op === "ln") {
        digits = Number(Math.log(digits.valueOf())).toString()
        display.newLine("ln", Number(digits))
    }

    if (op === "AC") {
        display.allClear()
        curVal = 0
        lastOp = ""
        digits = ""
        previousOperator = ""
    }
}
