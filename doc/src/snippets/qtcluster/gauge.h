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

#ifndef GAUGE_H
#define GAUGE_H

#include <QQuickItem>
#include <QColor>

class Gauge : public QQuickItem
{
    Q_OBJECT

    Q_PROPERTY(qreal value READ value WRITE setValue NOTIFY valueChanged)
    Q_PROPERTY(qreal angle READ angle NOTIFY angleChanged)
    Q_PROPERTY(int numVertices READ numVertices WRITE setNumVertices NOTIFY numVerticesChanged)

    Q_PROPERTY(bool updateGeometry READ updateGeometry WRITE setUpdateGeometry NOTIFY updateGeometryChanged)
    Q_PROPERTY(double fillWidth READ fillWidth WRITE setFillWidth NOTIFY fillWidthChanged)
    Q_PROPERTY(int radius READ radius WRITE setRadius NOTIFY radiusChanged)

    Q_PROPERTY(double minAngle READ minAngle WRITE setMinAngle NOTIFY minAngleChanged)
    Q_PROPERTY(double maxAngle READ maxAngle WRITE setMaxAngle NOTIFY maxAngleChanged)

    Q_PROPERTY(double minValue READ minValue WRITE setMinValue NOTIFY minValueChanged)
    Q_PROPERTY(double maxValue READ maxValue WRITE setMaxValue NOTIFY maxValueChanged)

    Q_PROPERTY(bool doNotFill READ doNotFill WRITE setDoNotFill NOTIFY doNotFillChanged)
    Q_PROPERTY(QColor color READ color WRITE setColor NOTIFY colorChanged)

public:
    Gauge(QQuickItem *parent = 0);
    ~Gauge();

    QSGNode *updatePaintNode(QSGNode *, UpdatePaintNodeData *);
    void geometryChanged(const QRectF &newGeometry, const QRectF &oldGeometry);

    qreal value() const { return m_value; }
    qreal angle() const { return m_angle; }
    bool updateGeometry() const { return m_updateGeometry; }
    int numVertices() const { return m_numVertices; }
    double fillWidth() const { return m_fillWidth; }
    int  radius() const { return m_radius; }
    double minAngle() const { return m_minAngle; }
    double maxAngle() const { return m_maxAngle; }
    double minValue() const { return m_minValue; }
    double maxValue() const { return m_maxValue; }
    bool doNotFill() const { return m_doNotFill; }
    QColor color() const { return m_color; }

    void setValue(qreal value);
    void setNumVertices(int numVertices);
    void setFillWidth(double fillWidth);
    void setRadius(int radius);
    void setMinAngle(double minAngle);
    void setMaxAngle(double maxAngle);
    void setMinValue(double minValue);
    void setMaxValue(double maxValue);
    void setDoNotFill(bool doNotFill);
    void setColor(QColor color);
    void setUpdateGeometry(bool updateGeometry);

signals:
    void valueChanged(qreal value);
    void angleChanged(qreal angle);
    void numVerticesChanged(int numVertices);
    void fillWidthChanged(double fillWidth);
    void radiusChanged(int radius);
    void minAngleChanged(double minAngle);
    void maxAngleChanged(double maxAngle);
    void minValueChanged(double minValue);
    void maxValueChanged(double maxValue);
    void doNotFillChanged(bool doNotFill);
    void colorChanged(QColor color);
    void updateGeometryChanged(bool updateGeometry);

public slots:

private:
    void calcArc();
    float calcValueAsRad(qreal value);
    void updateValue();

private:
    qreal m_value;
    double m_angle;
    int m_numVertices;
    double m_fillWidth;
    int m_radius;
    bool m_updateGeometry;
    bool m_lefttoright;

    double m_minAngle;
    double m_maxAngle;
    double m_minValue;
    double m_maxValue;

    bool m_doNotFill;
    QColor m_color;

    //Internal
    double arc_length;
    double arc_dist_per_vertices;

    double frontCutDeg;
    double backCutDeg;

    double frontCutRad;
    double backCutRad;

    float m_cutRad;
};

#endif // GAUGE_H
