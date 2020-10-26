# Generated from alarms.pro.

cmake_minimum_required(VERSION 3.14)
project(alarms LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

if(NOT DEFINED INSTALL_EXAMPLESDIR)
  set(INSTALL_EXAMPLESDIR "examples")
endif()

set(INSTALL_EXAMPLEDIR "${INSTALL_EXAMPLESDIR}/demos/alarms")

find_package(Qt6 COMPONENTS Core)
find_package(Qt6 COMPONENTS Gui)
find_package(Qt6 COMPONENTS Quick)

qt_add_executable(alarms
    main.cpp
)
set_target_properties(alarms PROPERTIES
    WIN32_EXECUTABLE TRUE
    MACOSX_BUNDLE TRUE
)
target_link_libraries(alarms PUBLIC
    Qt::Core
    Qt::Gui
    Qt::Quick
)


# Resources:
set(qml_resource_files
    "AlarmDelegate.qml"
    "AlarmDialog.qml"
    "AlarmModel.qml"
    "TumblerDelegate.qml"
    "main.qml"
    "qtquickcontrols2.conf"
)

qt6_add_resources(alarms "qml"
    PREFIX
        "/"
    FILES
        ${qml_resource_files}
)

install(TARGETS alarms
    RUNTIME DESTINATION "${INSTALL_EXAMPLEDIR}"
    BUNDLE DESTINATION "${INSTALL_EXAMPLEDIR}"
    LIBRARY DESTINATION "${INSTALL_EXAMPLEDIR}"
)
