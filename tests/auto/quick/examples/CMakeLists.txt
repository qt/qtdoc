# Copyright (C) 2022 The Qt Company Ltd.
# SPDX-License-Identifier: BSD-3-Clause

# Generated from examples.pro.

#####################################################################
## tst_examples Test:
#####################################################################

qt_internal_add_test(tst_examples
    SOURCES
        tst_examples.cpp
    DEFINES
        SRCDIR="${CMAKE_CURRENT_SOURCE_DIR}"
    LIBRARIES
        Qt::CorePrivate
        Qt::Gui
        Qt::GuiPrivate
        Qt::QmlPrivate
        Qt::QuickPrivate
)

#### Keys ignored in scope 1:.:.:examples.pro:<TRUE>:
# testcase.timeout = "400"

## Scopes:
#####################################################################

qt_internal_extend_target(tst_examples CONDITION NOT TARGET Qt::XmlPatterns
    DEFINES
        QT_NO_XMLPATTERNS
)
