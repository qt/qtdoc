// Copyright (C) 2025 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick3D

Item {
    id: currentToy

    property alias toy: toy3D.toy
    property bool isMaximized: false
    property int index: -1
    required property AccessoryModel accessoryModel

    implicitWidth: {
        if (!isMaximized)
            return ApplicationConfig.responsiveSize(921)
        return ApplicationConfig.isPortrait ? ApplicationConfig.responsiveSize(1664)
                                            : ApplicationConfig.responsiveSize(1699)
    }
    implicitHeight: {
        if (!isMaximized)
            return ApplicationConfig.responsiveSize(1238)
        return ApplicationConfig.isPortrait ? ApplicationConfig.responsiveSize(2237)
                                            : ApplicationConfig.responsiveSize(2318)
    }

    View3D {
        id: toy3D
        property var toy: bearLoader.item
        anchors.fill: parent

        camera: sceneCamera

        environment: SceneEnvironment {
            id: sceneEnv
            backgroundMode: SceneEnvironment.Transparent
            clearColor: "transparent"
            antialiasingMode: SceneEnvironment.MSAA
            antialiasingQuality: SceneEnvironment.High
        }

        Node {
            id: sceneRoot

            PerspectiveCamera {
                id: sceneCamera
                y: 73
                z: 260
                clipNear: 100
                clipFar: 2000
                frustumCullingEnabled: true
                fieldOfView: 39
            }

            SpotLight {
                id: key
                x: 80
                y: 220
                z: 280
                visible: true
                eulerRotation.x: -25
                color: "#e7e7e7"
                brightness: 20
                coneAngle: 71
                innerConeAngle: 26
                linearFade: 1.4
                quadraticFade: 0.3
                castsShadow: true
                shadowMapQuality: Light.ShadowMapQualityVeryHigh
                shadowBias: 5
                shadowFactor: 93
            }

            Node {
                id: loaderNode
                Loader3D {
                    id: bearLoader
                    active: true
                    // TODO: set the source component to the correct toy
                    sourceComponent: emptyComponent

                    Component {
                        id: emptyComponent
                        QtObject {}
                    }
                }
            }

            Node {
                id: accessoriesRoot
            }
        }

        OrbitCameraController {
            id: orbitCam
            anchors.fill: parent
            origin: loaderNode
            camera: sceneCamera
        }
    }
}
