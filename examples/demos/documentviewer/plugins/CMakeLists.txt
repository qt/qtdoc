# Copyright (C) 2023 The Qt Company Ltd.
# SPDX-License-Identifier: BSD-3-Clause

add_subdirectory(jsonviewer)
add_subdirectory(txtviewer)

if(TARGET Qt6::PdfWidgets)
    add_subdirectory(pdfviewer)
endif()
