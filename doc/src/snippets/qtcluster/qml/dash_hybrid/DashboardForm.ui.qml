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

    gadget2.green: tachometer.actualValue < 4000
    gadget2.value: tachometer.actualValue
    gadget2.maxValue: 8000
    gadget.green: speedometer.actualValue < 100
    gadget.value: speedometer.actualValue

    anchors.fill: parent

    // Fuelmeter

    SmallMeter {
        id: fuelMeter
        x: 432
        y: 47
        value: ValueSource.fuelLevel
        opacity: dashboardEntity.meterOpacity
    }

    // Batterymeter

    SmallMeter {
        id: batteryMeter
        x: 433
        y: 47
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

    ConsumptionMeter {
        opacity: dashboardEntity.meterOpacity
    }
    // Temperaturemeter

    TemperatureMeter {
        opacity: dashboardEntity.meterOpacity
    }
    // Turbometer

    SmallMeter {
        id: smallMeter
        x: 741
        y: 47
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
        opacity: dashboardEntity.meterOpacity
    }

    // Bottom Panel

    BottomPanel {
        id: bottompanel
        y: 402
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
        x: 35
        y: 8
        actualValue: ValueSource.kph
    }

    LargeMeter {
        id: tachometer
        opacity: dashboardEntity.meterOpacity
        x: 768
        y: 8
        minValueAngle: 55
        maxValueAngle: 255
        minimumValue: 0
        maximumValue: 8000
        limitValue: 4000
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
    Text {
        id: textEco

        anchors.horizontalCenter: tachometer.horizontalCenter
        text: tachometer.actualValue > 4000 ? "POWER" : "ECO"
        anchors.verticalCenter: tachometer.verticalCenter
        font.pixelSize: 18
        color: tachometer.actualValue <= 4000 ? "white" : "red"
        opacity: dashboardEntity.meterOpacity
    }

}
