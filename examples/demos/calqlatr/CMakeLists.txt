# Generated from calqlatr.pro.

cmake_minimum_required(VERSION 3.14)
project(calqlatr LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

if(NOT DEFINED INSTALL_EXAMPLESDIR)
  set(INSTALL_EXAMPLESDIR "examples")
endif()

set(INSTALL_EXAMPLEDIR "${INSTALL_EXAMPLESDIR}/demos/calqlatr")

find_package(Qt6 COMPONENTS Core)
find_package(Qt6 COMPONENTS Gui)
find_package(Qt6 COMPONENTS Qml)
find_package(Qt6 COMPONENTS Quick)

qt_add_executable(calqlatr
    main.cpp
)
set_target_properties(calqlatr PROPERTIES
    WIN32_EXECUTABLE TRUE
    MACOSX_BUNDLE TRUE
)
target_link_libraries(calqlatr PUBLIC
    Qt::Core
    Qt::Gui
    Qt::Qml
    Qt::Quick
)


# Resources:
set(calqlatr_resource_files
    "calqlatr.qml"
    "content/Button.qml"
    "content/Display.qml"
    "content/NumberPad.qml"
    "content/calculator.js"
    "content/images/paper-edge-left.png"
    "content/images/paper-edge-right.png"
    "content/images/paper-grip.png"
)

qt6_add_resources(calqlatr "calqlatr"
    PREFIX
        "/demos/calqlatr"
    FILES
        ${calqlatr_resource_files}
)

install(TARGETS calqlatr
    RUNTIME DESTINATION "${INSTALL_EXAMPLEDIR}"
    BUNDLE DESTINATION "${INSTALL_EXAMPLEDIR}"
    LIBRARY DESTINATION "${INSTALL_EXAMPLEDIR}"
)
