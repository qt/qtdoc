# Copyright (C) 2023 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

qt_add_plugin(imageviewer
    CLASS_NAME ImageViewer
    imageviewer.cpp imageviewer.h
)

set_target_properties(imageviewer PROPERTIES
    LIBRARY_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/app"
)

target_link_libraries(imageviewer PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Widgets
    abstractviewer
)

qt_add_translations(imageviewer
    SOURCE_TARGETS imageviewer
    TS_FILE_BASE imgviewer
)

if(TARGET Qt6::PrintSupport)
    target_link_libraries(imageviewer PRIVATE Qt6::PrintSupport)
endif()

if(WIN32)
    set(install_destination "${CMAKE_INSTALL_BINDIR}/app")
elseif(APPLE)
    set(install_destination ".")
else()
    set(install_destination "${CMAKE_INSTALL_BINDIR}")
endif()
install(TARGETS imageviewer
    RUNTIME DESTINATION "${install_destination}"
    LIBRARY DESTINATION "${install_destination}"
)
