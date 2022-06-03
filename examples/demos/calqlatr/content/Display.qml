// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Window

Item {
    id: display
    property real fontSize: Math.floor(Screen.pixelDensity * 5.0)
    property bool enteringDigits: false
    readonly property int maxDigits: (width / fontSize) + 1
    property string displayedOperand
    property string errorString: qsTr("ERROR")
    readonly property bool isError: displayedOperand === errorString

    function displayOperator(operator)
    {
        listView.model.append({ "operator": operator, "operand": "" })
        enteringDigits = true
        listView.positionViewAtEnd()
    }

    function newLine(operator, operand)
    {
        displayedOperand = displayNumber(operand)
        listView.model.append({ "operator": operator, "operand": displayedOperand })
        enteringDigits = false
        listView.positionViewAtEnd()
    }

    function appendDigit(digit)
    {
        if (!enteringDigits)
            listView.model.append({ "operator": "", "operand": "" })
        const i = listView.model.count - 1;
        listView.model.get(i).operand = listView.model.get(i).operand + digit;
        enteringDigits = true
        listView.positionViewAtEnd()
    }

    function setDigit(digit)
    {
        const i = listView.model.count - 1;
        listView.model.get(i).operand = digit;
        listView.positionViewAtEnd()
    }

    function clear()
    {
        displayedOperand = ""
        if (enteringDigits) {
            const i = listView.model.count - 1
            if (i >= 0)
                listView.model.remove(i)
            enteringDigits = false
        }
    }

    // Returns a string representation of a number that fits in
    // display.maxDigits characters, trying to keep as much precision
    // as possible. If the number cannot be displayed, returns an
    // error string.
    function displayNumber(num) {
        if (typeof(num) != "number")
            return errorString;

        const intNum = parseInt(num);
        const intLen = intNum.toString().length;

        // Do not count the minus sign as a digit
        const maxLen = num < 0 ? maxDigits + 1 : maxDigits;

        if (num.toString().length <= maxLen) {
            if (isFinite(num))
                return num.toString();
            return errorString;
        }

        // Integer part of the number is too long - try
        // an exponential notation
        if (intNum == num || intLen > maxLen - 3) {
            const expVal = num.toExponential(maxDigits - 6).toString();
            if (expVal.length <= maxLen)
                return expVal;
        }

        // Try a float presentation with fixed number of digits
        const floatStr = parseFloat(num).toFixed(maxDigits - intLen - 1).toString();
        if (floatStr.length <= maxLen)
            return floatStr;

        return errorString;
    }

    Item {
        id: theItem
        width: display.width + 32
        height: display.height

        Rectangle {
            id: rect
            x: 16
            color: "white"
            height: theItem.height
            width: display.width - 16
        }
        Image {
            anchors.right: rect.left
            source: "images/paper-edge-left.png"
            height: theItem.height
            fillMode: Image.TileVertically
        }
        Image {
            anchors.left: rect.right
            source: "images/paper-edge-right.png"
            height: theItem.height
            fillMode: Image.TileVertically
        }

        Image {
            id: grip
            source: "images/paper-grip.png"
            anchors.horizontalCenter: theItem.horizontalCenter
            anchors.bottom: theItem.bottom
            anchors.bottomMargin: 20
        }

        ListView {
            id: listView
            x: 16; y: 30
            width: display.width
            height: display.height - 50 - y
            delegate: Item {
                id: delegateItem
                height: display.fontSize * 1.1
                width: listView.width
                Text {
                    id: operator
                    x: 6
                    font.pixelSize: display.fontSize
                    color: "#6da43d"
                    text: model.operator
                }
                Text {
                    id: operand
                    font.pixelSize: display.fontSize
                    anchors.right: delegateItem.right
                    anchors.rightMargin: 22
                    text: model.operand
                }
            }
            model: ListModel { }
        }

    }

}
