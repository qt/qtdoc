qt_add_library(Quick3DAssets_EV_SportsCar_low STATIC)

qt_add_qml_module(Quick3DAssets_EV_SportsCar_low
    URI "Quick3DAssets.EV_SportsCar_low"
    CLASS_NAME "SportsCarPlugin"
    VERSION 1.0
    RESOURCE_PREFIX "/qt/qml"
    QML_FILES
        Ev_SportsCar_low.qml
)
