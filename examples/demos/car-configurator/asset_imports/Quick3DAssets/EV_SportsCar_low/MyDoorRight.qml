// Copyright (C) 2024 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick3D

Model {
    id: doorRight
    pickable: true
    objectName: "MyDoorRight"
    property bool rain
    z: 0.8587785363197327
    source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/EV_SportsCar_low/meshes/doorRight_mesh.mesh"
    receivesReflections: true
    property bool isOpen: false
    materials: [
        rain ? carPaint_material_rain : carPaint_material,
        rain ? metalDark_material_rain : metalDark_material,
        rain ? plasticBlack_material24_rain : plasticBlack_material24,
        rain ? chrome_material_rain : chrome_material,
        rain ? glassLights_material_rain : glassLights_material,
        rain ? glassRedLights_material_rain : glassRedLights_material,
        rain ? chromeLightsBMP_material_rain : chromeLightsBMP_material,
        glassLightsIllum_material,
        metalMirror_material,
        rain ? aluminium_material_rain : aluminium_material,
        rain ? glassWindsSide_material_rain : glassWindsSide_material,
        intAlcanataraGrey_material,
        intLeatherBlack_material,
        rain ? carPaint_material_rain : carPaint_material,
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
                target: doorRight
                eulerRotation.z: -49

                eulerRotation.y: 19
                eulerRotation.x: 39
                // 30 16 -35
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
                        target: doorRight
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
                        target: doorRight
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
                        target: doorRight
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
