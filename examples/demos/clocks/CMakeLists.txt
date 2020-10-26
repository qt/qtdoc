# Generated from clocks.pro.

cmake_minimum_required(VERSION 3.14)
project(clocks LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

if(NOT DEFINED INSTALL_EXAMPLESDIR)
  set(INSTALL_EXAMPLESDIR "examples")
endif()

set(INSTALL_EXAMPLEDIR "${INSTALL_EXAMPLESDIR}/demos/clocks")

find_package(Qt6 COMPONENTS Core)
find_package(Qt6 COMPONENTS Gui)
find_package(Qt6 COMPONENTS Qml)
find_package(Qt6 COMPONENTS Quick)

qt_add_executable(clocks
    main.cpp
)
set_target_properties(clocks PROPERTIES
    WIN32_EXECUTABLE TRUE
    MACOSX_BUNDLE TRUE
)
target_link_libraries(clocks PUBLIC
    Qt::Core
    Qt::Gui
    Qt::Qml
    Qt::Quick
)


# Resources:
set(clocks_resource_files
    "clocks.qml"
    "content/Clock.qml"
    "content/arrow.png"
    "content/background.png"
    "content/center.png"
    "content/clock-night.png"
    "content/clock.png"
    "content/hour.png"
    "content/minute.png"
    "content/quit.png"
    "content/second.png"
)

qt6_add_resources(clocks "clocks"
    PREFIX
        "/demos/clocks"
    FILES
        ${clocks_resource_files}
)

install(TARGETS clocks
    RUNTIME DESTINATION "${INSTALL_EXAMPLEDIR}"
    BUNDLE DESTINATION "${INSTALL_EXAMPLEDIR}"
    LIBRARY DESTINATION "${INSTALL_EXAMPLEDIR}"
)
