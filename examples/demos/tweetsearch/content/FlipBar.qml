/****************************************************************************
**
** Copyright (C) 2017 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
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

import QtQuick

Item {
    id: container
    property int animDuration: 300
    property Item front: Item {}
    property Item back: Item {}
    property real factor: 0.1 // amount the edges fold in for the 3D effect
    property alias delta: effect.delta
    property Item cur: frontShown ? front : back
    property Item noncur: frontShown ? back : front

    function swap() {
        var tmp = front;
        front = back;
        back = tmp;
        resync();
    }

    width: cur.width
    height: cur.height
    onFrontChanged: resync();
    onBackChanged: resync();

    function resync() {//TODO: Are the items ever actually visible?
        back.parent = container;
        front.parent = container;
        frontShown ? back.visible = false : front.visible = false;
    }

    property bool frontShown: true

    onFrontShownChanged: {
        back.visible = !frontShown
        front.visible = frontShown
    }

    function flipUp(start) {
        effect.visible = true;
        effect.sourceA = effect.source1
        effect.sourceB = effect.source2
        if (start === undefined)
            start = 1.0;
        deltaAnim.from = start;
        deltaAnim.to = 0.0
        dAnim.start();
        frontShown = false;
    }

    function flipDown(start) {
        effect.visible = true;
        effect.sourceA = effect.source1
        effect.sourceB = effect.source2
        if (start === undefined)
            start = 0.0;
        deltaAnim.from = start;
        deltaAnim.to = 1.0
        dAnim.start();
        frontShown = true;
    }

    ShaderEffect {
        id: effect
        width: cur.width
        height: cur.height
        property real factor: container.factor * width
        property real delta: 1.0

        mesh: GridMesh { resolution: Qt.size(8,2) }

        SequentialAnimation on delta {
            id: dAnim
            running: false
            NumberAnimation {
            id: deltaAnim
            duration: animDuration//expose anim
            }
        }

        property variant sourceA: source1
        property variant sourceB: source1
        property variant source1: ShaderEffectSource {
            sourceItem: front
            hideSource: effect.visible
        }

        property variant source2: ShaderEffectSource {
            sourceItem: back
            hideSource: effect.visible
        }

        fragmentShader: "shaders/effect.frag.qsb"
        property real h: height
        vertexShader: "shaders/effect.vert.qsb"

    }
}
