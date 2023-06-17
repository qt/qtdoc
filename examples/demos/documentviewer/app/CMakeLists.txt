cmake_minimum_required(VERSION 3.16)
project(documentviewer LANGUAGES CXX)

find_package(Qt6 REQUIRED COMPONENTS Core Gui Widgets)

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
)

set_target_properties(documentviewer PROPERTIES
    WIN32_EXECUTABLE TRUE
    MACOSX_BUNDLE TRUE
)

qt_add_resources(documentviewer "documentviewer"
    PREFIX
        "/demos/documentviewer"
    FILES
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
        "images/document-open-recent.svgz"
        "images/go-next.svgz"
        "images/go-previous.svgz"
        "images/help-about.svgz"
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

