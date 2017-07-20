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
import "gauges"

DashboardForm
{
    id: dashboardEntity

    state: "start"

    meterOpacity: 0.0

    anchors.fill: parent

    property real timeScaleMultiplier: 1.5
    property bool startupAnimationsFinished: false

    onNeedleRotationChanged: speedometer.speedometerNeedleRotation = needleRotation / 40.

    //
    // Startup animations
    //
    SequentialAnimation {
        id: speedometerStartupAnimations
        running: true

        PauseAnimation { duration: 1000 }
        ScriptAction { script: bottompanel.visible = true }

        SmoothedAnimation {
            target: dashboardEntity
            property: "bottomPanelY"
            from: 480
            to: 402
            duration: 1000 * timeScaleMultiplier
            easing.type: Easing.InCirc
        }

        PauseAnimation {
            duration: 1000
        }

        NumberAnimation {
            target: dashboardEntity
            property: "meterOpacity"
            from: 0
            to: 1
            duration: 2000
        }

        SmoothedAnimation {
            target: dashboardEntity
            property: "needleRotation"
            from: 0.0
            to: -8000.0
            duration: 1000 * timeScaleMultiplier
            easing.type: Easing.InCubic
        }

        SmoothedAnimation {
            target: dashboardEntity
            property: "needleRotation"
            from: -8000.0
            to: 0.0
            duration: 1000 * timeScaleMultiplier
            easing.type: Easing.OutCubic
        }

        ScriptAction { script: startupAnimationsFinished = true }
    }

    function stopAll() {
        speedometerStartupAnimations.stop()
    }

    bottompanel.visible: false
    bottompanel.y: 480
}
