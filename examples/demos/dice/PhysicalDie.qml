// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause
import QtQuick3D
import QtQuick3D.Physics
import QtMultimedia
import QtQml

DynamicRigidBody {
    property real diceWidth: 1.9 // cm
    property bool atRest: true
    receiveContactReports: true
    sendContactReports: true
    onBodyContact: {
        motionTimeout.start()
        atRest = false
        let volume = 0
        impulses.forEach(vector => {
                             volume += vector.length()
                         })
        diceSound.volume = volume / 2000
        if (!diceSound.playing)
            diceSound.play()
    }
    Timer {
        id: motionTimeout
        interval: 500
        running: false
        repeat: false
        onRunningChanged: {
            if (!running)
                atRest = true
        }
    }

    massMode: DynamicRigidBody.CustomDensity
    density: 1.13
    collisionShapes: BoxShape {
        id: box
        extents: Qt.vector3d(1, 1, 1).times(diceWidth)
    }
    Dice_low {
        scale: Qt.vector3d(2.65, 2.65, 2.65).times(diceWidth)
    }
    SoundEffect {
        id: diceSound
        loops: 0
        source: "sounds/onedice.wav"
    }
}
