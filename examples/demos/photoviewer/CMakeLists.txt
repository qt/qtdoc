# Generated from photoviewer.pro.

cmake_minimum_required(VERSION 3.14)
project(photoviewer LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

if(NOT DEFINED INSTALL_EXAMPLESDIR)
  set(INSTALL_EXAMPLESDIR "examples")
endif()

set(INSTALL_EXAMPLEDIR "${INSTALL_EXAMPLESDIR}/demos/photoviewer")

find_package(Qt6 COMPONENTS Core)
find_package(Qt6 COMPONENTS Gui)
find_package(Qt6 COMPONENTS Qml)
find_package(Qt6 COMPONENTS Quick)
find_package(Qt6 COMPONENTS QuickControls2 REQUIRED)
find_package(Qt6 COMPONENTS Network)

qt_add_executable(photoviewer
    main.cpp
    ../shared/xmllistmodel.cpp
    ../shared/xmllistmodel.h
)

set_target_properties(photoviewer PROPERTIES
    WIN32_EXECUTABLE TRUE
    MACOSX_BUNDLE TRUE
    QT_QML_MODULE_VERSION 1.0
    QT_QML_MODULE_URI XmlListModel
)
qt6_qml_type_registration(photoviewer)

target_link_libraries(photoviewer PUBLIC
    Qt::Core
    Qt::Gui
    Qt::Qml
    Qt::Quick
    Qt::Network
    Qt::QuickControls2
)

target_include_directories(photoviewer PUBLIC
    ../shared
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
