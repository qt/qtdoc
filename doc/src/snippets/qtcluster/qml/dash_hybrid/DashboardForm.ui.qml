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

DashboardBackground {
    id: dashboardEntity
    property alias bottompanel: bottompanel
    property alias speedometer: speedometer
    property alias tachometer: tachometer

    property alias bottomPanelY: bottompanel.y
    property alias needleRotation: tachometer.tachometerNeedleRotation

    property real meterOpacity: 1

    gadget2.green: tachometer.actualRPM < 4000
    gadget.green: speedometer.actualSpeed < 100

    anchors.fill: parent

    // Speedometer
    SpeedoMeter {
        opacity: dashboardEntity.meterOpacity
        id: speedometer
    }
    // Tachometer
    TachoMeter {
        id: tachometer
        opacity: dashboardEntity.meterOpacity
        anchors.fill: parent
    }
    // Fuelmeter
    FuelMeter {
        opacity: dashboardEntity.meterOpacity
    }
    // Batterymeter
    BatteryMeter {
        opacity: dashboardEntity.meterOpacity
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
    TurboMeter {
        opacity: dashboardEntity.meterOpacity
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
}
