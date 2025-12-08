// Copyright (C) 2024 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick3D

Model {
    id: hood
    property bool rain: false
    objectName: "Hood"
    pickable: true
    z: 0.6023856401443481
    source: rootWindow.downloadBase + "/asset_imports/Quick3DAssets/EV_SportsCar_low/meshes/hood_mesh.mesh"
    receivesReflections: true
    property bool isOpen: false
    materials: [
        rain ? carPaint_material_rain : carPaint_material,
        rain ? plasticBlack_material24_rain : plasticBlack_material24,
        rain ? chrome_material_rain : chrome_material
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
                target: hood
                x: 0
                y: 0.775
                eulerRotation.z: 0.00001
                eulerRotation.y: -0
                eulerRotation.x: -35

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
                        target: hood
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
                        target: hood
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
                        target: hood
                        property: "eulerRotation.z"
                        duration: 1000
                        easing.type: Easing.InOutQuad
                    }
                }

                SequentialAnimation {
                    PauseAnimation {
                        duration: 50
                    }

                    PropertyAnimation {
                        target: hood
                        property: "x"
                        duration: 1000
                        easing.type: Easing.InOutQuad
                    }
                }

                SequentialAnimation {
                    PauseAnimation {
                        duration: 50
                    }

                    PropertyAnimation {
                        target: hood
                        property: "y"
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
