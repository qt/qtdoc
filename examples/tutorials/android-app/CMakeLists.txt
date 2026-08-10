cmake_minimum_required(VERSION 3.26)

project(accelbubble VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

#! [find-package]
find_package(Qt6 REQUIRED COMPONENTS Quick Sensors Svg)
#! [find-package]

qt_standard_project_setup(REQUIRES 6.10)

#! [add-executable]
qt_add_executable(appaccelbubble
    main.cpp
)
#! [add-executable]

#! [qml-module]
qt_add_qml_module(appaccelbubble
    URI accelbubble
    QML_FILES Main.qml
    RESOURCES Bluebubble.svg
)
#! [qml-module]

set_target_properties(appaccelbubble PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appaccelbubble
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
    QT_ANDROID_APP_NAME "Accelbubble"
    QT_ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android"
)

#! [link-libraries]
target_link_libraries(appaccelbubble
    PRIVATE Qt6::Quick Qt6::Sensors Qt6::Svg)
#! [link-libraries]

install(TARGETS appaccelbubble
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
