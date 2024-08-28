// Copyright (C) 2024 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import "doorIcon"
import QtQuick.Controls
import QtQuick.Studio.DesignEffects

Rectangle {
    id: doorButton
    width: 48
    height: 48
    opacity: 0.7
    color: "#00000000"
    radius: 8
    scale: 1
    property bool isChecked: checkBox.checked
    property bool isRendered: true
    property vector3d trackedWorldPosition: cube.scenePosition

    function updateState() {
        var scenePosition = sceneCamera2.mapToViewport(trackedWorldPosition)
        doorButton.x = scenePosition.x * root.width
        doorButton.y = scenePosition.y * root.height
    }

    Component.onCompleted: updateState()

    Connections {
        target: sceneCamera2
        function onSceneTransformChanged() { doorButton.updateState() }
    }

    CheckBox {
        id: checkBox
        opacity: 0
        text: qsTr(" ")
        anchors.fill: parent
    }

    Connections {
        target: root
        function onWidthChanged() { doorButton.updateState() }
        function onHeightChanged() { doorButton.updateState() }
    }

    Door_button {
        id: door_button
    }
    FrameAnimation {
        running: true
        onTriggered: updateState()
    }

    DesignEffect {
        backgroundLayer: view3D
        backgroundBlurRadius: 10
        backgroundBlurVisible: true
    }

    states: [
        State {
            name: "rendered"
            when: isRendered
        },
        State {
            name: "NotRendered"
            when: !isRendered

            PropertyChanges {
                target: doorButton
                opacity: 0.223
                scale: 0
            }
        }
    ]

    transitions: [
        Transition {
            id: transition
            ParallelAnimation {
                SequentialAnimation {
                    PauseAnimation {
                        duration: 567
                    }

                    PropertyAnimation {
                        target: doorButton
                        property: "opacity"
                        duration: 431
                    }
                }

                SequentialAnimation {
                    PauseAnimation {
                        duration: 50
                    }

                    PropertyAnimation {
                        target: doorButton
                        property: "scale"
                        duration: 1032
                    }
                }
            }
            to: "*"
            from: "*"
        }
    ]
}
