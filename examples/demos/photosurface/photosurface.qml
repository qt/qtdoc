// Copyright (C) 2017 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause
import QtQuick
import QtQuick.Window
import Qt.labs.folderlistmodel
import Qt.labs.platform

Window {
    id: root
    visible: true
    width: 1024; height: 600
    color: "black"
    property int highestZ: 0
    property real defaultSize: 200
    property var currentFrame: undefined
    property real surfaceViewportRatio: 1.5

    FolderDialog {
        id: folderDialog
        title: "Choose a folder with some images"
        folder: picturesLocation
        onAccepted: folderModel.folder = folder + "/"
    }

    Flickable {
        id: flick
        anchors.fill: parent
        contentWidth: width * surfaceViewportRatio
        contentHeight: height * surfaceViewportRatio
        Repeater {
            model: FolderListModel {
                id: folderModel
                objectName: "folderModel"
                showDirs: false
                nameFilters: imageNameFilters
            }
            Rectangle {
                id: photoFrame
                width: image.width * (1 + 0.10 * image.height / image.width)
                height: image.height * 1.10
                scale: defaultSize / Math.max(image.sourceSize.width, image.sourceSize.height)
                Behavior on scale { NumberAnimation { duration: 200 } }
                Behavior on x { NumberAnimation { duration: 200 } }
                Behavior on y { NumberAnimation { duration: 200 } }
                border.color: "black"
                border.width: 2
                smooth: true
                antialiasing: true
                Component.onCompleted: {
                    x = Math.random() * root.width - width / 2
                    y = Math.random() * root.height - height / 2
                    rotation = Math.random() * 13 - 6
                }
                Image {
                    id: image
                    anchors.centerIn: parent
                    fillMode: Image.PreserveAspectFit
                    source: folderModel.folder + fileName
                    antialiasing: true
                }
                PinchArea {
                    anchors.fill: parent
                    pinch.target: photoFrame
                    pinch.minimumRotation: -360
                    pinch.maximumRotation: 360
                    pinch.minimumScale: 0.1
                    pinch.maximumScale: 10
                    pinch.dragAxis: Pinch.XAndYAxis
                    onPinchStarted: setFrameColor();
                    property real zRestore: 0
                    onSmartZoom: {
                        if (pinch.scale > 0) {
                            photoFrame.rotation = 0;
                            photoFrame.scale = Math.min(root.width, root.height) / Math.max(image.sourceSize.width, image.sourceSize.height) * 0.85
                            photoFrame.x = flick.contentX + (flick.width - photoFrame.width) / 2
                            photoFrame.y = flick.contentY + (flick.height - photoFrame.height) / 2
                            zRestore = photoFrame.z
                            photoFrame.z = ++root.highestZ;
                        } else {
                            photoFrame.rotation = pinch.previousAngle
                            photoFrame.scale = pinch.previousScale
                            photoFrame.x = pinch.previousCenter.x - photoFrame.width / 2
                            photoFrame.y = pinch.previousCenter.y - photoFrame.height / 2
                            photoFrame.z = zRestore
                            --root.highestZ
                        }
                    }

                    MouseArea {
                        id: dragArea
                        hoverEnabled: true
                        anchors.fill: parent
                        drag.target: photoFrame
                        scrollGestureEnabled: false  // 2-finger-flick gesture should pass through to the Flickable
                        onPressed: {
                            photoFrame.z = ++root.highestZ;
                            parent.setFrameColor();
                        }
                        onEntered: parent.setFrameColor();
                        onWheel: {
                            if (wheel.modifiers & Qt.ControlModifier) {
                                photoFrame.rotation += wheel.angleDelta.y / 120 * 5;
                                if (Math.abs(photoFrame.rotation) < 4)
                                    photoFrame.rotation = 0;
                            } else {
                                photoFrame.rotation += wheel.angleDelta.x / 120;
                                if (Math.abs(photoFrame.rotation) < 0.6)
                                    photoFrame.rotation = 0;
                                var scaleBefore = photoFrame.scale;
                                photoFrame.scale += photoFrame.scale * wheel.angleDelta.y / 120 / 10;
                            }
                        }
                    }
                    function setFrameColor() {
                        if (currentFrame)
                            currentFrame.border.color = "black";
                        currentFrame = photoFrame;
                        currentFrame.border.color = "red";
                    }
                }
            }
        }
    }

    Rectangle {
        id: verticalScrollDecorator
        anchors.right: parent.right
        anchors.margins: 2
        color: "cyan"
        border.color: "black"
        border.width: 1
        width: 5
        radius: 2
        antialiasing: true
        height: flick.height * (flick.height / flick.contentHeight) - (width - anchors.margins) * 2
        y: (flick.contentY - flick.originY) * (flick.height / flick.contentHeight)
        NumberAnimation on opacity { id: vfade; to: 0; duration: 500 }
        onYChanged: { opacity = 1.0; scrollFadeTimer.restart() }
    }

    Rectangle {
        id: horizontalScrollDecorator
        anchors.bottom: parent.bottom
        anchors.margins: 2
        color: "cyan"
        border.color: "black"
        border.width: 1
        height: 5
        radius: 2
        antialiasing: true
        width: flick.width * (flick.width / flick.contentWidth) - (height - anchors.margins) * 2
        x: (flick.contentX - flick.originY) * (flick.width / flick.contentWidth)
        NumberAnimation on opacity { id: hfade; to: 0; duration: 500 }
        onXChanged: { opacity = 1.0; scrollFadeTimer.restart() }
    }

    Timer { id: scrollFadeTimer; interval: 1000; onTriggered: { hfade.start(); vfade.start() } }

    Image {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 10
        source: "resources/folder.png"
        MouseArea {
            anchors.fill: parent
            anchors.margins: -10
            onClicked: folderDialog.open()
            hoverEnabled: true
            onPositionChanged: {
                tooltip.visible = false
                hoverTimer.start()
            }
            onExited: {
                tooltip.visible = false
                hoverTimer.stop()
            }
            Timer {
                id: hoverTimer
                interval: 1000
                onTriggered: {
                    tooltip.x = parent.mouseX
                    tooltip.y = parent.mouseY
                    tooltip.visible = true
                }
            }
            Rectangle {
                id: tooltip
                border.color: "black"
                color: "beige"
                width: tooltipText.implicitWidth + 8
                height: tooltipText.implicitHeight + 8
                visible: false
                Text {
                    id: tooltipText
                    anchors.centerIn: parent
                    text: "Open an image directory (" + openShortcut.sequenceString + ")"
                }
            }
        }
        Shortcut {
            id: openShortcut
            sequence: StandardKey.Open
            onActivated: folderDialog.open()
        }
    }

    Text {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 10
        color: "darkgrey"
        wrapMode: Text.WordWrap
        font.pointSize: 8
        text: "On a touchscreen: use two fingers to zoom and rotate, one finger to drag\n" +
              "With a mouse: drag normally, use the vertical wheel to zoom, horizontal wheel to rotate, or hold Ctrl while using the vertical wheel to rotate"
    }

    Shortcut { sequence: StandardKey.Quit; onActivated: Qt.quit() }

    Component.onCompleted: {
        if (typeof contextInitialUrl !== 'undefined') {
            // Launched from C++ with context properties set.
            imageNameFilters = contextImageNameFilters;
            picturesLocation = contextPicturesLocation;
            if (contextInitialUrl == "")
                folderDialog.open();
            else
                folderModel.folder = contextInitialUrl + "/";
        } else {
            // Launched via QML viewer without context properties set.
            folderDialog.open();
        }
    }

    property var imageNameFilters : ["*.png", "*.jpg", "*.gif"];
    property string picturesLocation : "";
}
