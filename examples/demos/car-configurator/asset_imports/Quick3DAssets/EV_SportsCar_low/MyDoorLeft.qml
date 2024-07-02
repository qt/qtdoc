// Copyright (C) 2024 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick3D

Model {
    id: doorLeft
    objectName: "DoorLeft"
    z: 0.8587785363197327
    source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/EV_SportsCar_low/meshes/doorLeft_mesh.mesh"
    property bool isOpen: false
    materials: [
        carPaint_material,
        metalDark_material,
        plasticBlack_material24,
        chrome_material,
        glassLights_material,
        glassRedLights_material,
        chromeLightsBMP_material,
        glassLightsIllum_material,
        metalMirror_material,
        aluminium_material,
        glassWindsSide_material,
        intAlcanataraGrey_material,
        intLeatherBlack_material,
        carPaint_material,
        intLeatherSeatsPattern_material,
        intButtons_material,
        intGrillBump_material
    ]

    Node {
        id: __materialLibrary__
    }
    states: [
        State {
            name: "closed"
            when: !isOpen
        },
        State {
            name: "open"
            when: isOpen

            PropertyChanges {
                target: doorLeft
                eulerRotation.z: 51

                eulerRotation.y: -18
                eulerRotation.x: 41
            }
        }
    ]
    transitions: [
        Transition {
            id: transition
            ParallelAnimation {
                SequentialAnimation {
                    PauseAnimation {
                        duration: 50
                    }

                    PropertyAnimation {
                        target: doorLeft
                        property: "eulerRotation.x"
                        duration: 1000
                        easing.type: Easing.InOutQuad
                    }
                }

                SequentialAnimation {
                    PauseAnimation {
                        duration: 50
                    }

                    PropertyAnimation {
                        target: doorLeft
                        property: "eulerRotation.y"
                        duration: 1000
                        easing.type: Easing.InOutQuad
                    }
                }

                SequentialAnimation {
                    PauseAnimation {
                        duration: 50
                    }

                    PropertyAnimation {
                        target: doorLeft
                        property: "eulerRotation.z"
                        duration: 1000
                        easing.type: Easing.InOutQuad
                    }
                }
            }
            to: "*"
            from: "*"
        }
    ]
}
