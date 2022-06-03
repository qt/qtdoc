// Copyright (C) 2017 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

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
