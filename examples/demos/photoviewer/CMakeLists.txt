cmake_minimum_required(VERSION 3.16)
project(photoviewer LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)

if(NOT DEFINED INSTALL_EXAMPLESDIR)
    set(INSTALL_EXAMPLESDIR "examples")
endif()

set(INSTALL_EXAMPLEDIR "${INSTALL_EXAMPLESDIR}/demos/photoviewer")

find_package(Qt6 REQUIRED COMPONENTS Core Gui Qml QmlXmlListModel Quick)

qt_add_executable(photoviewer
    main.cpp
)

set_target_properties(photoviewer PROPERTIES
    WIN32_EXECUTABLE TRUE
    MACOSX_BUNDLE TRUE
)

target_link_libraries(photoviewer PUBLIC
    Qt::Core
    Qt::Gui
    Qt::Qml
    Qt::Quick
    Qt::QmlXmlListModel
)

# Resources:
set(qmake_immediate_resource_files
    "PhotoViewerCore/AlbumDelegate.qml"
    "PhotoViewerCore/BusyIndicator.qml"
    "PhotoViewerCore/Button.qml"
    "PhotoViewerCore/EditableButton.qml"
    "PhotoViewerCore/PhotoDelegate.qml"
    "PhotoViewerCore/ProgressBar.qml"
    "PhotoViewerCore/RssModel.qml"
    "PhotoViewerCore/Tag.qml"
    "PhotoViewerCore/images/box-shadow.png"
    "PhotoViewerCore/images/busy.png"
    "PhotoViewerCore/images/cardboard.png"
    "PhotoViewerCore/script/script.mjs"
    "main.qml"
)

qt6_add_resources(photoviewer "qmake_immediate"
    PREFIX
        "/"
    FILES
        ${qmake_immediate_resource_files}
)

if(lupdate_only)
    target_sources(photoviewer PUBLIC
        *.qml
        PhotoViewerCore/*.qml
        PhotoViewerCore/script/*.js
    )
endif()

install(TARGETS photoviewer
    RUNTIME DESTINATION "${INSTALL_EXAMPLEDIR}"
    BUNDLE DESTINATION "${INSTALL_EXAMPLEDIR}"
    LIBRARY DESTINATION "${INSTALL_EXAMPLEDIR}"
)
