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

import QtQuick 2.0

import ClusterDemo 1.0

Item {
    id: playerView

    property real xCenter: remainingTimeImage.width / 2
    property real yCenter: remainingTimeImage.height / 2
    property var timeElapsed: ValueSource.musicElapsed

    Image {
        id: musicCover
        anchors.top: parent.top
        anchors.topMargin: (ValueSource.carId === 0) ? 160 : 70
        anchors.horizontalCenter: parent.horizontalCenter
        source: "image://etc/MusicPlayer_Cover.png"
    }

    Image {
        id: remainingTimeImage
        anchors.centerIn: musicCover
        source: "image://etc/MusicPlayer_CircleRemaining.png"
    }

    Text {
        id: song
        anchors.top: remainingTimeImage.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: remainingTimeImage.horizontalCenter
        text: "Tonight's the Night \n(Gonna Be Alright)"
        font.pixelSize: 12
        color: "white"
    }
    Text {
        anchors.top: song.bottom
        anchors.horizontalCenter: song.horizontalCenter
        text: "ROD STEWART"
        font.pixelSize: 10
        color: "white"
    }

    function paintBackground(ctx) {
        ctx.beginPath()
        ctx.lineWidth = 2
        ctx.strokeStyle = "white"
        ctx.arc(xCenter, yCenter, yCenter - ctx.lineWidth / 2, 1.5 * Math.PI,
                2 * Math.PI * timeElapsed / 100 + 1.5 * Math.PI)
        ctx.stroke()
    }

    Canvas {
        id: canvas
        width: remainingTimeImage.width
        height: width
        anchors.centerIn: musicCover
        onPaint: {
            var ctx = getContext("2d")
            ctx.reset()
            paintBackground(ctx)
        }
    }
    onTimeElapsedChanged: {
        canvas.requestPaint()
    }

    //Do not play music timer if view not visible
    Component.onCompleted: ValueSource.musicTimer.running = true
    onVisibleChanged: {
        if (!visible)
            ValueSource.musicTimer.running = false
        else
            ValueSource.musicTimer.running = true
    }
}

