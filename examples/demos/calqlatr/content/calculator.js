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
    } else if (op === "⅟𝑥") {
        digits = (1 / digits.valueOf()).toString()
        display.newLine("⅟𝑥", Number(digits))
    } else if (op === "𝑥²") {
        digits = (digits.valueOf() * digits.valueOf()).toString()
        display.newLine("𝑥²", Number(digits))
    } else if (op === "𝑥³") {
        digits = (digits.valueOf() * digits.valueOf() * digits.valueOf()).toString()
        display.newLine("𝑥³", Number(digits))
    } else if (op === "|𝑥|") {
        digits = (Math.abs(digits.valueOf())).toString()
        display.newLine("|𝑥|", Number(digits))
    } else if (op === "⌊𝑥⌋") {
        digits = (Math.floor(digits.valueOf())).toString()
        display.newLine("⌊𝑥⌋", Number(digits))
    } else if (op === "𝑠𝑖𝑛") {
        digits = Number(Math.sin(digits.valueOf())).toString()
        display.newLine("𝑠𝑖𝑛", Number(digits))
    } else if (op === "𝑐𝑜𝑠") {
        digits = Number(Math.cos(digits.valueOf())).toString()
        display.newLine("𝑐𝑜𝑠", Number(digits))
    } else if (op === "𝑡𝑎𝑛") {
        digits = Number(Math.tan(digits.valueOf())).toString()
        display.newLine("𝑡𝑎𝑛", Number(digits))
    } else if (op === "𝑙𝑜𝑔") {
        digits = Number(Math.log10(digits.valueOf())).toString()
        display.newLine("𝑙𝑜𝑔", Number(digits))
    } else if (op === "𝑙𝑛") {
        digits = Number(Math.log(digits.valueOf())).toString()
        display.newLine("𝑙𝑛", Number(digits))
    }

    if (op === "AC") {
        display.allClear()
        curVal = 0
        lastOp = ""
        digits = ""
        previousOperator = ""
    }
}
