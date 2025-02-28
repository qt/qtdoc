// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause
import QtQuick
import QtQuick3D
import QtQuick3D.Physics
import QtMultimedia

Node {
    id: shapeSpawner

    required property PhysicsMaterial physicsMaterial
    property int count: 0
    property double diceWidth: 3.5
    property vector3d rollForce: Qt.vector3d(0, 0, 0)

    onCountChanged: respawn()

    Repeater3D {
        id: repeater

        model: new Array(shapeSpawner.count).fill({
                                                      "ts": new Date().valueOf()
                                                  })

        delegate: PhysicalDie {
            position.x: { position.x = diceWidth * Math.cos(index / (Math.PI / 4)) }
            position.y: { position.y = index * shapeSpawner.diceWidth * 1.41 }
            position.z: { position.z =  diceWidth * Math.sin(index / (Math.PI / 4)) }
            eulerRotation.x: randomInRange(0, 360)
            eulerRotation.y: randomInRange(0, 360)
            eulerRotation.z: randomInRange(0, 360)
            physicsMaterial: shapeSpawner.physicsMaterial
            diceWidth: shapeSpawner.diceWidth

            Component.onCompleted: applyCentralForce(shapeSpawner.rollForce)
        }
    }

    SoundEffect {
        id: rollSound
        loops: 0
        source: "sounds/rolling.wav"
    }

    function respawn() {
        repeater.model = new Array(shapeSpawner.count).fill({
                                                                "ts": new Date().valueOf()
                                                            })
        rollSound.stop()
        rollSound.play()
    }

    function randomInRange(min, max) {
        return Math.random() * (max - min) + min
    }
}
