// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick

RoomsSwipeViewForm {

    previousItem.onTapped: swipeView.decrementCurrentIndex()
    nextItem.onTapped: swipeView.incrementCurrentIndex()
}
