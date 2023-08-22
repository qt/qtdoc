# Copyright (C) 2022 The Qt Company Ltd.
# SPDX-License-Identifier: BSD-3-Clause

qt_internal_add_test(tst_examples
    SOURCES
        tst_examples.cpp
    DEFINES
        SRCDIR="${CMAKE_CURRENT_SOURCE_DIR}"
        QT_NO_FOREACH
        QT_NO_CAST_FROM_ASCII
    LIBRARIES
        Qt6::Gui
        Qt6::Quick
)
