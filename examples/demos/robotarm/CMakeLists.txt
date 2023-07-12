cmake_minimum_required(VERSION 3.16)

project(RobotArm LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOMOC ON)

if(NOT DEFINED INSTALL_EXAMPLESDIR)
    set(INSTALL_EXAMPLESDIR "examples")
endif()

set(INSTALL_EXAMPLEDIR "${INSTALL_EXAMPLESDIR}/quick3d/robotarm")

find_package(Qt6 REQUIRED COMPONENTS Gui Qml Quick Quick3D)
qt_standard_project_setup()
qt_add_executable(RobotArmApp src/main.cpp)

qt_add_resources(RobotArmApp "configuration"
    PREFIX "/"
    FILES
        qtquickcontrols2.conf
)

target_link_libraries(RobotArmApp PUBLIC
    Qt::Core
    Qt::Gui
    Qt::Quick
)

add_subdirectory(Backend)

include(${CMAKE_CURRENT_SOURCE_DIR}/qmlmodules)
