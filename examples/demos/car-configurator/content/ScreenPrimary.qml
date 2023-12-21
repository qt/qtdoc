// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Controls
import QtQuick.Timeline
import QtQuick3D
import QtQuick3D.Effects
import QtQuick3D.Helpers
import CarRendering
import Quick3DAssets.Uk5ofde_LOD0
import Quick3DAssets.Uk5pebv_LOD0
import Quick3DAssets.Ulbrbdt_LOD0
import Quick3DAssets.Venodhb_LOD0
import Quick3DAssets.Ventdee_LOD0
import "FigmaExportCarConfig"
import "WallEffect1"
import "WallEffect2"
import "WallEffect3"
import Quick3DAssets.EV_SportsCar_low

Rectangle {
    id: root

    width: Constants.width
    height: Constants.height
    color: Constants.screenColor
    state: "State1"
    focus: true
    transformOrigin: Item.Top

    Keys.onPressed: (event) => {
        if (event.key === Qt.Key_1) {
            gui.visible = !gui.visible
        }
    }

    Component.onCompleted: root.forceActiveFocus()

    // this property tells a parent when this object is completely loaded (including preloaded assets)
    property bool assetPreLoadComplete: false

    // this property enables performance enhancements for android targets
    readonly property bool perfMode: Qt.platform.os === 'android'

    property real demoCameraRotation: 0

    Timer {
        id: preloadTimer

        running: true
        repeat: true
        interval: 1

        property int count: 0
    }

    Connections {
        target: preloadTimer

        onTriggered: {
            if (preloadTimer.count == 0)
                btnAnimated.toggleCheck()
            else if (preloadTimer.count == 1)
                btnStudio.toggleCheck()
            else if (preloadTimer.count == 2)
                btnGarage.toggleCheck()
            else if (preloadTimer.count == 3)
                btnDesert.toggleCheck()
            else if (preloadTimer.count == 4)
                btnLight.toggleCheck()
            else if (preloadTimer.count == 5)
                btnLight.toggleCheck()
            else {
                root.assetPreLoadComplete = true
                preloadTimer.running = false
            }
            ++preloadTimer.count
        }
    }

    View3D {
        id: view3D

        anchors.fill: parent
        camera: sceneCamera2
        environment: showhall

        Node {
            id: scene2

            ReflectionProbe {
                id: reflectionProbe1

                boxSize.x: 3000
                boxSize.y: 2000
                boxSize.z: 3000
                timeSlicing: ReflectionProbe.IndividualFaces
                clearColor: "#000000"
            }

            Node {
                id: sceneObjects1

                y: -500
                z: -1000

                Node {
                    id: camOverride

                    x: 10
                    z: -10

                    Node {
                        id: cameraRoot

                        eulerRotation.y: 360
                        eulerRotation.z: 0

                        PerspectiveCamera {
                            id: sceneCamera2

                            x: -31.83
                            y: 223.61
                            z: 665.37
                            eulerRotation.x: -12.17219
                            fieldOfView: 64
                            fieldOfViewOrientation: PerspectiveCamera.Horizontal

                            Behavior on x {
                                enabled: !demo.running
                                NumberAnimation{duration: 2000}
                            }
                            Behavior on y {
                                enabled: !demo.running
                                NumberAnimation{duration: 2000}
                            }
                            Behavior on z {
                                enabled: !demo.running
                                NumberAnimation{duration: 2000}
                            }
                            Behavior on fieldOfView {
                                enabled: !demo.running
                                NumberAnimation{}
                            }
                        }
                    }
                }

                Model {
                    id: plane3

                    x: -8.062
                    y: 4.1
                    visible: true
                    source: "#Rectangle"
                    castsShadows: false
                    receivesShadows: false
                    receivesReflections: false
                    z: 8.06232
                    eulerRotation.x: -90
                    eulerRotation.y: -45
                    eulerRotation.z: -90
                    scale.x: 11.78291
                    scale.y: 13.01303
                    scale.z: 13
                    materials: groundMat1
                    depthBias: -500
                }

                Model {
                    id: plane2

                    y: 250
                    visible: false
                    source: "#Rectangle"
                    receivesReflections: false
                    z: -500
                    scale.x: 20
                    scale.y: 10
                    scale.z: 10
                    materials: principledMaterial2
                    castsShadows: false
                    receivesShadows: true
                }

                Headlights {
                    id: headlights
                    x: -23
                    y: -20
                    visible: btnLight.checked

                    z: 17

                    eulerRotation.x: 0
                    eulerRotation.y: -45
                    eulerRotation.z: 0
                    scale.x: 0.1
                    scale.y: 0.1
                    scale.z: 0.1

                    Model {
                        id: backlight_red

                        x: 0
                        y: 17
                        source: "#Rectangle"
                        materials: backlightNew
                        z: -2540.18164
                        eulerRotation.x: -90
                        eulerRotation.y: 180
                        scale.x: 42
                        scale.y: 25
                        scale.z: 25
                    }
                }

                Venodhb_LOD0 {
                    id: desertGround

                    y: -21.468
                    visible: false
                    scale.x: 5
                    scale.y: 5
                    scale.z: 5

                    Uk5ofde_LOD0 {
                        id: uk5ofde_LOD0
                    }

                    Uk5pebv_LOD0 {
                        id: uk5pebv_LOD0
                    }

                    Ulbrbdt_LOD0 {
                        id: ulbrbdt_LOD0
                    }

                    Ventdee_LOD0 {
                        id: ventdee_LOD0
                    }
                }

                Model {
                    id: garageFloor

                    y: 0.5
                    source: "#Rectangle"
                    receivesReflections: true
                    scale.x: 20
                    scale.y: 20
                    scale.z: 20
                    eulerRotation.y: 0
                    eulerRotation.x: -90
                    materials: rectMaterial
                }

                Model {
                    id: studioFloor

                    y: -1
                    visible: false
                    source: "#Rectangle"
                    eulerRotation.z: 45
                    eulerRotation.x: -90
                    materials: rectMaterial2
                    eulerRotation.y: 0
                    scale.y: 50
                    scale.z: 35

                    Model {
                        id: areaLight

                        source: "#Rectangle"
                        materials: rectMaterial3
                        x: 0
                        y: 0
                        eulerRotation.z: 0
                        eulerRotation.y: 0
                        scale.y: 0.02
                        scale.x: 0.1
                        eulerRotation.x: 180
                        z: 11
                    }

                    Node {
                        id: group

                        Model {
                            id: areaLight1

                            x: 0
                            y: 35
                            source: "#Rectangle"
                            eulerRotation.z: 0
                            materials: rectMaterial3
                            eulerRotation.y: 0
                            z: 20
                            scale.x: 0.7
                            eulerRotation.x: 90
                            scale.y: 0.01
                        }

                        Model {
                            id: areaLight2

                            x: 35
                            y: 0
                            source: "#Rectangle"
                            eulerRotation.z: 90
                            materials: rectMaterial3
                            eulerRotation.y: -90
                            z: 20
                            scale.x: 0.7
                            eulerRotation.x: 0
                            scale.y: 0.01
                        }

                        Model {
                            id: areaLight3

                            x: 0
                            y: -35
                            source: "#Rectangle"
                            eulerRotation.z: 0
                            materials: rectMaterial3
                            eulerRotation.y: 0
                            z: 20
                            scale.x: 0.7
                            eulerRotation.x: -90
                            scale.y: 0.01
                        }

                        Model {
                            id: areaLight4

                            x: -35
                            y: 0
                            source: "#Rectangle"
                            eulerRotation.z: 90
                            materials: rectMaterial3
                            eulerRotation.y: 90
                            z: 20
                            scale.x: 0.7
                            eulerRotation.x: 0
                            scale.y: 0.01
                        }
                    }
                    scale.x: 50
                    receivesReflections: true
                }

                Model {
                    id: animatedstateFloor

                    y: 0
                    visible: false
                    source: "#Rectangle"
                    eulerRotation.x: -90
                    materials: rectMaterial4
                    scale.y: 20
                    eulerRotation.y: 0
                    scale.z: 20
                    scale.x: 20
                    receivesReflections: true
                }

                Ev_SportsCar_low {
                    id: ev_SportsCar_low
                    x: -19
                    eulerRotation.y: -45
                    scale.z: 120
                    scale.y: 120
                    scale.x: 120
                    lightsOn: btnLight.checked

                    PointLight {
                        id: lightPoint

                        x: 0.774
                        y: 1.143
                        visible: btnLight.checked
                        color: "#ff2f00"
                        linearFade: 10
                        constantFade: 1
                        quadraticFade: 10
                        z: -2.60213
                        brightness: 1
                    }

                    PointLight {
                        id: lightPoint1
                        visible: btnLight.checked
                        x: -0.832
                        y: 1.143
                        color: "#ff2f00"
                        linearFade: 10
                        constantFade: 1
                        quadraticFade: 10
                        brightness: 1
                        z: -2.49196
                    }
                }
            }

            PerspectiveCamera {
                id: sceneCamera3

                x: 0
                y: -270.618
                z: -395.07288
                eulerRotation.y: 0
                eulerRotation.z: 0
                eulerRotation.x: -18
                fieldOfView: 100
                fieldOfViewOrientation: PerspectiveCamera.Horizontal
            }

            DirectionalLight {
                id: lightDirectional

                castsShadow: false
                brightness: 0.5
                eulerRotation.z: -180
                eulerRotation.y: 180
                eulerRotation.x: -54.99136
            }

            DirectionalLight {
                id: lightDirectional1

                shadowFactor: 100
                shadowMapQuality: Light.ShadowMapQualityMedium
                castsShadow: true
                brightness: 0.5
                eulerRotation.z: -0.00002
                eulerRotation.y: 0.00002
                eulerRotation.x: -57.72036
            }
        }

        Node {
            id: environments1

            ExtendedSceneEnvironment {
                id: showhall

                lightProbe: _Hall
                backgroundMode: SceneEnvironment.SkyBox
                tonemapMode: SceneEnvironment.TonemapModeLinear
                probeExposure: 1
                depthPrePassEnabled: false
                depthTestEnabled: true
                antialiasingMode: SceneEnvironment.MSAA
                antialiasingQuality: perfMode ? SceneEnvironment.Medium : SceneEnvironment.VeryHigh
                clearColor: "#000000"
                probeHorizon: 0.5

                Texture {
                    id: _Hall
                    source: rootWindow.downloadBase + "/content/images/HDR/_Hall.ktx"
                    mipFilter: Texture.Linear
                    scaleV: 2
                }
                temporalAAEnabled: false
            }

            ExtendedSceneEnvironment {
                id: desert

                lightProbe: _Desert
                depthPrePassEnabled: false
                probeExposure: 1.5
                tonemapMode: SceneEnvironment.TonemapModeLinear
                backgroundMode: SceneEnvironment.SkyBox
                depthTestEnabled: true
                antialiasingMode: SceneEnvironment.MSAA
                antialiasingQuality: perfMode ? SceneEnvironment.Medium : SceneEnvironment.VeryHigh
                clearColor: "#000000"
                probeHorizon: 0.5
                temporalAAEnabled: false
            }

            ExtendedSceneEnvironment {
                id: videoRoom

                aoSoftness: 0
                aoDistance: 0
                probeExposure: 1
                tonemapMode: SceneEnvironment.TonemapModeLinear
                antialiasingMode: SceneEnvironment.MSAA
                antialiasingQuality: perfMode ? SceneEnvironment.Medium : SceneEnvironment.VeryHigh
                clearColor: "#000000"
                depthPrePassEnabled: false
                backgroundMode: SceneEnvironment.Color
                depthTestEnabled: true
                probeHorizon: 0
                Vignette {
                    id: vignette
                    vignetteStrength: 15
                    vignetteColor: Qt.vector3d(0, 0, 0)
                }
                temporalAAEnabled: false
            }

            ExtendedSceneEnvironment {
                id: studio

                tonemapMode: SceneEnvironment.TonemapModeLinear
                probeExposure: 1
                probeHorizon: 1
                clearColor: "#000000"
                antialiasingQuality: perfMode ? SceneEnvironment.Medium : SceneEnvironment.VeryHigh
                temporalAAEnabled: false
                depthTestEnabled: true
                backgroundMode: SceneEnvironment.SkyBox
                antialiasingMode: SceneEnvironment.MSAA
                depthPrePassEnabled: false
            }
        }

        Node {
            id: __materialLibrary__

            PrincipledMaterial {
                id: groundMat1
                opacity: 0.875
                normalStrength: 0.5
                specularAmount: 0
                metalness: 0
                opacityChannel: Material.A
                blendMode: PrincipledMaterial.SourceOver
                lighting: PrincipledMaterial.NoLighting
                specularTint: 1
                baseColor: "#000000"
                clearcoatRoughnessAmount: 0
                emissiveFactor.y: 0
                objectName: "groundMat1"
                alphaMode: PrincipledMaterial.Default
                depthDrawMode: Material.AlwaysDepthDraw
                occlusionAmount: 1
                roughness: 1
                opacityMap: ground1
                occlusionMap: ground1
                transmissionChannel: Material.R
                clearcoatAmount: 0
                transmissionFactor: 0
                alphaCutoff: 1
                cullMode: Material.BackFaceCulling
                emissiveFactor.x: 0
            }

            PrincipledMaterial {
                id: principledMaterial2
                specularAmount: 0
                clearcoatAmount: 0
                lighting: PrincipledMaterial.NoLighting
                specularTint: 0
                baseColor: "#ffffff"
                objectName: "principledMaterial2"
                baseColorMap: videoBG

                Texture {
                    id: videoBG
                    // Adjust these to suit the target HW quality/performance
                    property real videoWallWidth: 1024
                    property real videoWallHeight: 512
                    sourceItem: wallEffect1

                    WallEffect1 {
                        id: wallEffect1

                        width: videoBG.videoWallWidth
                        height: videoBG.videoWallHeight
                        timeRunning: visible
                        visible: videoBG.sourceItem == wallEffect1
                    }

                    WallEffect2 {
                        id: wallEffect2

                        width: videoBG.videoWallWidth
                        height: videoBG.videoWallHeight
                        timeRunning: visible
                        visible: videoBG.sourceItem == wallEffect2
                    }

                    WallEffect3 {
                        id: wallEffect3

                        width: videoBG.videoWallWidth
                        height: videoBG.videoWallHeight
                        timeRunning: visible
                        visible: videoBG.sourceItem == wallEffect3
                    }
                }
                roughness: 0
            }

            PrincipledMaterial {
                id: rectMaterial
                baseColor: "#b1a5b7"
                objectName: "rectMaterial"
                baseColorMap: tg1kfdzq_2K_Albedo
                depthDrawMode: Material.OpaqueOnlyDepthDraw
                normalMap: tg1kfdzq_2K_Normal
                roughnessMap: tg1kfdzq_2K_Roughness
                roughness: 0.07365
                occlusionMap: tg1kfdzq_2K_AO
            }

            Texture {
                id: _Desert
                source: rootWindow.downloadBase + "/content/images/HDR/_Desert.ktx"
                mipFilter: Texture.Linear
                scaleV: 3
            }

            Texture {
                id: concrete1_Height1
                source: rootWindow.downloadBase + "/content/images/concrete1_Height.png"
                mipFilter: Texture.Linear
                scaleV: 10
                mappingMode: Texture.UV
                generateMipmaps: true
                scaleU: 5
            }

            Texture {
                id: concrete1_Normalogl1
                source: rootWindow.downloadBase + "/content/images/concrete1_Normal-ogl.png"
                mipFilter: Texture.Linear
                scaleV: 10
                generateMipmaps: true
                scaleU: 5
            }

            Texture {
                id: ground1
                source: rootWindow.downloadBase + "/content/images/Ground.png"
                autoOrientation: true
            }

            Texture {
                id: tg1kfdzq_2K_Albedo
                source: rootWindow.downloadBase + "/content/images/tg1kfdzq_2K_Albedo.jpg"
                mipFilter: Texture.Linear
                scaleV: 6
                generateMipmaps: true
                scaleU: 6
            }

            Texture {
                id: tg1kfdzq_2K_AO
                source: rootWindow.downloadBase + "/content/images/tg1kfdzq_2K_AO.jpg"
                mipFilter: Texture.Linear
                scaleV: 6
                generateMipmaps: true
                scaleU: 6
            }

            Texture {
                id: tg1kfdzq_2K_Normal
                source: rootWindow.downloadBase + "/content/images/tg1kfdzq_2K_Normal.jpg"
                mipFilter: Texture.Linear
                scaleV: 6
                generateMipmaps: true
                scaleU: 6
            }

            Texture {
                id: tg1kfdzq_2K_Roughness
                source: rootWindow.downloadBase + "/content/images/tg1kfdzq_2K_Roughness.jpg"
                mipFilter: Texture.Linear
                scaleV: 6
                generateMipmaps: true
                scaleU: 6
            }

            PrincipledMaterial {
                id: rectMaterial3
                emissiveFactor.z: 3
                emissiveFactor.x: 3
                emissiveFactor.y: 3
                objectName: "rectMaterial3"
            }

            PrincipledMaterial {
                id: rectMaterial2
                specularAmount: 0.1
                clearcoatAmount: 0
                specularTint: 0.95
                baseColor: "#222222"
                objectName: "rectMaterial2"
                baseColorMap: vlkhcah_2K_Albedo
                depthDrawMode: Material.OpaqueOnlyDepthDraw
                normalMap: vlkhcah_2K_Normal
                roughnessMap: vlkhcah_2K_Roughness
                roughness: 0.5
                occlusionMap: vlkhcah_2K_AO
            }

            Texture {
                id: vlkhcah_2K_Albedo
                source: rootWindow.downloadBase + "/content/images/vlkhcah_2K_Albedo.jpg"
                mipFilter: Texture.Linear
                scaleV: 4
                generateMipmaps: true
                scaleU: 4
            }

            Texture {
                id: vlkhcah_2K_AO
                source: rootWindow.downloadBase + "/content/images/vlkhcah_2K_AO.jpg"
                mipFilter: Texture.Linear
                scaleV: 4
                generateMipmaps: true
                scaleU: 4
            }

            Texture {
                id: vlkhcah_2K_Normal
                source: rootWindow.downloadBase + "/content/images/vlkhcah_2K_Normal.jpg"
                mipFilter: Texture.Linear
                scaleV: 4
                generateMipmaps: true
                scaleU: 4
            }

            Texture {
                id: vlkhcah_2K_Roughness
                source: rootWindow.downloadBase + "/content/images/vlkhcah_2K_Roughness.jpg"
                mipFilter: Texture.Linear
                scaleV: 4
                generateMipmaps: true
                scaleU: 4
            }

            PrincipledMaterial {
                id: rectMaterial4
                specularAmount: 0.5
                clearcoatAmount: 0
                specularTint: 0
                baseColor: "#222222"
                objectName: "rectMaterial4"
                baseColorMap: vlkhcah_2K_Albedo1
                depthDrawMode: Material.OpaqueOnlyDepthDraw
                normalMap: vlkhcah_2K_Normal1
                roughnessMap: vlkhcah_2K_Roughness1
                roughness: 0.35
                occlusionMap: vlkhcah_2K_AO1
            }

            DefaultMaterial {
                id: backlight
                opacity: 0.3
                lighting: DefaultMaterial.NoLighting
                opacityChannel: Material.A
                diffuseColor: "#ff0000"
                objectName: "backlight"

            }

            PrincipledMaterial {
                id: backlightNew
                opacity: 0.3
                emissiveFactor.x: 1
                opacityMap: backlight1
                baseColor: "#fe0303"
                objectName: "New Material"
            }

            Texture {
                id: vlkhcah_2K_Albedo1
                source: rootWindow.downloadBase + "/content/images/vlkhcah_2K_Albedo.jpg"
                mipFilter: Texture.Linear
                scaleV: 4
                generateMipmaps: true
                scaleU: 4
            }

            Texture {
                id: vlkhcah_2K_AO1
                source: rootWindow.downloadBase + "/content/images/vlkhcah_2K_AO.jpg"
                mipFilter: Texture.Linear
                scaleV: 4
                generateMipmaps: true
                scaleU: 4
            }

            Texture {
                id: vlkhcah_2K_Normal1
                source: rootWindow.downloadBase + "/content/images/vlkhcah_2K_Normal.jpg"
                mipFilter: Texture.Linear
                scaleV: 4
                generateMipmaps: true
                scaleU: 4
            }

            Texture {
                id: vlkhcah_2K_Roughness1
                source: rootWindow.downloadBase + "/content/images/vlkhcah_2K_Roughness.jpg"
                mipFilter: Texture.Linear
                scaleV: 4
                generateMipmaps: true
                scaleU: 4
            }

            Texture {
                id: backlight1
                source: rootWindow.downloadBase + "/content/images/backlight.png"
            }
        }
    }

    MouseRotatorAndWASD {
        xInvert: false
        yInvert: true
    }

    PinchWidget {
        anchors.fill: parent
    }

    Item {
        id: gui

        anchors.fill: parent

        Logo {
            id: logo

            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: 15
            anchors.topMargin:15

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    debugBox.visible = !debugBox.visible
                }
            }
        }

        DebugBox {
            id: debugBox

            visible: false
            anchors.right: parent.right
            anchors.top: logo.bottom
            anchors.rightMargin: 15
            anchors.topMargin: 15

            sView: view3D
        }

        Rectangle {
            id: videoControls

            visible: false
            width: videoRow.width
            height: videoRow.height
            radius: 16
            color: "#5c000000"
            anchors.horizontalCenter: mainControls.horizontalCenter
            anchors.bottom: mainControls.top
            anchors.bottomMargin: 30 - (1 - videoControls.scale) * 110

            scale: mainControls.scale

            Row {
                id: videoRow

                padding: 10
                spacing: 30

                QtObject {
                    id: groupVideo
                    property var buttons: [btnVideo1, btnVideo2, btnVideo3]
                    property Item checkedButton: btnVideo1
                }

                KissButton {
                    id: btnVideo1

                    width: 53
                    height: 43
                    radius: 5
                    iconId: 5
                    group: groupVideo
                    checked: true

                    Image {
                        source: btnVideo1.checked ? rootWindow.downloadBase + "/content/images/1_active.png"
                                                  : rootWindow.downloadBase + "/content/images/1_idle.png"
                        anchors.centerIn: parent
                    }

                    onClicked: videoBG.sourceItem = wallEffect1
                }

                KissButton {
                    id: btnVideo2

                    width: 53
                    height: 43
                    radius: 5
                    iconId: 5
                    group: groupVideo

                    onClicked: videoBG.sourceItem = wallEffect2

                    Image {
                        source: btnVideo2.checked ? rootWindow.downloadBase + "/content/images/2_active.png"
                                                  : rootWindow.downloadBase + "/content/images/2_idle.png"
                        anchors.centerIn: parent
                    }
                }

                KissButton {
                    id: btnVideo3

                    width: 53
                    height: 43
                    radius: 5
                    iconId: 5
                    group: groupVideo

                    onClicked: videoBG.sourceItem = wallEffect3

                    Image {
                        source: btnVideo3.checked ? rootWindow.downloadBase + "/content/images/3_active.png"
                                                  : rootWindow.downloadBase + "/content/images/3_idle.png"
                        anchors.centerIn: parent
                    }
                }
            }
        }

        Row {
            id: mainControls

            spacing: 10
            width: parent.width

            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20 - (1 - mainControls.scale) * 60
            scale: parent.width / Constants.width
            transformOrigin: Item.Left

            Item {
                width: 10
                height: 1
            }

            KissButton {
                id: btnDemo

                iconId: btnDemo.checked ? 8 : 7
                buttonText: "Demo Mode"
                group: "toggle"

                onCheckedChanged: demo.running = btnDemo.checked
            }

            KissButton {
                id: btnReset

                iconId: btnReset.checked ? 2 : 3
                buttonText: "Reset camera"

                onClicked: {
                    demo.running = true
                    demoAnimation.currentFrame = 1
                    demo.running = false
                    demoAnimation.currentFrame = 0

                    if (btnDemo.checked)
                        btnDemo.toggleCheck()
                }
            }

            KissButtonSeparator {
            }

            QtObject {
                id: groupScene

                property var buttons: [btnDesert, btnGarage, btnStudio, btnAnimated]
                property Item checkedButton: btnDesert
            }

            KissButton {
                id: btnDesert

                buttonText: "Desert"
                iconId: btnDesert.checked ? 22 : 23
                group: groupScene
            }

            KissButton {
                id: btnGarage

                buttonText: "Garage"
                iconId: btnGarage.checked ? 20 : 19
                group: groupScene
            }

            KissButton {
                id: btnStudio

                buttonText: "Studio"
                iconId: btnStudio.checked ? 4 : 21
                group: groupScene

            }

            KissButton {
                id: btnAnimated

                buttonText: "Animated"
                iconId: btnAnimated.checked ? 13 : 1
                group: groupScene

            }

            KissButtonSeparator {
            }

            QtObject {
                id: groupPaint

                property var buttons: [whitePaint, blackPaint, yellowPaint, redPaint]
                property Item checkedButton: blackPaint
            }

            KissButton {
                id: whitePaint

                iconId: 17
                buttonText: "White"
                group: groupPaint

                onClicked: ev_SportsCar_low.stateController = 1
            }

            KissButton {
                id: blackPaint

                iconId: 11
                buttonText: "Black"
                group: groupPaint

                onClicked: ev_SportsCar_low.stateController = 0
            }

            KissButton {
                id: yellowPaint

                iconId: 16
                buttonText: "Yellow"
                group: groupPaint

                onClicked: ev_SportsCar_low.stateController = 2
            }

            KissButton {
                id: redPaint

                iconId: 18
                buttonText: "Red"
                group: groupPaint

                onClicked: ev_SportsCar_low.stateController = 3
            }

            KissButtonSeparator {
            }

            KissButton {
                id: btnLight

                iconId: btnLight.checked ? 15 : 14
                buttonText: "Lights"
                group: "toggle"
                checked: true
            }
        }
    }

    Timeline {
        id: demoAnimation

        animations: [
            TimelineAnimation {
                id: demo
                running: false
                pingPong: false
                loops: -1
                duration: 61114
                to: 61114
                from: 0
            }
        ]
        enabled: true
        startFrame: 0
        endFrame: 61114

        KeyframeGroup {
            target: sceneCamera2
            property: "fieldOfView"
            Keyframe {
                value: 64
                frame: 5
            }

            Keyframe {
                value: 84
                frame: 12005
            }

            Keyframe {
                value: 64
                frame: 12004
            }

            Keyframe {
                value: 64
                frame: 16491
            }

            Keyframe {
                value: 56
                frame: 16492
            }

            Keyframe {
                value: 79.85046
                frame: 21003
            }

            Keyframe {
                value: 22.85
                frame: 21004
            }

            Keyframe {
                value: 15.85
                frame: 34501
            }

            Keyframe {
                value: 51.85
                frame: 46746
            }

            Keyframe {
                value: 15.87412
                frame: 40300
            }

            Keyframe {
                frame: 34500
                value: 15.85881
            }
        }

        KeyframeGroup {
            target: sceneCamera2
            property: "x"
            Keyframe {
                value: -31.82979
                frame: 5
            }

            Keyframe {
                value: 37.88391
                frame: 5979
            }

            Keyframe {
                value: -229.261
                frame: 5979
            }

            Keyframe {
                value: -174.30124
                frame: 12004
            }

            Keyframe {
                value: -31.82972
                frame: 5
            }

            Keyframe {
                value: -337.83273
                frame: 12005
            }

            Keyframe {
                value: -307.71436
                frame: 16491
            }

            Keyframe {
                value: 938.85046
                frame: 16492
            }

            Keyframe {
                value: 550.57489
                frame: 21003
            }

            Keyframe {
                value: -255.06708
                frame: 21004
            }

            Keyframe {
                value: -102.92751
                frame: 28504
            }

            Keyframe {
                value: -634.68378
                frame: 28505
            }

            Keyframe {
                value: -779.27954
                frame: 34500
            }

            Keyframe {
                value: -574.65594
                frame: 34501
            }

            Keyframe {
                value: -566.81525
                frame: 40301
            }

            Keyframe {
                value: 378.97412
                frame: 40302
            }

            Keyframe {
                value: 595.88428
                frame: 46745
            }

            Keyframe {
                value: 649.59082
                frame: 46746
            }

            Keyframe {
                easing.bezierCurve: [0.19, 1, 0.22, 1, 1, 1]
                value: -371.06754
                frame: 61114
            }
        }

        KeyframeGroup {
            target: sceneCamera2
            property: "y"
            Keyframe {
                value: 128.48135
                frame: 5
            }

            Keyframe {
                value: 140.70691
                frame: 5979
            }

            Keyframe {
                value: 161.34668
                frame: 5979
            }

            Keyframe {
                value: 197.42435
                frame: 12004
            }

            Keyframe {
                value: 223.60617
                frame: 5
            }

            Keyframe {
                value: 95.44727
                frame: 12005
            }

            Keyframe {
                value: 152.79813
                frame: 16491
            }

            Keyframe {
                value: 152.798
                frame: 16492
            }

            Keyframe {
                value: 185.36548
                frame: 21003
            }

            Keyframe {
                value: 251.7169
                frame: 21004
            }

            Keyframe {
                value: 359.80371
                frame: 28504
            }

            Keyframe {
                value: 359.80347
                frame: 28505
            }

            Keyframe {
                value: 359.80347
                frame: 34500
            }

            Keyframe {
                value: 222.64905
                frame: 34501
            }

            Keyframe {
                value: 222.64905
                frame: 40301
            }

            Keyframe {
                value: 222.6488
                frame: 40302
            }

            Keyframe {
                value: 222.64883
                frame: 46745
            }

            Keyframe {
                value: 222.64902
                frame: 46746
            }

            Keyframe {
                easing.bezierCurve: [0.19, 1, 0.22, 1, 1, 1]
                value: 147.90091
                frame: 61114
            }
        }

        KeyframeGroup {
            target: sceneCamera2
            property: "z"
            Keyframe {
                value: 224.36035
                frame: 5
            }

            Keyframe {
                value: 218.07159
                frame: 5979
            }

            Keyframe {
                value: -157.46875
                frame: 5979
            }

            Keyframe {
                value: 6.80872
                frame: 12004
            }

            Keyframe {
                value: 665.36609
                frame: 5
            }

            Keyframe {
                value: 149.68378
                frame: 12005
            }

            Keyframe {
                value: 180.37372
                frame: 16491
            }

            Keyframe {
                value: -407.83264
                frame: 16492
            }

            Keyframe {
                value: -282.50183
                frame: 21003
            }

            Keyframe {
                value: 770.57483
                frame: 21004
            }

            Keyframe {
                value: 770.57465
                frame: 28504
            }

            Keyframe {
                value: -622.59058
                frame: 28505
            }

            Keyframe {
                value: -510.37622
                frame: 34500
            }

            Keyframe {
                value: 358.71863
                frame: 34501
            }

            Keyframe {
                value: 438.66461
                frame: 40301
            }

            Keyframe {
                value: -915.28137
                frame: 40302
            }

            Keyframe {
                value: -673.06482
                frame: 46745
            }

            Keyframe {
                value: 223.57843
                frame: 46746
            }

            Keyframe {
                easing.bezierCurve: [0.19, 1, 0.22, 1, 1, 1]
                value: 506.23959
                frame: 61114
            }
        }

        KeyframeGroup {
            target: sceneCamera2
            property: "eulerRotation.x"
            Keyframe {
                value: -12.17219
                frame: 5
            }

            Keyframe {
                value: -11.9523
                frame: 5979
            }

            Keyframe {
                value: -13.40152
                frame: 5979
            }

            Keyframe {
                value: -32.41507
                frame: 12004
            }

            Keyframe {
                value: -13.89176
                frame: 12005
            }

            Keyframe {
                value: -13.89176
                frame: 16491
            }

            Keyframe {
                value: -6.35897
                frame: 16492
            }

            Keyframe {
                value: -10.07228
                frame: 21003
            }

            Keyframe {
                value: -16.93475
                frame: 21004
            }

            Keyframe {
                value: -17.91578
                frame: 28504
            }

            Keyframe {
                value: -17.91577
                frame: 28505
            }

            Keyframe {
                value: -17.95313
                frame: 34500
            }

            Keyframe {
                value: -17.95315
                frame: 34501
            }

            Keyframe {
                value: -17.95315
                frame: 40301
            }

            Keyframe {
                value: -6.10891
                frame: 40302
            }

            Keyframe {
                value: -6.10891
                frame: 46745
            }

            Keyframe {
                value: -6.10892
                frame: 46746
            }

            Keyframe {
                easing.bezierCurve: [0.19, 1, 0.22, 1, 1, 1]
                value: -6.10892
                frame: 61114
            }
        }

        KeyframeGroup {
            target: sceneCamera2
            property: "eulerRotation.y"
            Keyframe {
                value: 0
                frame: 5
            }

            Keyframe {
                value: 11.06957
                frame: 5979
            }

            Keyframe {
                value: -117.02943
                frame: 5979
            }

            Keyframe {
                value: -74.9571
                frame: 12004
            }

            Keyframe {
                value: -77.58958
                frame: 12005
            }

            Keyframe {
                value: -68.8636
                frame: 16491
            }

            Keyframe {
                value: 110.72486
                frame: 16492
            }

            Keyframe {
                value: 114.77937
                frame: 21003
            }

            Keyframe {
                value: -10.47536
                frame: 21004
            }

            Keyframe {
                value: -10.28948
                frame: 28504
            }

            Keyframe {
                value: -129.832
                frame: 28505
            }

            Keyframe {
                value: -128.30945
                frame: 34500
            }

            Keyframe {
                value: -60.4214
                frame: 34501
            }

            Keyframe {
                value: -59.90898
                frame: 40301
            }

            Keyframe {
                value: 161.23984
                frame: 40302
            }

            Keyframe {
                value: 141.07248
                frame: 46745
            }

            Keyframe {
                value: 82.73631
                frame: 46746
            }

            Keyframe {
                easing.bezierCurve: [0.19, 1, 0.22, 1, 1, 1]
                value: -36.03967
                frame: 61114
            }
        }

        KeyframeGroup {
            target: sceneCamera2
            property: "eulerRotation.z"
            Keyframe {
                value: -0
                frame: 5
            }

            Keyframe {
                value: -2.32017
                frame: 5979
            }

            Keyframe {
                value: 0
                frame: 5979
            }

            Keyframe {
                value: 1.92757
                frame: 12004
            }

            Keyframe {
                value: 0
                frame: 12005
            }

            Keyframe {
                value: 0
                frame: 16491
            }

            Keyframe {
                value: -0.00002
                frame: 16492
            }

            Keyframe {
                value: -0.15695
                frame: 21003
            }

            Keyframe {
                value: -0.55012
                frame: 21004
            }

            Keyframe {
                value: -1.1708
                frame: 28504
            }

            Keyframe {
                value: -1.1708
                frame: 28505
            }

            Keyframe {
                value: -3.75297
                frame: 34500
            }

            Keyframe {
                value: -3.75297
                frame: 34501
            }

            Keyframe {
                value: -3.75297
                frame: 40301
            }

            Keyframe {
                value: 0
                frame: 40302
            }

            Keyframe {
                value: -0
                frame: 46745
            }

            Keyframe {
                value: -0.00001
                frame: 46746
            }

            Keyframe {
                easing.bezierCurve: [0.19, 1, 0.22, 1, 1, 1]
                value: -0
                frame: 61114
            }
        }

        KeyframeGroup {
            target: cameraRoot
            property: "eulerRotation.y"

            Keyframe {
                value: 0
                frame: 5
            }
        }

        KeyframeGroup {
            target: cameraRoot
            property: "eulerRotation.x"

            Keyframe {
                value: 0
                frame: 5
            }
        }

        KeyframeGroup {
            target: cameraRoot
            property: "eulerRotation.z"

            Keyframe {
                value: 0
                frame: 5
            }
        }
    }

    Timeline {
        id: demoEnding
        animations: [
            TimelineAnimation {
                id: demoEndAnimation
                running: !btnDemo.checked
                loops: 1
                duration: 2000
                to: 2000
                from: 0
            }
        ]
        enabled: false
        endFrame: 2000
        startFrame: 0

        KeyframeGroup {
            target: sceneCamera2
            property: "x"
            Keyframe {
                value: sceneCamera2.x
                frame: 0
            }

            Keyframe {
                value: -29.83084
                frame: 2000
            }
        }

        KeyframeGroup {
            target: sceneCamera2
            property: "z"
            Keyframe {
                value: sceneCamera2.z
                frame: 0
            }

            Keyframe {
                value: 622.0304
                frame: 2000
            }
        }

        KeyframeGroup {
            target: sceneCamera2
            property: "y"
            Keyframe {
                value: sceneCamera2.y
                frame: 0
            }

            Keyframe {
                value: 188.52927
                frame: 2000
            }
        }

        KeyframeGroup {
            target: sceneCamera2
            property: "eulerRotation.x"
            Keyframe {
                value: sceneCamera2.eulerRotation.x
                frame: 0
            }

            Keyframe {
                value: -12.07
                frame: 2000
            }
        }

        KeyframeGroup {
            target: sceneCamera2
            property: "eulerRotation.y"
            Keyframe {
                value: sceneCamera2.eulerRotation.y
                frame: 0
            }

            Keyframe {
                value: 0
                frame: 2000
            }
        }

        KeyframeGroup {
            target: sceneCamera2
            property: "eulerRotation.z"
            Keyframe {
                value: sceneCamera2.eulerRotation.z
                frame: 0
            }

            Keyframe {
                value: 0
                frame: 2000
            }
        }
    }

    states: [
        State {
            name: "State1"

            when: btnDesert.checked

            PropertyChanges {
                target: view3D
                environment: desert
            }

            PropertyChanges {
                target: lightDirectional
                color: "#c5cbc4"
                brightness: 1
                ambientColor: "#385667"
                eulerRotation.z: -179.99934
                eulerRotation.y: 179.99934
                eulerRotation.x: -88.85005
            }

            PropertyChanges {
                target: lightDirectional1
                color: "#c8e2f5"
                brightness: 1
                ambientColor: "#223843"
                eulerRotation.z: -0.00001
                eulerRotation.y: 0.00001
                eulerRotation.x: -42.00026
            }

            PropertyChanges {
                target: desertGround
                x: 0
                y: 1
                visible: true
                z: 0
                eulerRotation.z: 0
                eulerRotation.y: 0
                eulerRotation.x: 0
            }

            PropertyChanges {
                target: garageFloor
                visible: false
            }

            PropertyChanges {
                target: uk5ofde_LOD0
                x: 117.9
                y: -52.252
                visible: true
                eulerRotation.z: -0
                eulerRotation.y: 11.50532
                eulerRotation.x: 0
                z: -24.19652
            }

            PropertyChanges {
                target: uk5pebv_LOD0
                x: -0
                y: -69.778
                visible: true
                eulerRotation.z: -0
                eulerRotation.y: 0
                eulerRotation.x: -11.28177
                z: 125.24512
            }

            PropertyChanges {
                target: ulbrbdt_LOD0
                x: -36.694
                y: -70.351
                visible: true
                eulerRotation.z: 20.75727
                eulerRotation.y: 107.97124
                eulerRotation.x: -20.11145
                z: -121.36554
                scale.z: 0.1
                scale.y: 0.15
                scale.x: 0.1
            }

            PropertyChanges {
                target: ventdee_LOD0
                x: -123.265
                y: -86.877
                visible: true
                scale.z: 1
                scale.y: 1.5
                scale.x: 0.62114
                eulerRotation.z: 0
                eulerRotation.x: -10.07419
                z: 47.0688
                eulerRotation.y: -69.7391
            }


            PropertyChanges {
                target: desert
                lensFlareApplyStarburstTexture: false
                lensFlareGhostCount: 0
                lensFlareBloomBias: 1.41332
                lensFlareEnabled: false
                vignetteEnabled: false
                glowBlendMode: ExtendedSceneEnvironment.GlowBlendMode.Screen
                glowHDRScale: 2.36038
                glowQualityHigh: true
                glowHDRMaximumValue: 13
                glowStrength: 0.40564
                glowIntensity: 2
                glowHDRMinimumValue: 0
                glowLevel: ExtendedSceneEnvironment.GlowLevel.One | ExtendedSceneEnvironment.GlowLevel.Two | ExtendedSceneEnvironment.GlowLevel.Three
                glowBloom: 1
                glowEnabled: true
                aoEnabled: false
                probeExposure: 1.5
            }

            PropertyChanges {
                target: plane3
                x: -8.062
                y: 2
                opacity: 1
                visible: true
                receivesShadows: true
                castsReflections: false
                levelOfDetailBias: 0
                depthBias: 500
            }

            PropertyChanges {
                target: groundMat1
                opacity: 0.815
                cullMode: Material.NoCulling
                blendMode: PrincipledMaterial.SourceOver
                vertexColorsEnabled: false
                depthDrawMode: Material.AlwaysDepthDraw
            }

            PropertyChanges {
                target: headlights
                opacity: 0.316
            }

            PropertyChanges {
                target: lightPoint1
                visible: btnLight.checked
            }
        },
        State {
            name: "State2"
            when: btnStudio.checked

            PropertyChanges {
                target: reflectionProbe1
                quality: ReflectionProbe.Low
                timeSlicing: ReflectionProbe.AllFacesAtOnce
                boxSize.z: 7500
                boxSize.y: 400
                boxSize.x: 7500
                parallaxCorrection: true
            }
            PropertyChanges {
                target: lightDirectional
                visible: true
                ambientColor: "#3c3c3c"
                brightness: 0.5
                eulerRotation.z: 180
                eulerRotation.y: -180
                eulerRotation.x: -6.93953
            }

            PropertyChanges {
                target: lightDirectional1
                visible: true
                ambientColor: "#282828"
                brightness: 1
                eulerRotation.z: -0.00001
                eulerRotation.y: 0
                eulerRotation.x: -6.62763
            }

            PropertyChanges {
                target: garageFloor
                visible: false
            }

            PropertyChanges {
                target: studioFloor
                visible: true
                eulerRotation.z: 0
                castsShadows: false
            }

            PropertyChanges {
                target: view3D
                environment: studio
            }

            PropertyChanges {
                target: studio
                probeExposure: 1
                backgroundMode: SceneEnvironment.Color
            }

            PropertyChanges {
                target: sceneObjects1
                y: -199
                z: 0
            }

            PropertyChanges {
                target: rectMaterial2
                roughness: 0.18541
                normalStrength: 0.5
            }

            PropertyChanges {
                target: groundMat1
                opacity: 0.91
            }

            PropertyChanges {
                target: plane3
                x: -15.512
                y: 4.739
                z: 10.0102
            }



        },
        State {
            name: "State3"
            when: btnAnimated.checked

            PropertyChanges {
                target: plane2
                visible: true
                y: 500
                z: -750
            }

            PropertyChanges {
                target: view3D
                environment: videoRoom
            }

            PropertyChanges {
                target: lightDirectional1
                ambientColor: "#2b2b2b"
                brightness: 1
                eulerRotation.z: -0.00001
                eulerRotation.y: 0.00001
                eulerRotation.x: -45.75426
            }

            PropertyChanges {
                target: lightDirectional
                ambientColor: "#262626"
                brightness: 0.3
                eulerRotation.z: 179.99997
                eulerRotation.y: -179.99997
                eulerRotation.x: -84.03297
            }

            PropertyChanges {
                target: showhall
                aoBias: 22
            }

            PropertyChanges {
                target: videoControls
                visible: true
            }

            PropertyChanges {
                target: garageFloor
                visible: false
            }

            PropertyChanges {
                target: animatedstateFloor
                x: -0
                y: 0
                visible: true
                castsReflections: true
                receivesReflections: true
                scale.y: 30
                scale.x: 200
                z: 750
            }

            PropertyChanges {
                target: studioFloor
                visible: false
                materials: rectMaterial2
            }

            PropertyChanges {
                target: reflectionProbe1
                parallaxCorrection: true
                timeSlicing: ReflectionProbe.AllFacesAtOnce
                refreshMode: ReflectionProbe.EveryFrame
                quality: ReflectionProbe.Low
                boxSize.z: 3000
                boxSize.x: 3000
                boxSize.y: 1000
            }

            PropertyChanges {
                target: rectMaterial2
                specularAmount: 0.25
                clearcoatAmount: 0
                roughness: 0.4
            }

            PropertyChanges {
                target: principledMaterial2
                baseColor: "#ffffff"
                roughness: 1
            }

            PropertyChanges {
                target: sceneObjects1
                z: -750
            }

            PropertyChanges {
                target: vlkhcah_2K_Albedo1
                scaleU: 20
            }

            PropertyChanges {
                target: vlkhcah_2K_AO1
                scaleU: 20
            }

            PropertyChanges {
                target: vlkhcah_2K_Normal1
                scaleU: 20
            }

            PropertyChanges {
                target: vlkhcah_2K_Roughness1
                scaleU: 20
            }

            PropertyChanges {
                target: rectMaterial4
                clearcoatRoughnessAmount: 0
                roughnessChannel: Material.G
                roughness: 0.5
                metalness: 0
                normalStrength: 0.5
            }

            PropertyChanges {
                target: groundMat1
                opacity: 0.939
            }
        }
    ]
}
