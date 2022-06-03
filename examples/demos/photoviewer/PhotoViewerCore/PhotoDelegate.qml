// Copyright (C) 2016 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import "script/script.mjs" as Script

Package {
    Item { id: stackItem; Package.name: 'stack'; width: 160; height: 153; z: stackItem.PathView.z }
    Item { id: listItem; Package.name: 'list'; width: mainWindow.width + 40; height: 153 }
    Item { id: gridItem; Package.name: 'grid'; width: 160; height: 153 }

    Item {
        width: 160; height: 153

        Item {
            id: photoWrapper

            property double randomAngle: Math.random() * (2 * 6 + 1) - 6
            property double randomAngle2: Math.random() * (2 * 6 + 1) - 6

            x: 0; y: 0; width: 140; height: 133
            z: stackItem.PathView.z; rotation: photoWrapper.randomAngle

            BorderImage {
                anchors {
                    fill: originalImage.status == Image.Ready ? border : placeHolder
                    leftMargin: -6; topMargin: -6; rightMargin: -8; bottomMargin: -8
                }
                source: 'images/box-shadow.png'
                border.left: 10; border.top: 10; border.right: 10; border.bottom: 10
            }
            Rectangle {
                id: placeHolder

                property int w: 400
                property int h: 400
                property double s: Script.calculateScale(w, h, photoWrapper.width)

                color: 'white'; anchors.centerIn: parent; antialiasing: true
                width:  w * s; height: h * s; visible: originalImage.status != Image.Ready
                Rectangle {
                    color: "#878787"; antialiasing: true
                    anchors { fill: parent; topMargin: 3; bottomMargin: 3; leftMargin: 3; rightMargin: 3 }
                }
            }
            Rectangle {
                id: border; color: 'white'; anchors.centerIn: parent; antialiasing: true
                width: originalImage.paintedWidth + 6; height: originalImage.paintedHeight + 6
                visible: !placeHolder.visible
            }
            BusyIndicator { anchors.centerIn: parent; on: originalImage.status != Image.Ready }
            Image {
                id: originalImage; antialiasing: true;
                source: link; cache: false
                fillMode: Image.PreserveAspectFit; width: photoWrapper.width; height: photoWrapper.height
            }
            Image {
                id: hqImage; antialiasing: true; source: ""; visible: false; cache: false
                fillMode: Image.PreserveAspectFit; width: photoWrapper.width; height: photoWrapper.height
            }
            Binding {
                target: mainWindow; property: "downloadProgress"; value: hqImage.progress
                when: listItem.ListView.isCurrentItem
            }
            Binding {
                target: mainWindow; property: "imageLoading"
                value: (hqImage.status == Image.Loading) ? 1 : 0; when: listItem.ListView.isCurrentItem
            }
            MouseArea {
                width: originalImage.paintedWidth; height: originalImage.paintedHeight; anchors.centerIn: originalImage
                onClicked: {
                    if (albumWrapper.state == 'inGrid') {
                        gridItem.GridView.view.currentIndex = index;
                        albumWrapper.state = 'fullscreen'
                    } else {
                        gridItem.GridView.view.currentIndex = index;
                        albumWrapper.state = 'inGrid'
                    }
                }
            }

            states: [
            State {
                name: 'stacked'; when: albumWrapper.state == ''
                ParentChange { target: photoWrapper; parent: stackItem; x: 10; y: 10 }
                PropertyChanges { target: photoWrapper; opacity: stackItem.PathView.onPath ? 1.0 : 0.0 }
            },
            State {
                name: 'inGrid'; when: albumWrapper.state == 'inGrid'
                ParentChange { target: photoWrapper; parent: gridItem; x: 10; y: 10; rotation: photoWrapper.randomAngle2 }
            },
            State {
                name: 'fullscreen'; when: albumWrapper.state == 'fullscreen'
                ParentChange {
                    target: photoWrapper; parent: listItem; x: 0; y: 0; rotation: 0
                    width: mainWindow.width; height: mainWindow.height
                }
                PropertyChanges { target: border; opacity: 0 }
                PropertyChanges { target: hqImage; source: listItem.ListView.isCurrentItem ? link : ""; visible: true }
            }
            ]

            transitions: [
            Transition {
                from: 'stacked'; to: 'inGrid'
                SequentialAnimation {
                    PauseAnimation { duration: 10 * index }
                    ParentAnimation {
                        target: photoWrapper; via: foreground
                        NumberAnimation {
                            target: photoWrapper; properties: 'x,y,rotation,opacity'; duration: 600; easing.type: 'OutQuart'
                        }
                    }
                }
            },
            Transition {
                from: 'inGrid'; to: 'stacked'
                ParentAnimation {
                    target: photoWrapper; via: foreground
                    NumberAnimation { properties: 'x,y,rotation,opacity'; duration: 600; easing.type: 'OutQuart' }
                }
            },
            Transition {
                from: 'inGrid'; to: 'fullscreen'
                SequentialAnimation {
                    PauseAnimation { duration: gridItem.GridView.isCurrentItem ? 0 : 600 }
                    ParentAnimation {
                        target: photoWrapper; via: foreground
                        NumberAnimation {
                            targets: [ photoWrapper, border ]
                            properties: 'x,y,width,height,opacity,rotation'
                            duration: gridItem.GridView.isCurrentItem ? 600 : 1; easing.type: 'OutQuart'
                        }
                    }
                }
            },
            Transition {
                from: 'fullscreen'; to: 'inGrid'
                ParentAnimation {
                    target: photoWrapper; via: foreground
                    NumberAnimation {
                        targets: [ photoWrapper, border ]
                        properties: 'x,y,width,height,rotation,opacity'
                        duration: gridItem.GridView.isCurrentItem ? 600 : 1; easing.type: 'OutQuart'
                    }
                }
            }
            ]
        }
    }
}
