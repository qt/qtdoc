# Copyright (C) 2022 The Qt Company Ltd.
# SPDX-License-Identifier: BSD-3-Clause

cmake_minimum_required(VERSION 3.16)
project(tweetsearch LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)

if(NOT DEFINED INSTALL_EXAMPLESDIR)
    set(INSTALL_EXAMPLESDIR "examples")
endif()

set(INSTALL_EXAMPLEDIR "${INSTALL_EXAMPLESDIR}/demos/tweetsearch")

find_package(Qt6 REQUIRED COMPONENTS Core Gui Qml Quick)

qt_add_executable(tweetsearch
    main.cpp
)

set_target_properties(tweetsearch PROPERTIES
    WIN32_EXECUTABLE TRUE
    MACOSX_BUNDLE TRUE
)

target_link_libraries(tweetsearch PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
)

# Resources:
set(qmake_content_resource_files
    "content/FlipBar.qml"
    "content/LineInput.qml"
    "content/ListFooter.qml"
    "content/ListHeader.qml"
    "content/SearchDelegate.qml"
    "content/TweetDelegate.qml"
    "content/TweetsModel.qml"
    "content/resources/anonymous.png"
    "content/resources/bird-anim-sprites.png"
    "content/resources/icon-clear.png"
    "content/resources/icon-loading.png"
    "content/resources/icon-refresh.png"
    "content/resources/icon-search.png"
    "content/shaders/effect.frag"
    "content/shaders/effect.frag.qsb"
    "content/shaders/effect.vert"
    "content/shaders/effect.vert.qsb"
    "content/tweetsearch.mjs"
    "tweetsearch.qml"
)

qt_add_resources(tweetsearch "qmake_content"
    PREFIX
        "/demos/tweetsearch"
    FILES
        ${qmake_content_resource_files}
)

install(TARGETS tweetsearch
    RUNTIME DESTINATION "${INSTALL_EXAMPLEDIR}"
    BUNDLE DESTINATION "${INSTALL_EXAMPLEDIR}"
    LIBRARY DESTINATION "${INSTALL_EXAMPLEDIR}"
)
