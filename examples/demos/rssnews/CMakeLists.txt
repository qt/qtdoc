# Generated from rssnews.pro.

cmake_minimum_required(VERSION 3.14)
project(rssnews LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

if(NOT DEFINED INSTALL_EXAMPLESDIR)
  set(INSTALL_EXAMPLESDIR "examples")
endif()

set(INSTALL_EXAMPLEDIR "${INSTALL_EXAMPLESDIR}/demos/rssnews")

find_package(Qt6 COMPONENTS Core)
find_package(Qt6 COMPONENTS Gui)
find_package(Qt6 COMPONENTS Quick)
find_package(Qt6 COMPONENTS Qml)
find_package(Qt6 COMPONENTS Xml)
find_package(Qt6 COMPONENTS Network)

qt_add_executable(rssnews
    main.cpp
    ../shared/xmllistmodel.cpp
    ../shared/xmllistmodel.h
)

target_link_libraries(rssnews PUBLIC
    Qt::Core
    Qt::Gui
    Qt::Qml
    Qt::Quick
    Qt::Xml
    Qt::Network
)

target_include_directories(rssnews PUBLIC
    ../shared
)

set_target_properties(rssnews PROPERTIES
    WIN32_EXECUTABLE TRUE
    MACOSX_BUNDLE TRUE
    QT_QML_MODULE_VERSION 1.0
    QT_QML_MODULE_URI XmlListModel
)
qt6_qml_type_registration(rssnews)


# Resources:
set(rssnews_resource_files
    "content/BusyIndicator.qml"
    "content/CategoryDelegate.qml"
    "content/NewsDelegate.qml"
    "content/RssFeeds.qml"
    "content/ScrollBar.qml"
    "content/images/Asia.jpg"
    "content/images/Business.jpg"
    "content/images/Entertainment.jpg"
    "content/images/Europe.jpg"
    "content/images/Health.jpg"
    "content/images/Politics.jpg"
    "content/images/Science.jpg"
    "content/images/Sports.jpg"
    "content/images/Technology.jpg"
    "content/images/TopStories.jpg"
    "content/images/USNational.jpg"
    "content/images/World.jpg"
    "content/images/btn_close.png"
    "content/images/busy.png"
    "content/images/scrollbar.png"
    "rssnews.qml"
)

qt6_add_resources(rssnews "rssnews"
    PREFIX
        "/demos/rssnews"
    FILES
        ${rssnews_resource_files}
)

install(TARGETS rssnews
    RUNTIME DESTINATION "${INSTALL_EXAMPLEDIR}"
    BUNDLE DESTINATION "${INSTALL_EXAMPLEDIR}"
    LIBRARY DESTINATION "${INSTALL_EXAMPLEDIR}"
)
