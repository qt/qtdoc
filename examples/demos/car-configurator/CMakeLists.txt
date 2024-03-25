cmake_minimum_required(VERSION 3.21.1)

project(CarRenderingApp LANGUAGES CXX)

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
    BUNDLE  DESTINATION .
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
)

qt_generate_deploy_qml_app_script(
    TARGET CarRenderingApp
    OUTPUT_SCRIPT deploy_script
    MACOS_BUNDLE_POST_BUILD
    NO_UNSUPPORTED_PLATFORM_ERROR
    DEPLOY_USER_QML_MODULES_ON_UNSUPPORTED_PLATFORM
)
install(SCRIPT ${deploy_script})
