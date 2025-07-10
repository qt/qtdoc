# Copyright (C) 2023 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

qt_add_plugin(txtviewer
    CLASS_NAME TxtViewer
    txtviewer.cpp txtviewer.h
)

set_target_properties(txtviewer PROPERTIES
    LIBRARY_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/app"
)

target_link_libraries(txtviewer PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Widgets
    abstractviewer
)

qt_add_translations(txtviewer
    SOURCE_TARGETS txtviewer
    TS_FILE_BASE txtviewer
)

if(TARGET Qt6::PrintSupport)
    target_link_libraries(txtviewer PRIVATE Qt6::PrintSupport)
endif()

if(WIN32)
    set(install_destination "${CMAKE_INSTALL_BINDIR}/app")
elseif(APPLE)
    set(install_destination ".")
else()
    set(install_destination "${CMAKE_INSTALL_BINDIR}")
endif()
install(TARGETS txtviewer
    RUNTIME DESTINATION "${install_destination}"
    LIBRARY DESTINATION "${install_destination}"
)
