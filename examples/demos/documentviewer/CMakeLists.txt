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
)

set_target_properties(documentviewer PROPERTIES
    WIN32_EXECUTABLE TRUE
    MACOSX_BUNDLE TRUE
)
# Resources:
set(documentviewer_resource_files
    "images/copy@2x.png"
    "images/copy.png"
    "images/cut@2x.png"
    "images/cut.png"
    "images/go-next-view@2x.png"
    "images/go-next-view-page@2x.png"
    "images/go-next-view-page.png"
    "images/go-next-view.png"
    "images/go-previous-view@2x.png"
    "images/go-previous-view-page@2x.png"
    "images/go-previous-view-page.png"
    "images/go-previous-view.png"
    "images/magnifier@2x.png"
    "images/magnifier.png"
    "images/open@2x.png"
    "images/open.png"
    "images/paste@2x.png"
    "images/paste.png"
    "images/print2x.png"
    "images/print.png"
    "images/qt-logo@2x.png"
    "images/qt-logo.png"
    "images/zoom-fit-best@2x.png"
    "images/zoom-fit-best.png"
    "images/zoom-fit-width@2x.png"
    "images/zoom-fit-width.png"
    "images/zoom-in@2x.png"
    "images/zoom-in.png"
    "images/zoom-original@2x.png"
    "images/zoom-original.png"
    "images/zoom-out@2x.png"
    "images/zoom-out.png"
    "images/zoom-previous@2x.png"
    "images/zoom-previous.png"
)

qt6_add_resources(documentviewer "documentviewer"
    PREFIX
        "/demos/documentviewer"
    FILES
        ${documentviewer_resource_files}
)

target_link_libraries(documentviewer PUBLIC
    Qt::Core
    Qt::Gui
    Qt::Widgets
    Qt::PdfWidgets
)

if(TARGET Qt6::PrintSupport)
    target_link_libraries(documentviewer PRIVATE Qt6::PrintSupport)
endif()

install(TARGETS documentviewer
    RUNTIME DESTINATION "${INSTALL_EXAMPLEDIR}"
    BUNDLE DESTINATION "${INSTALL_EXAMPLEDIR}"
    LIBRARY DESTINATION "${INSTALL_EXAMPLEDIR}"
)
