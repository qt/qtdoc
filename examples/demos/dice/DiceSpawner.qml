// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick3D
import QtQuick3D.Physics
import QtQuick3D.Helpers

Node {
    id: shapeSpawner
    property var dices: []
    property var dieComponent: Qt.createComponent("PhysicalDie.qml")

    function randomInRange(min, max) {
        return Math.random() * (max - min) + min;
    }

    function createDie(position, physicsMaterial) {
        let rotation = Qt.vector3d(randomInRange(0, 360), randomInRange(0, 360),
                                   randomInRange(0, 360));
        let settings = {
            "position": position,
            "eulerRotation": rotation,
            "physicsMaterial": physicsMaterial
        };
        let die = dieComponent.createObject(shapeSpawner, settings);
        dices.push(die);
        if (die === null) {
            console.log("Error creating object");
        }
    }

    function spawnDice(numberOfDice, physicsMaterial) {
        reset();
        let degrees45 = Math.PI / 4;
        for (var index = 0; index < numberOfDice; index++) {
            let initialPosition
                = Qt.vector3d(0.11 * Math.cos(index / degrees45),
                              index * 2.1, 0);
            createDie(initialPosition, physicsMaterial);
        }
    }

    function reset() {
        dices.forEach(die => {
                die.destroy();
            });
        dices = [];
    }
}
