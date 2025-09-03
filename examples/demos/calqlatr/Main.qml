// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import "content"
import "content/calculator.js" as CalcEngine

Window {
    visible: true
    width: 320
    height: 480
    minimumWidth: Math.max(numberPad.portraitModeWidth, display.minWidth) + root.margin * 2
    minimumHeight: display.minHeight + numberPad.height + root.margin * 3
    color: root.backgroundColor

    Item {
        id: root
        anchors.fill: parent

        anchors.topMargin: parent.SafeArea.margins.top
        anchors.leftMargin: parent.SafeArea.margins.left
        anchors.rightMargin: parent.SafeArea.margins.right
        anchors.bottomMargin: parent.SafeArea.margins.bottom

        readonly property int margin: 18
        readonly property color backgroundColor: "#222222"
        readonly property int minLandscapeModeWidth: numberPad.landscapeModeWidth
                                                     + display.minWidth + margin * 3
        property bool isPortraitMode: width < minLandscapeModeWidth

        onIsPortraitModeChanged: {
            if (isPortraitMode) {
                portraitMode.visible = true;
                landscapeMode.visible = false;
            } else {
                portraitMode.visible = false;
                landscapeMode.visible = true;
            }
        }

        Display {
            id: display
            readonly property int minWidth: 210
            readonly property int minHeight: 60

            Layout.minimumWidth: minWidth
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.margins: root.margin

            // remove the margin on the side that the numberPad is on, to prevent a double margin
            Layout.bottomMargin: root.isPortraitMode ? 0 : root.margin
            Layout.rightMargin: root.isPortraitMode ? root.margin : 0
        }

        NumberPad {
            id: numberPad
            Layout.margins: root.margin
        }

        // define the responsive layouts
        ColumnLayout {
            id: portraitMode
            anchors.fill: parent
            visible: true

            LayoutItemProxy {
                target: display
                Layout.minimumHeight: display.minHeight
            }
            LayoutItemProxy {
                target: numberPad
                Layout.alignment: Qt.AlignHCenter
            }
        }

        RowLayout {
            id: landscapeMode
            anchors.fill: parent
            visible: false

            LayoutItemProxy {
                target: display
            }
            LayoutItemProxy {
                target: numberPad
                Layout.alignment: Qt.AlignVCenter
            }
        }

        function operatorPressed(operator) {
            CalcEngine.operatorPressed(operator, display);
        }
        function digitPressed(digit) {
            CalcEngine.digitPressed(digit, display);
        }
        function isButtonDisabled(op) {
            return CalcEngine.isOperationDisabled(op, display);
        }

        Keys.onPressed: function (event) {
            switch (event.key) {
                case Qt.Key_0: digitPressed("0"); break;
                case Qt.Key_1: digitPressed("1"); break;
                case Qt.Key_2: digitPressed("2"); break;
                case Qt.Key_3: digitPressed("3"); break;
                case Qt.Key_4: digitPressed("4"); break;
                case Qt.Key_5: digitPressed("5"); break;
                case Qt.Key_6: digitPressed("6"); break;
                case Qt.Key_7: digitPressed("7"); break;
                case Qt.Key_8: digitPressed("8"); break;
                case Qt.Key_9: digitPressed("9"); break;
                case Qt.Key_E: digitPressed("e"); break;
                case Qt.Key_P: digitPressed("π"); break;
                case Qt.Key_Plus: operatorPressed("+"); break;
                case Qt.Key_Minus: operatorPressed("-"); break;
                case Qt.Key_Asterisk: operatorPressed("×"); break;
                case Qt.Key_Slash: operatorPressed("÷"); break;
                case Qt.Key_Enter:
                case Qt.Key_Return: operatorPressed("="); break;
                case Qt.Key_Comma:
                case Qt.Key_Period: digitPressed("."); break;
                case Qt.Key_Backspace: operatorPressed("bs"); break;
            }
        }
    }
}
