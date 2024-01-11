// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Window
import QtQuick3D
import QtQuick3D.Helpers
import Example

Window {
    width: 1024
    height: 768
    visible: true
    title: qsTr("OSM Buildings")

    OSMManager {
        id: osmManager

        onBuildingsDataReady: function( geoVariantsList, tileX, tileY, zoomLevel ){
            buildingModels.addModel(geoVariantsList, tileX, tileY, zoomLevel)
        }

        onMapsDataReady: function( mapData, tileX, tileY, zoomLevel ){
            mapModels.addModel(mapData, tileX, tileY, zoomLevel)
        }
    }

    Component {
        id: chunkModelBuilding
        Node {
            property variant geoVariantsList: null
            property int tileX: 0
            property int tileY: 0
            property int zoomLevel: 0
            Model {
                id: model
                scale: Qt.vector3d(1, 1, 1)

                OSMGeometry {
                    id: osmGeometry
                    Component.onCompleted: updateData( geoVariantsList )
                    onGeometryReady:{
                        model.geometry = osmGeometry
                    }
                }
                materials: [

                    CustomMaterial {
                        shadingMode: CustomMaterial.Shaded
                        cullMode: Material.BackFaceCulling
                        vertexShader: "customshaderbuildings.vert"
                        fragmentShader: "customshaderbuildings.frag"
                    }
                ]
            }
        }
    }

    Component {
        id: chunkModelMap
        Node {
            property variant mapData: null
            property int tileX: 0
            property int tileY: 0
            property int zoomLevel: 0
            Model {
                id: basePlane
                position: Qt.vector3d( osmManager.tileSizeX * tileX, osmManager.tileSizeY * -tileY, 0.0 )
                scale: Qt.vector3d( osmManager.tileSizeX / 100., osmManager.tileSizeY / 100., 0.5)
                source: "#Rectangle"
                materials: [
                    CustomMaterial {
                        property TextureInput tileTexture: TextureInput {
                            enabled: true
                            texture: Texture {
                                textureData: CustomTextureData {
                                    Component.onCompleted: setImageData( mapData )
                                } }
                        }
                        shadingMode: CustomMaterial.Shaded
                        cullMode: Material.BackFaceCulling
                        fragmentShader: "customshadertiles.frag"
                    }
                ]
            }
        }
    }


    View3D {
        id: v3d
        anchors.fill: parent

        environment: ExtendedSceneEnvironment {
            id: env
            backgroundMode: SceneEnvironment.Color
            clearColor: "#8099b3"
            fxaaEnabled: true
            fog: Fog {
                id: theFog
                color:"#8099b3"
                enabled: true
                depthEnabled: true
                depthFar: 600
            }
        }

        Node {
            id: originNode
            eulerRotation: Qt.vector3d(50.0, 0.0, 0.0)
            PerspectiveCamera {
                id: cameraNode
                frustumCullingEnabled: true
                clipFar: 600
                clipNear: 100
                fieldOfView: 90
                z: 100

                onZChanged: originNode.updateManagerCamera()

            }
            Component.onCompleted: updateManagerCamera()

            onPositionChanged: updateManagerCamera()

            onRotationChanged: updateManagerCamera()

            function updateManagerCamera(){
                osmManager.setCameraProperties( originNode.position,
                                               originNode.right, cameraNode.z,
                                               cameraController.minimumZoom,
                                               cameraController.maximumZoom,
                                               originNode.eulerRotation.x,
                                               cameraController.minimumTilt,
                                               cameraController.maximumTilt )
            }
        }

        DirectionalLight {
            color: Qt.rgba(1.0, 1.0, 0.95, 1.0)
            ambientColor: Qt.rgba(0.5, 0.45, 0.45, 1.0)
            rotation: Quaternion.fromEulerAngles(-10, -45, 0)
        }

        Node {
            id: buildingModels

            function addModel(geoVariantsList, tileX, tileY, zoomLevel)
            {
                chunkModelBuilding.createObject( buildingModels, {
                                                    "geoVariantsList": geoVariantsList,
                                                    "tileX": tileX,
                                                    "tileY": tileY,
                                                    "zoomLevel": zoomLevel
                                                } )
            }
        }

        Node {
            id: mapModels

            function addModel(mapData, tileX, tileY, zoomLevel)
            {
                chunkModelMap.createObject( mapModels, { "mapData": mapData,
                                               "tileX": tileX,
                                               "tileY": tileY,
                                               "zoomLevel": zoomLevel
                                           } )
            }
        }

        OSMCameraController {
            id: cameraController
            origin: originNode
            camera: cameraNode
        }
    }

}
