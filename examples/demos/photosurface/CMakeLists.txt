# Generated from photosurface.pro.

cmake_minimum_required(VERSION 3.14)
project(photosurface LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

set(INSTALL_EXAMPLEDIR "examples/demos/photosurface")

find_package(Qt6 COMPONENTS Core)
find_package(Qt6 COMPONENTS Gui)
find_package(Qt6 COMPONENTS Qml)
find_package(Qt6 COMPONENTS Quick)

add_qt_gui_executable(photosurface
    main.cpp
)
target_link_libraries(photosurface PUBLIC
    Qt::Core
    Qt::Gui
    Qt::Qml
    Qt::Quick
)


# Resources:
set(photosurface_resource_files
    "photosurface.qml"
    "resources/folder.png"
)

qt6_add_resources(photosurface "photosurface"
    PREFIX
        "/"
    FILES
        ${photosurface_resource_files}
)

if(ANDROID AND TARGET Qt::AndroidExtras)
    target_compile_definitions(photosurface PUBLIC
        REQUEST_PERMISSIONS_ON_ANDROID
    )

    target_link_libraries(photosurface PUBLIC
        Qt::AndroidExtras
    )
endif()

if(TARGET Qt::Widgets)
    target_link_libraries(photosurface PUBLIC
        Qt::Widgets
    )
endif()

install(TARGETS photosurface
    RUNTIME DESTINATION "${INSTALL_EXAMPLEDIR}"
    BUNDLE DESTINATION "${INSTALL_EXAMPLEDIR}"
    LIBRARY DESTINATION "${INSTALL_EXAMPLEDIR}"
)
