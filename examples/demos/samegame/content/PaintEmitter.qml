// Copyright (C) 2017 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Particles
import "."

Emitter {
    property Item block: parent
    anchors.fill: parent
    shape: EllipseShape { fill: true }
    group: {
        if (block.type == 0){
            "redspots";
        } else if (block.type == 1) {
            "bluespots";
        } else if (block.type == 2) {
            "greenspots";
        } else {
            "yellowspots";
        }
    }
    size: Settings.blockSize * 2
    endSize: Settings.blockSize/2
    lifeSpan: 30000
    enabled: false
    emitRate: 60
    maximumEmitted: 60
    velocity: PointDirection{ y: 4; yVariation: 4 }
    /* Possibly better, but dependent on gerrit change,28212
    property real mainIntensity: 0.8
    property real subIntensity: 0.1
    property real colorVariation: 0.005
    onEmitParticles: {//One group, many colors, for better stacking
        for (var i=0; i<particles.length; i++) {
            var particle = particles[i];
            if (block.type == 0) {
                particle.red = mainIntensity + (Math.random() * colorVariation * 2 - colorVariation);
                particle.green = subIntensity + (Math.random() * colorVariation * 2 - colorVariation);
                particle.blue = subIntensity + (Math.random() * colorVariation * 2 - colorVariation);
            } else if (block.type == 1) {
                particle.red = subIntensity + (Math.random() * colorVariation * 2 - colorVariation);
                particle.green = subIntensity + (Math.random() * colorVariation * 2 - colorVariation);
                particle.blue = mainIntensity + (Math.random() * colorVariation * 2 - colorVariation);
            } else if (block.type == 2) {
                particle.red = subIntensity + (Math.random() * colorVariation * 2 - colorVariation);
                particle.green = mainIntensity + (Math.random() * colorVariation * 2 - colorVariation);
                particle.blue = subIntensity + (Math.random() * colorVariation * 2 - colorVariation);
            } else if (block.type == 3) {
                particle.red = mainIntensity + (Math.random() * colorVariation * 2 - colorVariation);
                particle.green = mainIntensity + (Math.random() * colorVariation * 2 - colorVariation);
                particle.blue = subIntensity + (Math.random() * colorVariation * 2 - colorVariation);
            } else {
                particle.red = mainIntensity + (Math.random() * colorVariation * 2 - colorVariation);
                particle.green = mainIntensity + (Math.random() * colorVariation * 2 - colorVariation);
                particle.blue = mainIntensity + (Math.random() * colorVariation * 2 - colorVariation);
            }
        }
    }
    */
}
