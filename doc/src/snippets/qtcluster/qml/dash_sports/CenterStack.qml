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

import QtQuick 2.6
import ".."
import ClusterDemo 1.0

Item {
    id: centerStack
    property int viewIndex: 4
    height: root.height - 173
    width: root.width / 2
    clip: true

    property alias fadeOutCenter: fadeOutCenter
    property alias fadeInCenter: fadeInCenter
    property alias loader: loader


    Loader {
        id: loader
        onStatusChanged: {
            if (status == Loader.Ready)
                fadeInCenter.start()
        }
        anchors.fill: parent
    }

    Component.onCompleted: {
        loader.source = "../MediaPlayerView.qml"
        // Start with car view, there is some kind of a problem when starting with any
        // other (It seems NoDraw doesn't work if this is not the first view)
        //loadCenterView(true) // We get the first change from signal
    }

    PropertyAnimation {
        id: fadeInCenter
        target: loader
        property: "opacity"
        from: 0.0
        to: 1.0
        duration: 400
        easing.type: Easing.Linear
    }

    PropertyAnimation {
        id: fadeOutCenter
        property: "opacity"
        from: 1.0
        to: 0.0
        duration: 250
        easing.type: Easing.Linear
        onStopped: {
            if (target === car) {
                car.visible = false
                car.item.hidden = true
            } else if (target === camera) {
                camera.visible = false
            }
            if (centerStack.viewIndex === carviewindex) {
                car.visible = true
                fadeInCenter.target = car
                car.item.hidden = false
                fadeInCenter.start()
            } else if (centerStack.viewIndex === videoviewindex) {
                camera.x = centerStack.x
                camera.y = centerStack.y
                camera.visible = true
                fadeInCenter.target = camera
                fadeInCenter.start()
            } else {
                fadeInCenter.target = loader
            }
            loader.source = component[centerStack.viewIndex]
        }
    }
}
