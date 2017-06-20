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

#include "gauge.h"
#include "gaugenode.h"

#include <QtQuick/qsgnode.h>
#include <QtQuick/qsgflatcolormaterial.h>
#include <QtMath>

Gauge::Gauge(QQuickItem *parent)
    : QQuickItem(parent)
    , m_value(0)
    , m_angle(0)
    , m_numVertices(128)
    , m_fillWidth(10)
    , m_radius(0)
    , m_updateGeometry(true)
    , m_lefttoright(true)
    , m_minAngle(0)
    , m_maxAngle(270)
    , m_minValue(0)
    , m_maxValue(240)
    , m_doNotFill(false)
    , m_color(QColor(255, 0, 0))
    , arc_length(0)
    , arc_dist_per_vertices(0)
    , frontCutDeg(0.0)
    , backCutDeg(0.0)
    , frontCutRad(0.0)
    , backCutRad(0.0)
    , m_cutRad(0)
{
    setFlag(ItemHasContents, true);
}

Gauge::~Gauge()
{
}

void Gauge::setValue(qreal value)
{
    if (m_value == value)
        return;

    m_value = value;
    updateValue();

    emit valueChanged(value);
    update();
}

void Gauge::setNumVertices(int numVertices)
{
    if (m_numVertices == numVertices)
        return;

    m_numVertices = numVertices;
    emit numVerticesChanged(numVertices);
    update();
}

void Gauge::setFillWidth(double fillWidth)
{
    if (m_fillWidth == fillWidth)
        return;

    m_fillWidth = fillWidth;
    emit fillWidthChanged(m_fillWidth);
    update();
}

void Gauge::setRadius(int radius)
{
    if (m_radius == radius)
        return;

    m_radius = radius;
    emit radiusChanged(m_radius);
    update();
}

void Gauge::setMinAngle(double minAngle)
{
    if (m_minAngle == minAngle)
        return;

    m_minAngle = minAngle;

    backCutDeg = m_minAngle;
    backCutRad = qDegreesToRadians(backCutDeg);

    if (m_minAngle < m_maxAngle)
        m_lefttoright = true;
    else
        m_lefttoright = false;

    updateValue();

    emit minAngleChanged(m_minAngle);
    update();
}

void Gauge::setMaxAngle(double maxAngle)
{
    if (m_maxAngle == maxAngle)
        return;

    m_maxAngle = maxAngle;

    if (m_minAngle < m_maxAngle)
        m_lefttoright = true;
    else
        m_lefttoright = false;

    updateValue();
    emit maxAngleChanged(m_maxAngle);
    update();
}

void Gauge::setMinValue(double minValue)
{
    if (m_minValue == minValue)
        return;

    m_minValue = minValue;
    emit minValueChanged(m_minValue);
    update();
}

void Gauge::setMaxValue(double maxValue)
{
    if (m_maxValue == maxValue)
        return;

    m_maxValue = maxValue;
    emit maxValueChanged(m_maxValue);
    update();
}

void Gauge::setDoNotFill(bool doNotFill)
{
    if (m_doNotFill == doNotFill)
        return;

    m_doNotFill = doNotFill;
    emit doNotFillChanged(m_doNotFill);
    update();
}

void Gauge::setColor(QColor color)
{
    if (m_color == color)
        return;

    m_color = color;
    emit colorChanged(m_color);
    update();
}

void Gauge::setUpdateGeometry(bool updateGeometry)
{
    if (m_updateGeometry == updateGeometry)
        return;
    m_updateGeometry = updateGeometry;

    if (m_updateGeometry)
        calcArc();
    else
        m_cutRad = calcValueAsRad(m_value);

    update();
}

float Gauge::calcValueAsRad(qreal value)
{
    return qDegreesToRadians((m_minAngle + ((m_maxAngle - m_minAngle) / (m_maxValue - m_minValue))
                              * (value - m_minValue)) - 180.);
}

void Gauge::updateValue()
{
    if (m_updateGeometry)
        calcArc();
    else
        m_cutRad = calcValueAsRad(m_value);
}

void Gauge::calcArc()
{
    backCutDeg = m_minAngle;
    backCutRad = qDegreesToRadians(backCutDeg - 270);

    if (m_updateGeometry) {
        m_angle = ((m_maxAngle - m_minAngle) / (m_maxValue - m_minValue))
                * (m_value - m_minValue);
    } else {
        m_angle = ((m_maxAngle - m_minAngle) / (m_maxValue - m_minValue))
                * (m_maxValue - m_minValue);
    }

    arc_length = qDegreesToRadians(m_angle);
    arc_dist_per_vertices = arc_length / m_numVertices;

    emit angleChanged(m_angle);
}

QSGNode *Gauge::updatePaintNode(QSGNode *oldNode, UpdatePaintNodeData *)
{
    GaugeNode *n = static_cast<GaugeNode *>(oldNode);

    if (!n)
        n = new GaugeNode(m_numVertices, m_color, m_doNotFill);

    n->setLeftToRight(m_lefttoright);
    n->setColor(m_color);
    n->setBoundingRect(boundingRect());
    n->setUpdateGeometry(m_updateGeometry);
    n->setDoNotFill(m_doNotFill);
    n->setBackCutRad(backCutRad);
    n->setRadius(m_radius);
    n->setArcDistPerVert(arc_dist_per_vertices);
    n->setNumVertices(m_numVertices);
    n->setFillWidth(m_fillWidth);
    if (!m_updateGeometry)
        n->setCutRad(m_cutRad);
    n->draw();
    return n;
}

void Gauge::geometryChanged(const QRectF &newGeometry, const QRectF &oldGeometry)
{
    QQuickItem::geometryChanged(newGeometry, oldGeometry);
    if (m_radius == 0)
        setRadius(newGeometry.height() * 0.5);

    calcArc();
    update();
}
