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

import QtQuick 2.4
import ClusterDemo 1.0

DashboardForm {
    id: main //the id is used in e.g. VehicleInfoNote

    width: 1280
    height: 480

    //Start animating gauges after both are loaded
    function showGauges() {
        if (speedoMeter.status === Loader.Ready
                && flipable.rpm.status === Loader.Ready) {
            startupAnimation.start()
        }
    }

    property var component: [
        "../MapView.qml",
        "../MediaPlayerView.qml",
        "../ConsumptionView.qml",
        "", // VideoView.qml
        "../CarParking.qml",
        "" // CarView.qml
    ]

    property string mapPositionImage: "image://etc/MapLocationSport.png"

    property int videoviewindex: 3
    property int parkingviewindex: 4
    property int carviewindex: 5

    property int preReversingCenterView: -1
    property int preReversingRightView

    // CarModel animations
    property int carModelHighlightType: 0

    property bool doorAction: false
    property bool actionInProgress: false
    property bool loadingInProgress: false
    property bool isReversing: false

    property int doorsOpen: ValueSource.frontLeftOpen + ValueSource.frontRightOpen
                            + ValueSource.hoodOpen + ValueSource.trunkOpen
    property bool flatTire: ValueSource.flatTire
    property bool lightFailure: ValueSource.lightFailure
    property int gear: ValueSource ? ValueSource.gear : "4"

    property var cameraView: camera
    property bool viewChanged: ValueSource.viewChange

    function forceCarView() {
        actionInProgress = true
        // Make CarView visible before activating the animations
        if (car.item && car.item.hidden) {
            if (camera.visible)
                camera.visible = false
            car.opacity = 1.0
            centerStack.visible = false
            car.visible = true
            car.item.hidden = false
        }
    }

    function loadCenterView(nextView, allowParking) {
        loadingInProgress = true
        var previousViewIndex = centerStack.viewIndex

        if (preReversingCenterView != -1 && !allowParking) {
            if (centerStack.viewIndex !== preReversingCenterView) {
                centerStack.viewIndex = preReversingCenterView
                if (centerStack.viewIndex < 0)
                    centerStack.viewIndex = 5
            }
        }
        else {
            centerStack.viewIndex = getViewIndex(centerStack.viewIndex, nextView, allowParking)
        }
        loadingInProgress = false

        if (previousViewIndex === carviewindex)
            centerStack.fadeOutCenter.target = car
        else if (previousViewIndex === videoviewindex)
            centerStack.fadeOutCenter.target = camera
        else
            centerStack.fadeOutCenter.target = centerStack.loader
        centerStack.fadeOutCenter.start()
    }

    function getViewIndex(viewindex, nextView, allowParking) {
        if (allowParking) {
            return videoviewindex
        }

        if (nextView) {
            viewindex++
            if (viewindex === parkingviewindex) {
                viewindex++
            }
            if (viewindex > 5)
                viewindex = 0
        } else {
            viewindex--
            if (viewindex === parkingviewindex) {
                viewindex--
            }
            if (viewindex < 0)
                viewindex = 5
        }
        return viewindex
    }

    onDoorsOpenChanged: {
        if (actionInProgress && !doorAction)
            return

        // Check all doors & parse a correct value from them
        var doors = 0
        if (ValueSource.frontLeftOpen)
            doors ^= 1
        if (ValueSource.frontRightOpen)
            doors ^= 2
        if (ValueSource.trunkOpen)
            doors ^= 4
        if (ValueSource.hoodOpen)
            doors ^= 8

        if (doors != 0) {
            forceCarView()
            if (car.item)
                car.item.highlightDoors(doors)
            carModelHighlightType = -1
        }
    }

    onFlatTireChanged: {
        if (!actionInProgress && flatTire) {
            forceCarView()
            carModelHighlightType = car.item.highlightTire()
        }
    }

    onLightFailureChanged: {
        if (!actionInProgress && lightFailure) {
            forceCarView()
            carModelHighlightType = car.item.highlightLamp()
        }
    }

    onGearChanged: {
        if (gear === -1)
            reversing()
        else if (gear >= 0)
            returnFromReversing()
    }

    onViewChangedChanged: changeView(viewChanged)

    function reversing() {
        isReversing = true
        // Car backing up, trigger rear camera view and proximity sensor view
        preReversingCenterView = centerStack.viewIndex
        loadCenterView(0, true)
        flipable.flipped = !flipable.flipped
    }

    function returnFromReversing() {
        if (!isReversing)
            return
        loadCenterView(true, false)
        preReversingCenterView = -1
        flipable.flipped = !flipable.flipped
        isReversing = false
    }

    function changeView(nextView) {
        if (isReversing)
            return
        if (actionInProgress || loadingInProgress)
            return
        if (nextView)
            loadCenterView(nextView)
    }

    function stopAll() {
        returnView.stop()
        startupAnimation.stop()
        centerStack.fadeOutCenter.stop()
        centerStack.fadeInCenter.stop()
        doorAction = false
        actionInProgress = false
        loadingInProgress = false
        isReversing = false
    }

    Timer {
        id: returnView
        interval: 1000
        running: false
        onTriggered: {
            if (camera.x === centerStack.x)
                camera.visible = true
            car.item.hidden = true
            car.visible = false
            car.opacity = 0.0
            centerStack.visible = true
        }
    }

    SequentialAnimation {
        id: startupAnimation
        ParallelAnimation {
            SmoothedAnimation {
                target: speedoMeter.rotation
                property: "angle"
                from: 90
                to: 0
                duration: 300
            }
            SmoothedAnimation {
                target: flipable.flipRotation
                property: "angle"
                from: 90
                to: 0
                duration: 300
            }
        }

        ParallelAnimation {
            SequentialAnimation {
                id: rpmAnimation
                SmoothedAnimation {
                    target: flipable.rpm.item
                    property: "rpmValue"
                    to: flipable.rpm.item.maxValue
                    duration: gaugeDemoTime
                    easing.type: Easing.InQuint
                }
                SmoothedAnimation {
                    target: flipable.rpm.item
                    property: "rpmValue"
                    to: ValueSource.rpm
                    duration: gaugeDemoTime
                    easing.type: Easing.OutQuint
                }
                ScriptAction {
                    script: flipable.rpm.item.rpmValue = ValueSource.rpm
                }
            }

            SequentialAnimation {
                id: speedAnimation
                SmoothedAnimation {
                    target: speedoMeter.item
                    property: "speedValue"
                    to: speedoMeter.item.maxValue
                    duration: gaugeDemoTime
                    easing.type: Easing.InQuint
                }
                SmoothedAnimation {
                    target: speedoMeter.item
                    property: "speedValue"
                    to: ValueSource.kph // TODO: Not entirely accurate this way, fix
                    duration: gaugeDemoTime
                    easing.type: Easing.OutQuint
                }
                ScriptAction {
                    script: startupAnimationStopped = true
                }
            }
        }
        ScriptAction {
            script: car.active = true
        } //Start the 3d model loading
    }

    speedoMeter.onLoaded: showGauges()
    flipable.onLoaded:  showGauges()
}
