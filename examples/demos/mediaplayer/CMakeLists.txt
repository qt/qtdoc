cmake_minimum_required(VERSION 3.16)

project(MediaPlayerApp LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

if(NOT DEFINED INSTALL_EXAMPLESDIR)
    set(INSTALL_EXAMPLESDIR "examples")
endif()

set(INSTALL_EXAMPLEDIR "${INSTALL_EXAMPLESDIR}/demos/mediaplayer")

find_package(Qt6 6.5 REQUIRED COMPONENTS Core Quick QuickControls2 Svg)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(MediaPlayerApp
    main.cpp
)

set(qml_files
    "Main.qml"
    "MetadataInfo.qml"
    "PlayerMenuBar.qml"
    "TracksInfo.qml"
    "TracksOptions.qml"
    "PlaylistInfo.qml"
    "UrlPopup.qml"
    "SettingsInfo.qml"
    "ThemeInfo.qml"
    "ErrorPopup.qml"
    "TouchMenu.qml"
)

qt_add_qml_module(MediaPlayerApp
    URI MediaPlayerModule
    QML_FILES ${qml_files})

add_subdirectory(MediaControls)
add_subdirectory(Config)

target_link_libraries(MediaPlayerApp PRIVATE
    Qt6::Core
    Qt6::Svg
    Qt6::Quick
    MediaControlsplugin
    Configplugin
)

install(TARGETS MediaPlayerApp
    RUNTIME DESTINATION "${INSTALL_EXAMPLEDIR}"
    BUNDLE DESTINATION "${INSTALL_EXAMPLEDIR}"
    LIBRARY DESTINATION "${INSTALL_EXAMPLEDIR}"
)
