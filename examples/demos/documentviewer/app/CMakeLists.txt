cmake_minimum_required(VERSION 3.16)
project(documentviewer LANGUAGES CXX)

find_package(Qt6 REQUIRED COMPONENTS Core Gui Widgets)

set(CMAKE_AUTORCC ON)

qt_standard_project_setup()

qt_add_library(abstractviewer STATIC
    abstractviewer.cpp abstractviewer.h
)

qt_add_executable(documentviewer
    main.cpp
    mainwindow.cpp mainwindow.h mainwindow.ui
    viewerfactory.cpp viewerfactory.h
    recentfiles.cpp recentfiles.h
    recentfilemenu.cpp recentfilemenu.h
    viewerinterfaces.h
    documentviewer.qrc
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

if(QT6_IS_SHARED_LIBS_BUILD)
    add_dependencies(documentviewer ${plugin_targets})
else()
    target_link_libraries(documentviewer PRIVATE ${plugin_targets})
endif()

if(TARGET Qt6::PrintSupport)
    target_link_libraries(documentviewer PRIVATE Qt6::PrintSupport)
    target_link_libraries(abstractviewer PRIVATE Qt6::PrintSupport)
    add_compile_definitions(QT_DOCUMENTVIEWER_PRINTSUPPORT)
endif()

install(TARGETS documentviewer
    RUNTIME DESTINATION "${INSTALL_EXAMPLEDIR}"
    BUNDLE DESTINATION "${INSTALL_EXAMPLEDIR}"
    LIBRARY DESTINATION "${INSTALL_EXAMPLEDIR}"
)

