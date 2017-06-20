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

pragma Singleton
import QtQuick 2.6
// comment ifndef QTIVIVEHICLEFUNCTIONS
//import QtIVIVehicleFunctions 1.0
import ClusterDemoData 1.0

Item {
    id: valueSource
    property real kph: 0
    property real consumeKW: 0
    property real maxConsumeKWValue: 90
    property real maxChargeKWValue: 40
    property real chargeKW: 0
    property real maxRange: 600
    property real range: (batteryLevel / 100) * maxRange

    property bool runningInDesigner: false

    property var consumption: [300, 600, 700, 800, 900, 700, 600, 300, 50, 50, -100, 50, -100, -150,
        -200, 50, 150, 200, 300, 200, 300, 200, 500, 50, -100, -100, -150, -80, 50, 300, 600, 700, 800,
        600,  700, 300, 50, 50]

    property var turnSignal
    property var currentDate: new Date()
    //property string date: currentDate.toLocaleDateString(Qt.locale("fi_FI"), "ddd d. MMM")
    //property string time: currentDate.toLocaleTimeString(Qt.locale("fi_FI"), "hh:mm")
    property string date: currentDate.toLocaleDateString(Qt.locale("en_GB"))
    property string time: currentDate.toLocaleTimeString(Qt.locale("en_GB"), "hh:mm")

    ClusterData {
        id: clusterDataSource

        onVehicleSpeedChanged: {
            kph = vehicleSpeed
            if (carId === 0 && !fastBootDemo) {
                oldSpeed.shift()
                oldSpeed.push(vehicleSpeed)
                speedChanged()
            }
        }
        property int notLeft: ~Qt.LeftArrow
        property int notRight: ~Qt.RightArrow
        onLeftTurnLightChanged: leftTurnLight ? turnSignal |= Qt.LeftArrow
                                              : turnSignal &= notLeft
        onRightTurnLightChanged: rightTurnLight ? turnSignal |= Qt.RightArrow
                                                : turnSignal &= notRight
    }

    // comment ifndef QTIVIVEHICLEFUNCTIONS
    property real latitude: clusterDataSource.latitude
    property real longitude: clusterDataSource.longitude
    property real direction: clusterDataSource.direction
    property bool lowBeam: clusterDataSource.headLight
    property int carId: clusterDataSource.carId
    property bool lightFailure: clusterDataSource.lightFailure
    property bool flatTire: clusterDataSource.flatTire

    property bool frontLeftOpen: false
    property bool frontRightOpen: false
    property bool rearLeftDoorOpen: false
    property bool rearRighDoorOpen: false
    property bool hoodOpen: false
    property bool trunkOpen: false

    property double batteryLevel: clusterDataSource.batteryPotential
    property double fuelLevel: clusterDataSource.gasLevel
    property int gear: clusterDataSource.gear
    property bool parkingBrake: clusterDataSource.brake
    // TODO: These two are hacks. View change messages might not come through CAN.
    property bool viewChange: clusterDataSource.oilTemp
    property bool rightViewChange: clusterDataSource.oilPressure

    //
    // ENABLE FOR FAST BOOT DEMO (or otherwise with no CanController)
    //
    property bool fastBootDemo: true

    // TODO: Park light used for automatic demo mode for now
    property bool automaticDemoMode: fastBootDemo ? true : clusterDataSource.parkLight

    //
    // Speed animations for fast boot demo
    //
    Timer {
        running: fastBootDemo
        interval: 4000
        onTriggered: animation.start()
    }

    Timer {
        running: fastBootDemo
        property bool turnLeft: true
        repeat: true
        interval: 5000
        onTriggered: {
            turnLeft = !turnLeft
            if (turnLeft)
                turnSignal = Qt.LeftArrow
            else
                turnSignal = Qt.RightArrow
            stopSignaling.start()
        }
    }

    Timer {
        id: stopSignaling
        running: false
        interval: 2100
        onTriggered: turnSignal = Qt.NoArrow
    }

    Behavior on fuelLevel {
        enabled: fastBootDemo
        PropertyAnimation {
            duration: 18000
        }
    }

    Behavior on batteryLevel {
        enabled: fastBootDemo
        PropertyAnimation {
            duration: 18000
        }
    }

    onFuelLevelChanged: {
        if (fastBootDemo && fuelLevel <= 5)
            fuelLevel = 100
    }

    onBatteryLevelChanged: {
        if (fastBootDemo && batteryLevel <= 5)
            batteryLevel = 100
    }

    SequentialAnimation {
        id: animation
        running: false
        loops: Animation.Infinite

        ScriptAction {
            script: {
                gear = 0
                parkingBrake = true
                consumeKW = 0
                chargeKW = 0
            }
        }
        PauseAnimation { duration: 2000 }
        ScriptAction {
            script: {
                parkingBrake = false
                gear = 1
                fuelLevel -= 10.
                batteryLevel -= 10.
            }
        }
        ParallelAnimation {
            PropertyAnimation {
                target: valueSource
                property: "kph"
                from: 0
                to: 150
                duration: 10000
            }
            PropertyAnimation {
                target: valueSource
                property: "consumeKW"
                from: 0
                to: 75
                duration: 10000
            }
        }
        ParallelAnimation {
            PropertyAnimation {
                target: valueSource
                property: "kph"
                from: 150
                to: 120
                duration: 500
            }
            PropertyAnimation {
                target: valueSource
                property: "consumeKW"
                from: 75
                to: 0
                duration: 100
            }
            PropertyAnimation {
                target: valueSource
                property: "chargeKW"
                from: 0
                to: 40
                duration: 500
            }
        }
        ParallelAnimation {
            PropertyAnimation {
                target: valueSource
                property: "kph"
                from: 120
                to: 200
                duration: 1500
            }
            PropertyAnimation {
                target: valueSource
                property: "consumeKW"
                from: 0
                to: 90
                duration: 1500
            }
            PropertyAnimation {
                target: valueSource
                property: "chargeKW"
                from: 40
                to: 0
                duration: 100
            }
        }
        ParallelAnimation {
            PropertyAnimation {
                target: valueSource
                property: "kph"
                from: 200
                to: 0
                duration: 6000
            }
            PropertyAnimation {
                target: valueSource
                property: "consumeKW"
                from: 90
                to: 0
                duration: 600
            }
            PropertyAnimation {
                target: valueSource
                property: "chargeKW"
                from: 0
                to: 40
                duration: 3000
            }
        }
    }

    property int simuRpm: fastBootDemo ? kph * 40 : kph * 150
    property double simuTemperature: fastBootDemo ? kph * .25 + 60. : kph * .5 + 50.

    // In normal Car UI mode only speed is animated based on gps data
    // In automatic demo mode rpm, turbo, consumption and engine temperature are based on speed
    property int rpm: automaticDemoMode ? simuRpm : clusterDataSource.rpm
    property double engineTemperature: automaticDemoMode ? simuTemperature
                                                         : clusterDataSource.engineTemp

    property int totalDistance: 42300
    property int kmSinceCharge: 8
    property int avRangePerCharge: 425
    property int energyPerKm: 324

    property real totalDistanceSince: 0.

    property string gearString: {
        var g
        if (gear === 0 || gear < -1)
            return "N"
        else if (gear === -1)
            return "R"
        else if (carId === 1) //sports car
            return gear.toString()
        else
            return "D"
    }

    Timer {
        id: timeTimer
        interval: 15000
        repeat: true
        running: true
        onTriggered: {
            currentDate = new Date()
            //date = currentDate.toLocaleDateString(Qt.locale("fi_FI"), "ddd d. MMM")
            //time = currentDate.toLocaleTimeString(Qt.locale("fi_FI"), "hh:mm")
            date = currentDate.toLocaleDateString(Qt.locale("en_GB"))
            time = currentDate.toLocaleTimeString(Qt.locale("en_GB"), "hh:mm")
            // Approximate total distance based on current speed
            totalDistanceSince += kph / 240. // = km / 15 min
            if (totalDistanceSince > 1.) {
                var totalInt = Math.floor(totalDistanceSince)
                totalDistance += totalInt
                kmSinceCharge += totalInt
                totalDistanceSince -= totalInt
            }
        }
    }

    Timer {
        id: backCutTimer
        interval: 1000
        repeat: true
        running: true
        onTriggered: {
            backCut = kph
        }
    }

    property real temperature: 0.6
    property alias musicTimer: musicTimer
    property real backCut: 0 //For needle tail gradient
    property real musicElapsed: 0

    Timer {
        id: musicTimer
        interval: 2000
        running: false
        repeat: true
        onTriggered: {
            if (musicElapsed < 100)
            musicElapsed++
            else
            musicElapsed = 0
        }
    }

    Behavior on kph {
        enabled: !fastBootDemo
        PropertyAnimation { duration: 2000 }
    }

    //
    // For electric car KwGauge animation
    //
    property var oldSpeed: [0, 0, 0]
    signal speedChanged

    SequentialAnimation {
        id: reduceSpeedAnim
        running: (carId === 0 && !fastBootDemo)
        property alias chargeTo: charge.to
        NumberAnimation {
            target: valueSource
            property: "consumeKW"
            duration: 600
            to: 0
        }
        NumberAnimation {
            id: charge
            target: valueSource
            property: "chargeKW"
            duration: 600
        }
    }

    SequentialAnimation {
        id: addSpeedAnim
        running: (carId === 0 && !fastBootDemo)
        property alias consumeTo: consume.to
        NumberAnimation {
            target: valueSource
            property: "chargeKW"
            duration: 600
            to: 0

        }
        NumberAnimation {
            id: consume
            target: valueSource
            property: "consumeKW"
            duration: 600
        }
    }

    onSpeedChanged: {
        var speedChange = oldSpeed[1] - oldSpeed[0]
        if (speedChange > 2) {
            //"adding speed"
            var newKW = Math.min(maxConsumeKWValue * 0.8, 10 * speedChange)
            addSpeedAnim.consumeTo = newKW
            addSpeedAnim.restart()
        } else if (speedChange < -2) {
            //"reducing speed"
            newKW = Math.min(maxChargeKWValue * 0.8, 2 * Math.abs(speedChange))
            reduceSpeedAnim.chargeTo = newKW
            reduceSpeedAnim.restart()
        } else if (Math.abs(speedChange) >= 0 && oldSpeed[1] !== 0) {
            //Speed just about the same but still moving
            addSpeedAnim.consumeTo = Math.min(maxConsumeKWValue * (kph / 100),
                                              maxConsumeKWValue * 0.5)
            addSpeedAnim.restart()
        }
        if (kph <= 0.1) {
            addSpeedAnim.consumeTo = 0
            reduceSpeedAnim.chargeTo = 0
            addSpeedAnim.restart()
            reduceSpeedAnim.restart()
        }
    }
}
