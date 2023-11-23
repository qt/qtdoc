// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick

RoomsSwipeViewForm {

    previousItem.onTapped: {
        var prevIndex = swipeView.currentIndex - 1;
        if (prevIndex < 0)
            prevIndex = swipeView.count - 1
        swipeView.setCurrentIndex(prevIndex)

    }
    nextItem.onTapped: {
        var nextIndex = (swipeView.currentIndex + 1) % swipeView.count;
        swipeView.setCurrentIndex(nextIndex)
    }
}
