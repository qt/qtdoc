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

Rectangle
{
    width: 1280
    height: 480
    gradient: Gradient {
        GradientStop { position: 0.0; color: "#ffffff" }
        GradientStop { position: 0.4; color: "#1e2127" }
        GradientStop { position: 1.0; color: "#0c0f17" }
    }

    Image {
        id: logo
        anchors.horizontalCenter: parent.horizontalCenter
        y: 270
        source: "image://etc/Built_with_Qt.png"
    }

    Loader {
        id: dashLoader
        anchors.fill: parent
        source: "DashboardView.qml"
        active: logo.status === Image.Ready
        transform: Rotation {
            id: rot
            origin.x: 1280 / 2
            origin.y: 0
            axis { x: 1; y: 0; z: 0 }
            angle: ValueSource.runningInDesigner ? 0 : 90    // the default angle

        }
        onLoaded: flipin.start()
    }

    SequentialAnimation {
        id: flipin
        PauseAnimation { duration: 500 }
        SmoothedAnimation { target: rot; property: "angle"; from: 90; to: 0; duration: 500 }
        PauseAnimation { duration: 2500 }
        OpacityAnimator { target: logo; from: 1.0; to: 0; duration: 500 }
    }

    function stopAll() {
        dashLoader.item.stopAll()
    }
}
