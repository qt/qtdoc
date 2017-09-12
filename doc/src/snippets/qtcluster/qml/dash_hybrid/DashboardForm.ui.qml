/****************************************************************************
**
** Copyright (C) 2015 The Qt Company Ltd.
** Contact: http://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
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
import QtQuick 2.6
import ClusterDemo 1.0
import "gauges"
import QtQuick.Extras 1.4
import ".."

DashboardBackground {
    id: dashboardEntity
    property alias bottompanel: bottompanel

    property alias bottomPanelY: bottompanel.y
    property alias needleRotation: tachometer.speedometerNeedleRotation

    property real meterOpacity: 1
    property alias speedometer: speedometer
    property alias tachometer: tachometer
    property alias speedText: speedText
    property alias smallMeter: smallMeter
    property alias consumptionMeter: consumptionMeter

    anchors.fill: parent

    // Fuelmeter
    SmallMeter {
        id: fuelMeter
        x: 740
        y: 45
        value: ValueSource.fuelLevel
        opacity: dashboardEntity.meterOpacity
    }

    // Batterymeter
    SmallMeter {
        id: batteryMeter
        x: 739
        y: 45
        value: ValueSource.batteryLevel
        opacity: dashboardEntity.meterOpacity
        maxValueAngle: 317
        minValueAngle: 225
        maximumValue: 100
        degreesPerValue: Math.abs(
                             (maxValueAngle - minValueAngle) / maximumValue)
        rotationOffset: 135
        direction: -1
    }

    // Consumptionmeter

    // Temperaturemeter
    TemperatureMeter {
        opacity: dashboardEntity.meterOpacity

        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 640
        anchors.topMargin: 82
    }

    // Turbometer
    SmallMeter {
        id: smallMeter
        x: 437
        y: 45
        opacity: dashboardEntity.meterOpacity

        value: ValueSource.rpm / 2000.

        maxValueAngle: 270
        minValueAngle: 0
        maximumValue: 4.0
        degreesPerValue: Math.abs(
                             (maxValueAngle - minValueAngle) / maximumValue)
    }

    // Fpsmeter
    FpsMeter {
        x: 582
        opacity: dashboardEntity.meterOpacity
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 591
        anchors.topMargin: 87
    }

    // Bottom Panel
    BottomPanel {
        id: bottompanel
        y: 412
        anchors.horizontalCenterOffset: 0
    }

    SpeedometerNumbers {
        id: speedometerNumbers
        x: 103
        y: 73
        value: speedometer.actualValue
        opacity: dashboardEntity.meterOpacity
    }

    LargeMeter {
        id: speedometer

        opacity: dashboardEntity.meterOpacity
        x: 34
        y: 3
        actualValue: ValueSource.kph
        maxValueAngle: 304

        layer.enabled: opacity < 1

        Gadget {
            id: knobLeft
            x: 113
            y: 118

            green: speedometer.actualValue < 100
            value: speedometer.actualValue
        }
    }


    LargeMeter {
        id: tachometer
        opacity: dashboardEntity.meterOpacity
        x: 763
        y: 2
        actualValue: 6000
        minValueAngle: 55
        maxValueAngle: 255
        minimumValue: 0
        maximumValue: 8000
        limitValue: 7000

        layer.enabled: opacity < 1

        LargeMeter {
            id: consumptionMeter
            x: 1
            y: -2
            fillWidth: 22
            limitValue: 22
            angleOffset: 72
            actualValue: 30
            visible: true

            minValueAngle: 379
            maxValueAngle: 291
            minimumValue: 0
            maximumValue: 30
        }

        Gadget {
            id: knobRight
            x: 116
            y: 117

            green: tachometer.actualValue < 7000
            value: tachometer.actualValue
            maxValue: 8000

            Text {
                id: textEco
                x: -56
                y: 156

                anchors.horizontalCenter: parent.horizontalCenter
                text: tachometer.actualValue > 6000 ? "POWER" : "ECO"
                anchors.verticalCenterOffset: 3
                anchors.horizontalCenterOffset: 7
                visible: true
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 18
                color: tachometer.actualValue <= 6000 ? "white" : "red"
                opacity: dashboardEntity.meterOpacity
            }
        }
    }


    Text {
        id: speedText
        x: 74
        y: 330

        font.pixelSize: 40
        color: "lightGray"
        text: "10"
        anchors.horizontalCenter: speedometer.horizontalCenter
        opacity: dashboardEntity.meterOpacity
    }


    Text {
        id: speedUnitText
        anchors.top: speedText.bottom
        font.pixelSize: 18
        color: "lightGray"
        text: "KM/H"
        anchors.horizontalCenter: speedText.horizontalCenter
        opacity: dashboardEntity.meterOpacity
    }


    Image {
        id: knobSmallLeft
        x: 460
        y: 68
        source: "image://etc/knob_small.png"
    }

    Image {
        id: knobSmallRight
        x: 763
        y: 70
        source: "image://etc/knob_small.png"
    }

    Image {
        id: knobSmallcenter
        x: 610
        y: 62
        source: "image://etc/knob_small.png"
    }
}
