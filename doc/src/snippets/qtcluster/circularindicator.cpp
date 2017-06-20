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

#include "circularindicator.h"

CircularIndicator::CircularIndicator(QQuickItem *parent)
    : QQuickPaintedItem(parent)
    , mStartAngle(0)
    , mEndAngle(360)
    , mMinimumValue(0.0)
    , mMaximumValue(100.0)
    , mValue(0.0)
    , mLineWidth(10)
    , mProgressColor(QColor(255, 0, 0))
    , mBackgroundColor(QColor(240, 240, 240))
    , mPadding(1)
{
}

CircularIndicator::~CircularIndicator()
{
}

int CircularIndicator::startAngle() const
{
    return mStartAngle;
}

void CircularIndicator::setStartAngle(int angle)
{
    if (angle == mStartAngle)
        return;

    mStartAngle = angle;
    emit startAngleChanged(mStartAngle);
    update();
}

int CircularIndicator::endAngle() const
{
    return mEndAngle;
}

void CircularIndicator::setEndAngle(int angle)
{
    if (angle == mEndAngle)
        return;

    mEndAngle = angle;
    emit endAngleChanged(mEndAngle);
    update();
}

qreal CircularIndicator::minimumValue() const
{
    return mMinimumValue;
}

void CircularIndicator::setMinimumValue(qreal value)
{
    if (qFuzzyCompare(value, mMinimumValue))
        return;

    if (value > mMaximumValue) {
        qWarning() << this << "\nMinimum value can't exceed maximum value.";
        return;
    }

    mMinimumValue = value;
    emit minimumValueChanged(mMinimumValue);
    update();
}

qreal CircularIndicator::maximumValue() const
{
    return mMaximumValue;
}

void CircularIndicator::setMaximumValue(qreal value)
{
    if (qFuzzyCompare(value, mMaximumValue))
        return;

    if (value < mMinimumValue) {
        qWarning() << this << "\nMaximum value can't be less than minimum value.";
        return;
    }

    mMaximumValue = value;
    emit maximumValueChanged(value);
    update();
}

qreal CircularIndicator::value() const
{
    return mValue;
}

void CircularIndicator::setValue(qreal value)
{
    if (qFuzzyCompare(value, mValue))
        return;

    if (value < mMinimumValue) {
        qWarning() << this << "\nValue can't be less than minimum value.";
        return;
    }

    if (value > mMaximumValue) {
        qWarning() << this << "\nValue can't exceed maximum value.";
        return;
    }

    mValue = value;
    emit valueChanged(mValue);
    update();
}

int CircularIndicator::lineWidth() const
{
    return mLineWidth;
}

void CircularIndicator::setLineWidth(int width)
{
    if (width == mLineWidth)
        return;

    mLineWidth = width;
    emit lineWidthChanged(mLineWidth);
    update();
}

QColor CircularIndicator::progressColor() const
{
    return mProgressColor;
}

void CircularIndicator::setProgressColor(QColor color)
{
    if (color == mProgressColor)
        return;

    mProgressColor = color;
    emit progressColorChanged(mProgressColor);
    update();
}

QColor CircularIndicator::backgroundColor() const
{
    return mBackgroundColor;
}

void CircularIndicator::setBackgroundColor(QColor color)
{
    if (color == mBackgroundColor)
        return;

    mBackgroundColor = color;
    emit backgroundColorChanged(mBackgroundColor);
    update();
}

int CircularIndicator::padding() const
{
    return mPadding;
}

void CircularIndicator::setPadding(int padding)
{
    if (padding == mPadding)
        return;

    mPadding = padding;
    emit paddingChanged(mPadding);
    update();
}

void CircularIndicator::paint(QPainter *painter)
{
    painter->setRenderHint(QPainter::Antialiasing);

    int indicatorSize = qMin(width(), height()) - mPadding * 2 - mLineWidth;

    if (indicatorSize <= 0)
        return;

    QRect indicatorRect(width() / 2 - indicatorSize / 2,
                        height() / 2 - indicatorSize / 2,
                        indicatorSize,
                        indicatorSize);

    QPen pen;
    pen.setCapStyle(Qt::FlatCap);
    pen.setWidth(mLineWidth);
    pen.setColor(mBackgroundColor);
    painter->setPen(pen);

    int endAngle = (qAbs(mEndAngle) > 360) ? mEndAngle % 360 : mEndAngle;

    // See http://doc.qt.io/qt-5/qpainter.html#drawArc for details
    int minimumAngle = (90 - mStartAngle) * 16;
    int maximumAngle = (90 - endAngle) * 16 - minimumAngle;

    painter->drawArc(indicatorRect, minimumAngle, maximumAngle);

    if (qFuzzyCompare(mValue, mMinimumValue))
        return;

    pen.setColor(mProgressColor);
    painter->setPen(pen);

    int currentAngle = ((mValue - mMinimumValue) / (mMaximumValue - mMinimumValue)) * maximumAngle;

    painter->drawArc(indicatorRect, minimumAngle, currentAngle);
}
