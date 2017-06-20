/****************************************************************************
**
** Copyright (C) 2014 The Qt Company and/or its subsidiary(-ies).
** Contact: http://www.qt.io
**
** This file is part of the The Qt Company automotive framework.
**
****************************************************************************/

import QtQuick 2.0

import "functions.js" as Functions

Item {
    id: gauge
    property alias topText: topTxt
    property alias bgSource: bgImage.source
    property real outerRadius: Math.min(width, height) * 0.5
    property int animationDuration: 500

    property int value: 0
    property int minValue: 0
    property int maxValue: 10000
    property int minAngle: -138
    property int maxAngle: 162
    property real valueInDegrees: ((maxAngle - minAngle) / (maxValue - minValue)) * (value - minValue)
    property string shaderColor: "#E31E24"

    //This is for drawing the shader needle. RpmGauge values background is a bit bigger than
    //speedometer (or in different location).
    // As we draw all gauge needles here we need the correction for rpm gauge
    property alias pixelCorrection: effect.pixelCorrection

    Image {
        id: bgImage
        anchors.centerIn: parent
    }

    Text {
        id: topTxt
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.verticalCenter
        font.pixelSize: Functions.toPixels(0.3, outerRadius)
        color: "white"
    }

    ShaderEffect {
        id: effect
        anchors.centerIn: parent

        width: gauge.width
        height: gauge.height
        property double frontCut: gauge.minAngle + gauge.valueInDegrees// new speed
        property double backCut: gauge.minAngle //starting point

        // INTERNAL BELOW
        property double _accelerating: (backCut < frontCut) ? 1. : 0.
        property double pixelCorrection: 0.0

        property variant source: ShaderEffectSource {
            sourceItem: Rectangle {
                width: effect.width
                height: effect.width
                radius: width
                color: shaderColor
            }
        }

        Behavior on frontCut {
            enabled: startupAnimationStopped
            PropertyAnimation { duration: animationDuration }
        }

        fragmentShader: "
                    varying highp vec2 qt_TexCoord0;
                    uniform lowp sampler2D source;
                    uniform lowp float qt_Opacity;

                    uniform lowp float frontCut;
                    uniform lowp float backCut;
                    uniform lowp float _accelerating;
                    uniform lowp float pixelCorrection;

                    highp float FCRad = radians(frontCut - 180.);
                    highp float BCRad = radians(backCut - 180.);

                    void main() {
                        highp vec2 uv = vec2(.5 - qt_TexCoord0.y, .5 - qt_TexCoord0.x);

                        lowp float L = length(uv);
                        lowp float f = 0.;

                        f = smoothstep(L - .01, L, .4615 + pixelCorrection);
                        f -= smoothstep(L,L + 0.01, .444 + pixelCorrection);
                        //f = step(L, 0.48);
                        //f -= step(L,0.45);

                        lowp float angle = -atan(uv.y,uv.x);

                        // Without gradient
                        f *= mix((1. - step(BCRad, angle)) * step(FCRad, angle),
                                 (1. - step(FCRad, angle)) * step(BCRad, angle),
                                 _accelerating);

                        gl_FragColor = texture2D(source, qt_TexCoord0) * f * 1.;
                    }
                    "
    }
}
