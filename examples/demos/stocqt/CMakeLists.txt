# Generated from stocqt.pro.

cmake_minimum_required(VERSION 3.14)
project(stocqt LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

if(NOT DEFINED INSTALL_EXAMPLESDIR)
  set(INSTALL_EXAMPLESDIR "examples")
endif()

set(INSTALL_EXAMPLEDIR "${INSTALL_EXAMPLESDIR}/demos/stocqt")

find_package(Qt6 COMPONENTS Core)
find_package(Qt6 COMPONENTS Gui)
find_package(Qt6 COMPONENTS Qml)
find_package(Qt6 COMPONENTS Quick)

qt_add_executable(stocqt
    main.cpp
)
set_target_properties(stocqt PROPERTIES
    WIN32_EXECUTABLE TRUE
    MACOSX_BUNDLE TRUE
)
target_link_libraries(stocqt PUBLIC
    Qt::Core
    Qt::Gui
    Qt::Qml
    Qt::Quick
)


# Resources:
set(stocqt_resource_files
    "content/+windows/Settings.qml"
    "content/Banner.qml"
    "content/Button.qml"
    "content/CheckBox.qml"
    "content/Settings.qml"
    "content/StockChart.qml"
    "content/StockInfo.qml"
    "content/StockListDelegate.qml"
    "content/StockListModel.qml"
    "content/StockListView.qml"
    "content/StockModel.qml"
    "content/StockSettingsPanel.qml"
    "content/StockView.qml"
    "content/data/AAPL.csv"
    "content/data/ADSK.csv"
    "content/data/AMD.csv"
    "content/data/AMZN.csv"
    "content/data/CSCO.csv"
    "content/data/EA.csv"
    "content/data/EBAY.csv"
    "content/data/FB.csv"
    "content/data/GOOG.csv"
    "content/data/GOOGL.csv"
    "content/data/INTC.csv"
    "content/data/MSFT.csv"
    "content/data/NCLH.csv"
    "content/data/NFLX.csv"
    "content/data/NTAP.csv"
    "content/data/NVDA.csv"
    "content/data/PYPL.csv"
    "content/data/QCOM.csv"
    "content/data/TSLA.csv"
    "content/data/TXN.csv"
    "content/images/icon-left-arrow.png"
    "content/images/wheel-touch.png"
    "content/images/wheel.png"
    "content/qmldir"
    "stocqt.qml"
)

qt6_add_resources(stocqt "stocqt"
    PREFIX
        "/demos/stocqt"
    FILES
        ${stocqt_resource_files}
)

install(TARGETS stocqt
    RUNTIME DESTINATION "${INSTALL_EXAMPLEDIR}"
    BUNDLE DESTINATION "${INSTALL_EXAMPLEDIR}"
    LIBRARY DESTINATION "${INSTALL_EXAMPLEDIR}"
)
