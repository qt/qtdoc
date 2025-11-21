// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Layouts

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

        property bool isPortraitMode: root.width < root.minLandscapeModeWidth

        ApplicationState {
            id: state
            display: display
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

            isPortraitMode: root.isPortraitMode
            state: state
        }

        // define the responsive layouts
        ColumnLayout {
            id: portraitMode
            anchors.fill: parent
            visible: root.isPortraitMode

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
            visible: !root.isPortraitMode

            LayoutItemProxy {
                target: display
            }
            LayoutItemProxy {
                target: numberPad
                Layout.alignment: Qt.AlignVCenter
            }
        }

        Keys.onPressed: function (event) {
            switch (event.key) {
                case Qt.Key_0: state.digitPressed("0"); break;
                case Qt.Key_1: state.digitPressed("1"); break;
                case Qt.Key_2: state.digitPressed("2"); break;
                case Qt.Key_3: state.digitPressed("3"); break;
                case Qt.Key_4: state.digitPressed("4"); break;
                case Qt.Key_5: state.digitPressed("5"); break;
                case Qt.Key_6: state.digitPressed("6"); break;
                case Qt.Key_7: state.digitPressed("7"); break;
                case Qt.Key_8: state.digitPressed("8"); break;
                case Qt.Key_9: state.digitPressed("9"); break;
                case Qt.Key_E: state.digitPressed("e"); break;
                case Qt.Key_P: state.digitPressed("π"); break;
                case Qt.Key_Plus: state.operatorPressed("+"); break;
                case Qt.Key_Minus: state.operatorPressed("-"); break;
                case Qt.Key_Asterisk: state.operatorPressed("×"); break;
                case Qt.Key_Slash: state.operatorPressed("÷"); break;
                case Qt.Key_Enter:
                case Qt.Key_Return: state.operatorPressed("="); break;
                case Qt.Key_Comma:
                case Qt.Key_Period: state.digitPressed("."); break;
                case Qt.Key_Backspace: state.operatorPressed("bs"); break;
            }
        }
    }
}
