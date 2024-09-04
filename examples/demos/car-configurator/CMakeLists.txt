cmake_minimum_required(VERSION 3.19)

option(BUILD_QDS_COMPONENTS "Build design studio components" ON)

project(CarRenderingApp LANGUAGES CXX)

find_package(Qt6 REQUIRED COMPONENTS
             Core
             Gui
             Qml
             Quick
             Quick3D
             ExamplesAssetDownloaderPrivate)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(CarRenderingApp
    src/main.cpp
    src/app_environment.h
)

qt_add_resources(CarRenderingApp "configuration"
    PREFIX "/"
    FILES
        qtquickcontrols2.conf
)

target_link_libraries(CarRenderingApp PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Quick
    Qt6::Quick3D
    Qt6::Qml
)

include(${CMAKE_CURRENT_SOURCE_DIR}/qmlmodules.cmake)
include(${CMAKE_CURRENT_SOURCE_DIR}/qmlcomponents.cmake)

if (ANDROID)
    FetchContent_Declare(
        android_openssl
        DOWNLOAD_EXTRACT_TIMESTAMP true
        URL https://github.com/KDAB/android_openssl/archive/refs/heads/master.zip
        )
    FetchContent_MakeAvailable(android_openssl)
    include(${android_openssl_SOURCE_DIR}/android_openssl.cmake)

    add_android_openssl_libraries(CarRenderingApp)
endif()

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
