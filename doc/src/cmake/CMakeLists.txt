# Copyright (C) 2022 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only WITH Qt-GPL-exception-1.0

# special case skip regeneration

add_library(qtcmake INTERFACE)

qt_internal_add_docs(qtcmake
                     qtcmake.qdocconf
)
