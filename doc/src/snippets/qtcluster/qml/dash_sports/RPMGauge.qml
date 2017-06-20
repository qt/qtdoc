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
    property alias rpmValue: rpmGauge.rpmValue
    property alias maxValue: rpmGauge.maxValue

    Image {
        id: rpmBg
        source: "image://etc/Gauge_RPM.png"
    }

    ShaderEffect {
        id: rpmGauge
        anchors.fill: rpmBg

        property real outerRadius: Math.min(width, height) * 0.5
        property int animationDurationRpm: 50

        property real rpmValue: 0
        property int value: startupAnimationStopped ? ValueSource.rpm : rpmValue
        property int minValue: 0
        property int maxValue: 8000
        property int minAngle: 90
        property int maxAngle: 270
        property real valueInDegrees: ((maxAngle - minAngle)
                                       / (maxValue - minValue)) * (value - minValue)

        property double fCRadRpm: Functions.degToRad(frontCutRpm - 180.)
        property double bCRadRpm: Functions.degToRad(backCutRpm - 180.)

        //Battery gauge
        property real valueBatt: ValueSource.batteryLevel
        property int minAngleBatt: 324
        property int maxAngleBatt: 288
        property int maxValueBatt: 100
        property int animationDurationBatt: 100
        property color shaderColorBatt: "#464749"
        property real valueInDegreesBatt: ((maxAngleBatt - minAngleBatt)
                                           / (maxValueBatt - minValue)) * (valueBatt - minValue)
        property double _acceleratingBatt: (backCutBatt < frontCutBatt) ? 1. : 0.
        property double frontCutBatt: minAngleBatt + valueInDegreesBatt
        property double backCutBatt: minAngleBatt

        property double fCRadBatt: Functions.degToRad(frontCutBatt - 180.)
        property double bCRadBatt: Functions.degToRad(backCutBatt - 180.)

        //Engine temp
        property real valueTemp: ValueSource.engineTemperature > minValueTemp
                                 ? ValueSource.engineTemperature : minValueTemp
        property int minAngleTemp: 35
        property int maxAngleTemp: 72
        property int minValueTemp: 40
        property int maxValueTemp: 120
        property int animationDurationTemp: 100
        property color shaderColorTemp: "#464749"
        property real valueInDegreesTemp: ((maxAngleTemp - minAngleTemp)
                                           / (maxValueTemp - minValueTemp))
                                          * (valueTemp - minValueTemp)
        property double _acceleratingTemp: (backCutTemp < frontCutTemp) ? 1. : 0.
        property double frontCutTemp: minAngleTemp + valueInDegreesTemp
        property double backCutTemp: minAngleTemp

        property double fCRadTemp: Functions.degToRad(frontCutTemp - 180.)
        property double bCRadTemp: Functions.degToRad(backCutTemp - 180.)

        //Shader properties
        property double frontCutRpm: minAngle + valueInDegrees
        property double backCutRpm: minAngle

        // INTERNAL BELOW
        property double _acceleratingRpm: (backCutRpm < frontCutRpm) ? 1. : 0.
        property variant source: rpmBg
        property color shaderColorRpm: "#E31E24"

        Behavior on frontCutRpm {
            enabled: startupAnimationStopped
            PropertyAnimation { duration: rpmGauge.animationDurationRpm }
        }

        Behavior on frontCutBatt {
            enabled: startupAnimationStopped
            PropertyAnimation { duration: rpmGauge.animationDurationBatt }
        }

        Behavior on frontCutTemp {
            enabled: startupAnimationStopped
            PropertyAnimation { duration: rpmGauge.animationDurationTemp }
        }

        fragmentShader: "
                        varying highp vec2 qt_TexCoord0;
                        uniform lowp sampler2D source;
                        uniform lowp float qt_Opacity;
                        lowp vec4 c = vec4(0.,0.,0.,0.);

                        //Rpm
                        uniform lowp vec4 shaderColorRpm;
                        uniform lowp float _acceleratingRpm;
                        uniform highp float fCRadRpm;
                        uniform highp float bCRadRpm;

                        //Batt
                        uniform lowp vec4 shaderColorBatt;
                        uniform lowp float _acceleratingBatt;

                        uniform highp float fCRadBatt;
                        uniform highp float bCRadBatt;

                        //Temp
                        uniform lowp vec4 shaderColorTemp;
                        uniform lowp float _acceleratingTemp;

                        uniform highp float fCRadTemp;
                        uniform highp float bCRadTemp;

                        void main() {
                            highp vec2 uv = vec2(.5 - qt_TexCoord0.y, .5 - qt_TexCoord0.x);

                            lowp float L = length(uv);
                            lowp float f = 0.;

                            f = smoothstep(L - .01, L, .4615);
                            f -= smoothstep(L,L + 0.01, .444);

                            lowp float angle = -atan(uv.y,uv.x);

                            lowp float frpm = f * mix((1. - step(bCRadRpm, angle)) * step(fCRadRpm, angle),
                                     (1. - step(fCRadRpm, angle)) * step(bCRadRpm, angle),
                                     _acceleratingRpm);

                            if (frpm > .0) {
                               gl_FragColor = mix(c,shaderColorRpm,frpm);
                               return;
                            }

                            lowp float fBatt = f * mix((1. - step(bCRadBatt, angle)) * step(fCRadBatt, angle),
                                     (1. - step(fCRadBatt, angle)) * step(bCRadBatt, angle),
                                     _acceleratingBatt);

                            if ( fBatt > .0) {
                               gl_FragColor = mix(c,shaderColorBatt,fBatt);
                               return;
                            }

                            lowp float fTemp= f * mix((1. - step(bCRadTemp, angle)) * step(fCRadTemp, angle),
                                     (1. - step(fCRadTemp, angle)) * step(bCRadTemp, angle),
                                     _acceleratingTemp);

                            if ( fTemp > .0) {
                               gl_FragColor = mix(c, shaderColorTemp, fTemp);
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
        font.pixelSize: Functions.toPixels(0.3, rpmGauge.outerRadius)
        color: "white"
        text: ValueSource.gearString
    }

    Image {
        id: engineLight
        anchors.top: topText.bottom
        anchors.topMargin: 10
        anchors.left: parent.horizontalCenter
        source: ValueSource.batteryLevel > 15 ? "image://etc/Icon_Battery_OFF.png"
                                              : "image://etc/Icon_Battery_ON.png"
        z: 3
    }

    Image {
        id: batteryLight
        anchors.top: topText.bottom
        anchors.topMargin: 10
        anchors.right: parent.horizontalCenter
        source: ValueSource.engineTemperature > 100 ? "image://etc/Icon_Coolant_ON.png"
                                                    : "image://etc/Icon_Coolant_OFF.png"
        z: 3
    }
}
