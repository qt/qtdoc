/****************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the documentation of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.0

import "../functions.js" as Functions
import ClusterDemo 1.0

Item {
    property alias speedValue: speedgauge.speedValue
    property alias maxValue: speedgauge.maxValue
    property real outerRadius: Math.min(width, height) * 0.5

    Image {
        id: speedBg
        anchors.centerIn: parent
        source: "image://etc/Gauge_Speed.png"
    }

    ShaderEffect {
        id: speedgauge
        anchors.fill: speedBg

        property real outerRadius: Math.min(width, height) * 0.5
        property int animationDurationSpeed: 500

        property real speedValue: 0
        property int value: startupAnimationStopped ? ValueSource.kph : speedValue
        property int minValue: 0
        property int maxValue: 240
        property int minAngle: 0
        property int maxAngle: 270
        property real valueInDegrees: ((maxAngle - minAngle)
                                       / (maxValue - minValue)) * (value - minValue)

        property double fCRadSpeed: Functions.degToRad(frontCutSpeed - 180.)
        property double bCRadSpeed: Functions.degToRad(backCutSpeed - 180.)

        //Fuel gauge
        property real valueFuel: ValueSource.fuelLevel
        property int minAngleFuel: 324
        property int maxAngleFuel: 288
        property int maxValueFuel: 100
        property int animationDurationFuel: 100
        property color shaderColorFuel: "#464749"
        property real valueInDegreesFuel: ((maxAngleFuel - minAngleFuel)
                                           / (maxValueFuel - minValue)) * (valueFuel - minValue)
        property double _acceleratingFuel: (backCutFuel < frontCutFuel) ? 1. : 0.
        property double frontCutFuel: minAngleFuel + valueInDegreesFuel
        property double backCutFuel: minAngleFuel

        property double fCRadFuel: Functions.degToRad(frontCutFuel - 180.)
        property double bCRadFuel: Functions.degToRad(backCutFuel - 180.)

        //Shader properties
        property double frontCutSpeed: minAngle + valueInDegrees// new speed
        property double backCutSpeed: minAngle //starting point

        // INTERNAL BELOW
        property double _acceleratingSpeed: (backCutSpeed < frontCutSpeed) ? 1. : 0.
        property variant source: speedBg
        property color shaderColorSpeed: "#E31E24"

        Behavior on frontCutSpeed {
            enabled: startupAnimationStopped
            PropertyAnimation { duration: speedgauge.animationDurationSpeed }
        }

        Behavior on frontCutFuel {
            enabled: startupAnimationStopped
            PropertyAnimation { duration: speedgauge.animationDurationFuel }
        }

        fragmentShader: "
                        varying highp vec2 qt_TexCoord0;
                        uniform lowp sampler2D source;
                        uniform lowp float qt_Opacity;
                        lowp vec4 c = vec4(0.,0.,0.,0.);

                        //Speed
                        uniform lowp vec4 shaderColorSpeed;
                        uniform lowp float frontCutSpeed;
                        uniform lowp float backCutSpeed;
                        uniform lowp float _acceleratingSpeed;

                        uniform highp float fCRadSpeed;
                        uniform highp float bCRadSpeed;

                        //Fuel
                        uniform lowp vec4 shaderColorFuel;
                        uniform lowp float frontCutFuel;
                        uniform lowp float backCutFuel;
                        uniform lowp float _acceleratingFuel;

                        uniform highp float fCRadFuel;
                        uniform highp float bCRadFuel;

                        void main() {
                            highp vec2 uv = vec2(.5 - qt_TexCoord0.y, .5 - qt_TexCoord0.x);

                            lowp float L = length(uv);
                            lowp float f = 1.;

                            f = smoothstep(L - .01, L, .4615);
                            f -= smoothstep(L,L + 0.01, .444);

                            lowp float angle = -atan(uv.y,uv.x);

                            lowp float fspeed = f * mix((1. - step(bCRadSpeed, angle)) * step(fCRadSpeed, angle),
                                     (1. - step(fCRadSpeed, angle)) * step(bCRadSpeed, angle),
                                     _acceleratingSpeed);

                            if (fspeed > .0) {
                              gl_FragColor = mix(c,shaderColorSpeed,fspeed);
                              return;
                            }

                            lowp float ffuel = f * mix((1. - step(bCRadFuel, angle)) * step(fCRadFuel, angle),
                                     (1. - step(fCRadFuel, angle)) * step(bCRadFuel, angle),
                                     _acceleratingFuel);

                            if (ffuel > .0) {
                              gl_FragColor = mix(c, shaderColorFuel, ffuel);
                              return;
                            }

                            gl_FragColor = c;
                        }
                        "
    }

    Text {
        id: topText
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.verticalCenter
        font.pixelSize: Functions.toPixels(0.3, speedgauge.outerRadius)
        color: "white"
        text: speedgauge.value.toFixed()
    }

    Text {
        id: kmText
        text: "km/h"
        color: "white"
        font.pixelSize: Functions.toPixels(0.09, speedgauge.outerRadius)
        anchors.top: topText.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Image {
        id: tyreLight
        anchors.right: parkingLight.left
        anchors.bottom: parkingLight.bottom
        anchors.bottomMargin: 18
        source: ValueSource.flatTire ? "image://etc/Icon_TyreMalfunction_ON.png"
                                     : "image://etc/Icon_TyreMalfunction_OFF.png"
    }

    Image {
        id: parkingLight
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: kmText.bottom
        anchors.topMargin: 20

        source: ValueSource.parkingBrake ? "image://etc/Icon_ParkingBrake_ON.png"
                                         : "image://etc/Icon_ParkingBrake_OFF.png"
    }

    Image {
        id: fuelLight
        anchors.left: parkingLight.right
        anchors.bottom: parkingLight.bottom
        anchors.bottomMargin: 18
        source: (ValueSource.fuelLevel <= 15) ? "image://etc/Icon_Fuel_ON.png"
                                              : "image://etc/Icon_Fuel_OFF.png"
    }
}
