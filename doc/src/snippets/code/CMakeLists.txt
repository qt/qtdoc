cmake_minimum_required(VERSION 3.14)
project(qt5app LANGUAGES CXX)

if (WIN32)
#! [appicon_windows]
    set(APP_ICON_RESOURCE_WINDOWS "${CMAKE_CURRENT_SOURCE_DIR}/qt5app.rc")
    add_executable(qt5app main.cpp ${APP_ICON_RESOURCE_WINDOWS})
#! [appicon_windows]
elseif (APPLE)
#! [appicon_macOS]
    # NOTE: Don't include the path in MACOSX_BUNDLE_ICON_FILE -- this is
    # the property added to Info.plist
    set(MACOSX_BUNDLE_ICON_FILE qt5app.icns)

    # And this part tells CMake where to find and install the file itself
    set(APP_ICON_MACOSX ${CMAKE_CURRENT_SOURCE_DIR}/qt5app.icns)
    set_source_files_properties(${APP_ICON_MACOSX} PROPERTIES
           MACOSX_PACKAGE_LOCATION "Resources")

    add_executable(qt5app MACOSX_BUNDLE main.cpp ${APP_ICON_MACOSX})
#! [appicon_macOS]
else()
    add_executable(qt5app main.cpp)
endif()
