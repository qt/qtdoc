# Copyright (C) 2022 The Qt Company Ltd.
# SPDX-License-Identifier: BSD-3-Clause

# Generated from qqmlparser.pro.

#####################################################################
## tst_qqmlparser Test:
#####################################################################

qt_internal_add_test(tst_qqmlparser_doc # special case
    SOURCES
        tst_qqmlparser.cpp
    DEFINES
        SRCDIR="${CMAKE_CURRENT_SOURCE_DIR}"
    LIBRARIES
        Qt6::Gui
        Qt6::QmlPrivate
)

## Scopes:
#####################################################################

qt_internal_extend_target(tst_qqmlparser_doc CONDITION CMAKE_CROSSCOMPILING # special case
    DEFINES
        QTEST_CROSS_COMPILED
)
