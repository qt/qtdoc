// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import "content"
import "content/calculator.js" as CalcEngine


Rectangle {
    id: window
    width: 320
    height: 480
    focus: true
    color: "#272822"

    onWidthChanged: controller.reload()
    onHeightChanged: controller.reload()

    function operatorPressed(operator) {
        CalcEngine.operatorPressed(operator)
    }
    function digitPressed(digit) {
        CalcEngine.digitPressed(digit)
    }
    function isButtonDisabled(op) {
        return CalcEngine.disabled(op)
    }

    Item {
        id: pad
        width: 180
        NumberPad { id: numPad; y: 10; anchors.horizontalCenter: pad.horizontalCenter }
    }

    AnimationController {
        id: controller
        animation: ParallelAnimation {
            id: anim
            NumberAnimation { target: display; property: "x"; duration: 400; from: -16; to: window.width - display.width; easing.type: Easing.InOutQuad }
            NumberAnimation { target: pad; property: "x"; duration: 400; from: window.width - pad.width; to: 0; easing.type: Easing.InOutQuad }
            SequentialAnimation {
                NumberAnimation { target: pad; property: "scale"; duration: 200; from: 1; to: 0.97; easing.type: Easing.InOutQuad }
                NumberAnimation { target: pad; property: "scale"; duration: 200; from: 0.97; to: 1; easing.type: Easing.InOutQuad }
            }
        }
    }

    Keys.onPressed: function(event) {
        switch (event.key) {
        case Qt.Key_0:
            digitPressed("0")
            break
        case Qt.Key_1:
            digitPressed("1")
            break
        case Qt.Key_2:
            digitPressed("2")
            break
        case Qt.Key_3:
            digitPressed("3")
            break
        case Qt.Key_4:
            digitPressed("4")
            break
        case Qt.Key_5:
            digitPressed("5")
            break
        case Qt.Key_6:
            digitPressed("6")
            break
        case Qt.Key_7:
            digitPressed("7")
            break
        case Qt.Key_8:
            digitPressed("8")
            break
        case Qt.Key_9:
            digitPressed("9")
            break
        case Qt.Key_Plus:
            operatorPressed("+")
            break
        case Qt.Key_Minus:
            operatorPressed("-")
            break
        case Qt.Key_Asterisk:
            operatorPressed("×")
            break
        case Qt.Key_Slash:
            operatorPressed("÷")
            break
        case Qt.Key_Enter:
        case Qt.Key_Return:
            operatorPressed("=")
            break
        case Qt.Key_Comma:
        case Qt.Key_Period:
            digitPressed(".")
            break
        case Qt.Key_Backspace:
            operatorPressed("backspace")
            break
        }

    }

    Display {
        id: display
        x: -16
        width: window.width - pad.width
        height: window.height

        MouseArea {
            id: mouseInput
            property real startX: 0
            property real oldP: 0
            property bool rewind: false

            anchors {
                bottom: display.bottom
                left: display.left
                right: display.right
            }
            height: 50
            onPositionChanged: {
                const reverse = startX > window.width / 2
                const mx = mapToItem(window, mouseInput.mouseX, mouseInput.mouseY).x
                const p = Math.abs((mx - startX) / (window.width - display.width))

                rewind = p < oldP ? !reverse : reverse

                controller.progress = reverse ? 1 - p : p
                oldP = p
            }
            onPressed: startX = mapToItem(window, mouseInput.mouseX, mouseInput.mouseY).x

            onReleased: {
                if (rewind)
                    controller.completeToBeginning()
                else
                    controller.completeToEnd()
            }
        }
    }

}
