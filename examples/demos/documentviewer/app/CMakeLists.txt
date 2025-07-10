# Copyright (C) 2023 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

qt_add_library(abstractviewer
    abstractviewer.cpp abstractviewer.h
    translator.cpp translator.h
    abstractviewerglobal.h
)

target_compile_definitions(abstractviewer PRIVATE BUILD_ABSTRACTVIEWER_LIB)

target_include_directories(abstractviewer INTERFACE .)

set(CMAKE_AUTORCC ON)

qt_add_executable(documentviewer
    main.cpp
    mainwindow.cpp mainwindow.h mainwindow.ui
    viewerfactory.cpp viewerfactory.h
    recentfiles.cpp recentfiles.h
    recentfilemenu.cpp recentfilemenu.h
    viewerinterfaces.h
    documentviewer.qrc
)

qt_add_translations(documentviewer
    TS_FILE_BASE docviewer
    MERGE_QT_TRANSLATIONS
    QT_TRANSLATION_CATALOGS qtbase
)

set_target_properties(documentviewer PROPERTIES
    WIN32_EXECUTABLE TRUE
    MACOSX_BUNDLE TRUE
)

target_link_libraries(documentviewer PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Widgets
    abstractviewer
)

target_link_libraries(abstractviewer PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Widgets
)

set(plugin_targets
    jsonviewer
    txtviewer
)

if(TARGET pdfviewer)
    list(APPEND plugin_targets pdfviewer)
endif()

if(TARGET Q3Dviewer)
    list(APPEND plugin_targets Q3Dviewer)
endif()

if(QT6_IS_SHARED_LIBS_BUILD)
    add_dependencies(documentviewer ${plugin_targets})
else()
    target_link_libraries(documentviewer PRIVATE ${plugin_targets})
endif()

if(TARGET Qt6::PrintSupport)
    target_link_libraries(abstractviewer PUBLIC Qt6::PrintSupport)
    target_compile_definitions(abstractviewer PUBLIC
        DOCUMENTVIEWER_PRINTSUPPORT
    )
endif()

install(TARGETS documentviewer
    BUNDLE  DESTINATION .
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
)

install(TARGETS abstractviewer
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
)
