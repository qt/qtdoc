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

    for (int i : { 12, 25, 33, 50, 66, 75, 100, 125, 150, 200, 400 })
        addItem(QString::number(i) + QLocale().percent());

    connect(this, &QComboBox::currentTextChanged,
            this, &ZoomSelector::onCurrentTextChanged);

    connect(lineEdit(), &QLineEdit::editingFinished,
            this, [this](){onCurrentTextChanged(lineEdit()->text()); });
}

void ZoomSelector::setZoomFactor(qreal zoomFactor)
{
    setCurrentText(QString::number(qRound(zoomFactor * 100)) + QLocale().percent());
}

void ZoomSelector::reset()
{
    setCurrentIndex(8); // 100%
}

void ZoomSelector::onCurrentTextChanged(const QString &text)
{
    if (text == tr("Fit Width")) {
        emit zoomModeChanged(QPdfView::ZoomMode::FitToWidth);
    } else if (text == tr("Fit Page")) {
        emit zoomModeChanged(QPdfView::ZoomMode::FitInView);
    } else {
        qreal factor = 1.0;

        QString withoutPercent(text);
        withoutPercent.remove(QLocale().percent());

        bool ok = false;
        const int zoomLevel = withoutPercent.toInt(&ok);
        if (ok)
            factor = zoomLevel / 100.0;

        emit zoomModeChanged(QPdfView::ZoomMode::Custom);
        emit zoomFactorChanged(factor);
    }
}
