// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause
import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts
import QtSensors

ApplicationWindow {
    id: root
    width: 800
    height: 600
    visible: true
    property real currDrawerWidth: drawer.width * drawer.position

    Accelerometer {
        id: accelerometer
        dataRate: 25
        active: true
        property real previousForce: 0
        property real multiplier: 100
        onReadingChanged: {
            let force = Qt.vector3d(reading.x, reading.y, reading.z - 9.81)
            if (isShake(force, previousForce)) {
                tapLabel.hide()
                force.x *= multiplier
                force.y *= multiplier
                force.z *= multiplier
                scene.spawnDice(diceSlider.value, force)
            }
            previousForce = force.length()
        }
        function isShake(force, previousForce) {
            return ((force.length() > 16) && (force.length() < previousForce))
        }
    }

    Scene {
        id: scene
        x: currDrawerWidth - 10 // pad 10px for rounded corners
        width: parent.width - currDrawerWidth + 20
        height: parent.height

        settingsStaticFriction: staticFrictionSlider.value
        settingsDynamicFriction: dynamicFrictionSlider.value
        settingsRestitution: restitutionSlider.value

        Label {
            id: tapLabel
            anchors {
                centerIn: parent
            }

            text: qsTr("Tap, click or shake to throw dice")
            font.pixelSize: 32
            font.bold: true
            style: Text.Raised
            color: "white"

            NumberAnimation on opacity {
                id: tapLabelAnimation
                running: false
                from: 1
                to: 0
                duration: 300
            }

            function hide() {
                if (tapLabel.opacity >= 1) {
                    tapLabelAnimation.running = true
                }
            }
        }

        MouseArea {
            anchors {
                fill: parent
            }
            onClicked: {
                tapLabel.hide()
                scene.spawnDice(diceSlider.value, Qt.vector3d(0, 0, 0))
            }
        }

        function updateGravity() {
            if (gravityZero.checked) {
                scene.settingGravity = 0
            }
            if (gravityMoon.checked) {
                scene.settingGravity = 162
            }
            if (gravityMars.checked) {
                scene.settingGravity = 371
            }
            if (gravityEarth.checked) {
                scene.settingGravity = 980.7
            }
        }
    }

    Drawer {
        id: drawer
        height: root.height
        width: column.width + 40

        ColumnLayout {
            id: column
            anchors.horizontalCenter: parent.horizontalCenter

            // Static friction
            RowLayout {
                Label {
                    text: qsTr("Static friction")
                    Layout.fillWidth: true
                }
                Label {
                    font.bold: true
                }
            }
            Slider {
                id: staticFrictionSlider
                focusPolicy: Qt.NoFocus
                from: 0
                to: 1
                value: 0.5
            }

            // Dynamic friction
            RowLayout {
                Label {
                    text: qsTr("Dynamic friction")
                    Layout.fillWidth: true
                }
                Label {
                    font.bold: true
                }
            }
            Slider {
                id: dynamicFrictionSlider
                focusPolicy: Qt.NoFocus
                from: 0
                to: 1
                value: 0.5
            }

            // Restitution
            RowLayout {
                Label {
                    text: qsTr("Restitution")
                    Layout.fillWidth: true
                }
                Label {
                    font.bold: true
                }
            }
            Slider {
                id: restitutionSlider
                focusPolicy: Qt.NoFocus
                from: 0
                to: 1
                value: 0.8
                stepSize: 0.05
            }

            // Gravity
            Label {
                text: qsTr("Gravity")
            }
            GridLayout {
                columns: 2
                RadioButton {
                    id: gravityZero
                    text: qsTr("Zero")
                    onCheckedChanged: scene.updateGravity()
                }
                RadioButton {
                    id: gravityMoon
                    text: qsTr("Moon")
                    onCheckedChanged: scene.updateGravity()
                }
                RadioButton {
                    id: gravityMars
                    text: qsTr("Mars")
                    onCheckedChanged: scene.updateGravity()
                }
                RadioButton {
                    id: gravityEarth
                    text: qsTr("Earth")
                    onCheckedChanged: scene.updateGravity()
                    checked: true
                }
            }

            // No. dice
            RowLayout {
                Label {
                    text: qsTr("No. dice")
                    Layout.fillWidth: true
                }
            }
            Slider {
                id: diceSlider
                focusPolicy: Qt.NoFocus
                from: 1
                to: 10
                value: 5
                stepSize: 1
                onValueChanged: scene.spawnDice(value, Qt.vector3d(0, 0, 0))
            }

            // Throw dice
            Button {
                id: throwButton
                Layout.alignment: Qt.AlignHCenter
                text: qsTr("Throw dice")
                onClicked: scene.spawnDice(diceSlider.value,
                                           Qt.vector3d(0, 0, 0))
            }
        }
    }

    RoundButton {
        id: iconOpen
        text: qsTr("\u2630")
        x: currDrawerWidth
        onClicked: {
            tapLabel.hide()
            drawer.open()
        }
    }
}
