cmake_minimum_required(VERSION 3.21.1)

project(CarRenderingApp LANGUAGES CXX)

if(NOT DEFINED INSTALL_EXAMPLESDIR)
    set(INSTALL_EXAMPLESDIR "examples")
endif()

set(INSTALL_EXAMPLEDIR "${INSTALL_EXAMPLESDIR}/demos/${PROJECT_NAME}")

find_package(Qt6 6.6 REQUIRED COMPONENTS
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

install(TARGETS CarRenderingApp
    RUNTIME DESTINATION "${INSTALL_EXAMPLEDIR}"
    BUNDLE DESTINATION "${INSTALL_EXAMPLEDIR}"
    LIBRARY DESTINATION "${INSTALL_EXAMPLEDIR}"
)
