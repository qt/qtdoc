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
import ClusterDemo 1.0
import QtQuick.Extras 1.4
import "../functions.js" as Functions

Item {
    id: speedoItem
    property real speedValue: speedoMeter.value
    property alias maxValue: speedometer.maxValue
    anchors.fill: parent

    property color iconRed: "#e41e25"
    property color iconGreen: "#5caa15"
    property color iconYellow: "#face20"
    property color iconDark: "#444444"

    Item {
        id: speedometer

        property bool animated: ValueSource.runningInDesigner ? false : startupAnimationStopped
        property real value: animated ? ValueSource.kph : speedValue



        anchors.fill: parent

        property real maxValue: 240
        width: height

        property real outerRadius: Math.min(width, height) * 0.5

        property real maxValueAngle: 90
        property real minValueAngle: -179

        property real degreesPerValue: Math.abs((minValueAngle - maxValueAngle)
                                                / speedometer.maximumValue)

        Image {
            source: "image://etc/Gauge_Speed.png"
            anchors.fill: parent
        }

        Text {
            id: speedText
            font.pixelSize: Functions.toPixels(0.4, parent.outerRadius)
            text: speedometer.value.toFixed()
            color: "white"
            horizontalAlignment: Text.AlignRight
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 115
        }

        Text {
            id: kmText
            text: "km/h"
            color: "white"
            font.pixelSize: Functions.toPixels(0.09, parent.outerRadius)
            anchors.top: speedText.bottom
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Picture {
            id: tyreLight

            width: 48
            height: 48
            anchors.right: parkingLight.left
            anchors.bottom: parkingLight.bottom
            anchors.bottomMargin: 18

            color: ValueSource.flatTire ? speedoItem.iconYellow : speedoItem.iconDark
            source: "qrc:/iso-icons/iso_grs_7000_4_1434A.dat"
        }

        Picture {
            id: parkingLight

            width: 48
            height: 48
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: kmText.bottom
            anchors.topMargin: 11

            color: ValueSource.parkingBrake ? speedoItem.iconRed : speedoItem.iconDark
            source: "qrc:/iso-icons/iso_grs_7000_4_0238.dat"
        }

        Picture {
            id: fuelLight

            width: 48
            height: 48
            anchors.left: parkingLight.right
            anchors.bottom: parkingLight.bottom
            anchors.bottomMargin: 18

            color: ValueSource.fuelLevel <= 20.0 ? speedoItem.iconRed : speedoItem.iconDark
            source: "qrc:/iso-icons/iso_grs_7000_4_0245.dat"
        }

        CircularIndicator {
            anchors.fill: parent

            startAngle: speedometer.minValueAngle
            endAngle: speedometer.maxValueAngle
            minimumValue: 0
            maximumValue: speedometer.maxValue
            value: speedometer.value
            padding: 13
            backgroundColor: "transparent"
            progressColor: "#E31E24"
        }
    }

    CircularIndicator {
        id: fuelGauge

        anchors.fill: parent

        value: ValueSource.fuelLevel
        minimumValue: 0
        maximumValue: 100
        startAngle: 144
        endAngle: 108
        padding: 13
        backgroundColor: "transparent"
        progressColor: "#464749"
    }
}
