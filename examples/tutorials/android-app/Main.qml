// Copyright (C) 2026 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

//! [create-image-0]
import QtQuick
import QtQuick.Controls.Material
//! [create-image-0]
//! [import-sensors]
import QtSensors
//! [import-sensors]
//! [create-image-1]
//! [accelerometer-1]

ApplicationWindow {
    id: mainWindow
//! [accelerometer-1]
    width: 320
    height: 480
    visible: true
    title: qsTr("Accelerate Bubble")
//! [create-image-1]
    readonly property double radians_to_degrees: 180 / Math.PI

//! [create-image-2]
    Image {
        id: bubble
        source: "Bluebubble.svg"
        smooth: true
//! [create-image-2]
//! [create-image-3]
        property real centerX: mainWindow.contentItem.width / 2
        property real centerY: mainWindow.contentItem.height / 2
        property real bubbleCenter: bubble.width / 2
        x: centerX - bubbleCenter
        y: centerY - bubbleCenter
//! [create-image-3]

//! [smoothed-animation]
        Behavior on y {
            SmoothedAnimation {
                easing.type: Easing.Linear
                duration: 100
            }
        }
        Behavior on x {
            SmoothedAnimation {
                easing.type: Easing.Linear
                duration: 100
            }
        }
//! [smoothed-animation]
//! [create-image-4]
    }

//! [create-image-4]


//! [calc-functions]
    function calcPitch(x,y,z) {
        return -Math.atan2(y, Math.hypot(x, z)) * mainWindow.radians_to_degrees;
    }
    function calcRoll(x,y,z) {
        return -Math.atan2(x, Math.hypot(y, z)) * mainWindow.radians_to_degrees;
    }
//! [calc-functions]
//! [accelerometer-2]
//! [accelerometer-3]
    Accelerometer {
        id: accel
//! [accelerometer-3]
        dataRate: 100
        active: true
//! [accelerometer-2]
//! [on-reading-changed]

        onReadingChanged: {
            var newX = (bubble.x + calcRoll(accel.reading.x, accel.reading.y, accel.reading.z) * .1)
            var newY = (bubble.y - calcPitch(accel.reading.x, accel.reading.y, accel.reading.z) * .1)

            if (isNaN(newX) || isNaN(newY))
                return;

            if (newX < 0)
                newX = 0

            if (newX > mainWindow.contentItem.width - bubble.width)
                newX = mainWindow.contentItem.width - bubble.width

            if (newY < 0)
                newY = 0

            if (newY > mainWindow.contentItem.height - bubble.height)
                newY = mainWindow.contentItem.height - bubble.height

            bubble.x = newX
            bubble.y = newY
        }
//! [on-reading-changed]
//! [accelerometer-4]
    }
//! [accelerometer-4]
//! [create-image-5]
}
//! [create-image-5]
