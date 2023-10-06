cmake_minimum_required(VERSION 3.21.1)

project(CarRenderingApp LANGUAGES CXX)

find_package(Qt6 6.5 REQUIRED COMPONENTS
             Core
             Gui
             Qml
             Quick
             Quick3D)

qt_standard_project_setup()

qt_add_executable(CarRenderingApp
    src/main.cpp
    src/app_environment.h
)

qt_add_resources(CarRenderingApp "configuration"
    PREFIX "/"
    FILES
        qtquickcontrols2.conf
)

qt_add_resources(CarRenderingApp "download"
    PREFIX "/qt/qml"
    FILES
        assets/assets_download.json
)

target_link_libraries(CarRenderingApp PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Quick
    Qt6::Quick3D
    Qt6::Qml
)

include(${CMAKE_CURRENT_SOURCE_DIR}/qmlmodules.cmake)
