// Copyright (C) 2023 The Qt Company Ltd.
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

    Item {
        id: pad
        width: 180
        NumberPad {
            id: numPad
            y: 10
            anchors.horizontalCenter: pad.horizontalCenter
            display: display
        }
    }

    AnimationController {
        id: controller
        animation: ParallelAnimation {
            NumberAnimation {
                target: display
                property: "x"
                duration: 400
                from: -16
                to: window.width - display.width
                easing.type: Easing.InOutQuad
            }
            NumberAnimation {
                target: pad
                property: "x"
                duration: 400
                from: window.width - pad.width
                to: 0
                easing.type: Easing.InOutQuad
            }
            SequentialAnimation {
                NumberAnimation {
                    target: pad
                    property: "scale"
                    duration: 200
                    from: 1
                    to: 0.97
                    easing.type: Easing.InOutQuad
                }
                NumberAnimation {
                    target: pad
                    property: "scale"
                    duration: 200
                    from: 0.97
                    to: 1
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }

    Keys.onPressed: function(event) {
        if (event.key >= Qt.Key_0 && event.key <= Qt.Key_9) {
            CalcEngine.digitPressed(parseInt(event.text), display)
            return
        }

        switch (event.key) {
        case Qt.Key_Plus:
        case Qt.Key_Minus:
        case Qt.Key_Asterisk:
        case Qt.Key_Slash:
            CalcEngine.operatorPressed(event.text, display)
            break
        case Qt.Key_Enter:
        case Qt.Key_Return:
            CalcEngine.operatorPressed("=", display)
            break
        case Qt.Key_Comma:
        case Qt.Key_Period:
            CalcEngine.digitPressed(".", display)
            break
        case Qt.Key_Backspace:
            CalcEngine.operatorPressed("backspace", display)
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
