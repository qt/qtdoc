cmake_minimum_required(VERSION 3.16)
project(documentviewer LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)

if(NOT DEFINED INSTALL_EXAMPLESDIR)
    set(INSTALL_EXAMPLESDIR "examples")
endif()

set(INSTALL_EXAMPLEDIR "${INSTALL_EXAMPLESDIR}")

find_package(Qt6 REQUIRED COMPONENTS Core Gui Widgets PdfWidgets
                 OPTIONAL_COMPONENTS PrintSupport)

qt_standard_project_setup()

qt_add_executable(documentviewer
    main.cpp
    mainwindow.cpp mainwindow.h mainwindow.ui
    abstractviewer.cpp abstractviewer.h
    viewerfactory.cpp viewerfactory.h
    jsonviewer.cpp jsonviewer.h
    txtviewer.cpp txtviewer.h
    pdfviewer.cpp pdfviewer.h
    zoomselector.cpp zoomselector.h
    hoverwatcher.cpp hoverwatcher.cpp
    documentviewer.qrc
)

set_target_properties(documentviewer PROPERTIES
    WIN32_EXECUTABLE TRUE
    MACOSX_BUNDLE TRUE
)

# Resources:


target_link_libraries(documentviewer PUBLIC
    Qt6::Core
    Qt6::Gui
    Qt6::Widgets
    Qt6::PdfWidgets
)

if(TARGET Qt6::PrintSupport)
    target_link_libraries(documentviewer PRIVATE Qt6::PrintSupport)
endif()

install(TARGETS documentviewer
    RUNTIME DESTINATION "${INSTALL_EXAMPLEDIR}"
    BUNDLE DESTINATION "${INSTALL_EXAMPLEDIR}"
    LIBRARY DESTINATION "${INSTALL_EXAMPLEDIR}"
)
