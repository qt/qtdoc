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

Item {
    anchors.fill: parent
    property real defaultScale: 1.0
    property var previousView: calendarView
    property bool view: ValueSource.viewChange

    property int viewNumber: -1


    CenterViewMusic {
        id: musicView
        anchors.horizontalCenter: parent.horizontalCenter
        yTarget: 230
        width: 124
        height: 124
        visible: false
        y: defaultYPos
    }

    CenterViewContacts {
        id: contactView
        anchors.horizontalCenter: parent.horizontalCenter
        yTarget: 240
        width: 100
        height: 100
        visible: false
        y: defaultYPos
    }

    CenterViewCarInfo {
        id: carinfoView
        xTarget: (parent.width - width) / 2
        anchors.top: parent.top
        anchors.topMargin: 230
        width: 146
        height: 80
        x: defaultXPos
        visible: false
    }

    CenterViewCalendar {
        id: calendarView
        xTarget: (parent.width - width) / 2
        anchors.top: parent.top
        anchors.topMargin: 230
        width: 100
        height: 91
        x: defaultXPos
        visible: false
    }

    PropertyAnimation {
        id: shrinkCenter
        property: "scale"
        to: 0.0
        running: false
        duration: 500
        onStopped: {
            if (target != null)
                target.visible = false
        }
    }

    function handleViewChange(number) {
        var currentView
        if (number === 0)
            currentView = musicView
        else if (number === 1)
            currentView = contactView
        else if (number === 2)
            currentView = carinfoView
        else if (number === 3)
            currentView = calendarView
        if (previousView !== currentView) {
            currentView.scale = defaultScale
            currentView.visible = true
            shrinkCenter.target = previousView
            previousView = currentView
            shrinkCenter.start()
        }
    }

    onViewChanged: {
        if (view) {
            if (++viewNumber > 3)
                viewNumber = 0
            handleViewChange(viewNumber)
        }
    }

    // Used on automatic demo mode
    Timer {
        id: centerTimer
        property int viewNumber: -1
        running: ValueSource.automaticDemoMode
        repeat: true
        interval: 6000
        onTriggered: {
            if (++viewNumber > 3)
                viewNumber = 0
            handleViewChange(viewNumber)
        }
    }

    function stopAll() {
        centerTimer.stop()
    }
}
