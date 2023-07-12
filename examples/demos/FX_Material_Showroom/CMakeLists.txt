cmake_minimum_required(VERSION 3.16)

project(FxMaterialShowroomApp LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOMOC ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Gui Qml Quick Quick3D)

qt_add_executable(FxMaterialShowroomApp
    src/app_environment.h
    src/main.cpp
    src/imagedownloader.cpp
    src/imagedownloader.h
)

qt_add_resources(FxMaterialShowroomApp "configuration"
    PREFIX "/"
    FILES
        qtquickcontrols2.conf
)

target_link_libraries(FxMaterialShowroomApp PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
)

include(qmlmodules)
