// Copyright (C) 2017 Klaralvdalens Datakonsult AB (KDAB).
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#include "zoomselector.h"

#include <QLineEdit>

ZoomSelector::ZoomSelector(QWidget *parent)
    : QComboBox(parent)
{
    setEditable(true);

    addItem(tr("Fit Width"));
    addItem(tr("Fit Page"));
    addItem(tr("12%"));
    addItem(tr("25%"));
    addItem(tr("33%"));
    addItem(tr("50%"));
    addItem(tr("66%"));
    addItem(tr("75%"));
    addItem(tr("100%"));
    addItem(tr("125%"));
    addItem(tr("150%"));
    addItem(tr("200%"));
    addItem(tr("400%"));

    connect(this, &QComboBox::currentTextChanged,
            this, &ZoomSelector::onCurrentTextChanged);

    connect(lineEdit(), &QLineEdit::editingFinished,
            this, [this](){onCurrentTextChanged(lineEdit()->text()); });
}

void ZoomSelector::setZoomFactor(qreal zoomFactor)
{
    setCurrentText(QString::number(qRound(zoomFactor * 100)) + QLatin1String("%"));
}

void ZoomSelector::reset()
{
    setCurrentIndex(8); // 100%
}

void ZoomSelector::onCurrentTextChanged(const QString &text)
{
    if (text == QLatin1String("Fit Width")) {
        emit zoomModeChanged(QPdfView::ZoomMode::FitToWidth);
    } else if (text == QLatin1String("Fit Page")) {
        emit zoomModeChanged(QPdfView::ZoomMode::FitInView);
    } else {
        qreal factor = 1.0;

        QString withoutPercent(text);
        withoutPercent.remove(QLatin1Char('%'));

        bool ok = false;
        const int zoomLevel = withoutPercent.toInt(&ok);
        if (ok)
            factor = zoomLevel / 100.0;

        emit zoomModeChanged(QPdfView::ZoomMode::Custom);
        emit zoomFactorChanged(factor);
    }
}
