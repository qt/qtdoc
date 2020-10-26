# Generated from tweetsearch.pro.

cmake_minimum_required(VERSION 3.14)
project(tweetsearch LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

if(NOT DEFINED INSTALL_EXAMPLESDIR)
  set(INSTALL_EXAMPLESDIR "examples")
endif()

set(INSTALL_EXAMPLEDIR "${INSTALL_EXAMPLESDIR}/demos/tweetsearch")

find_package(Qt6 COMPONENTS Core)
find_package(Qt6 COMPONENTS Gui)
find_package(Qt6 COMPONENTS Quick)
find_package(Qt6 COMPONENTS Qml)

qt_add_executable(tweetsearch
    main.cpp
)
set_target_properties(tweetsearch PROPERTIES
    WIN32_EXECUTABLE TRUE
    MACOSX_BUNDLE TRUE
)
target_link_libraries(tweetsearch PUBLIC
    Qt::Core
    Qt::Gui
    Qt::Qml
    Qt::Quick
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
    "content/tweetsearch.mjs"
    "tweetsearch.qml"
)

qt6_add_resources(tweetsearch "qmake_content"
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
