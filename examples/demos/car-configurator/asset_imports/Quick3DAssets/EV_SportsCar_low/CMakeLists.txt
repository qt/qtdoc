qt_add_library(Ast_SportsCar STATIC)

qt_add_qml_module(Ast_SportsCar
    URI "Quick3DAssets.EV_SportsCar_low"
    CLASS_NAME "SportsCarPlugin"
    RESOURCE_PREFIX "/qt/qml"
    QML_FILES
        Ev_SportsCar_low.qml
        Hood.qml
        MyDoorLeft.qml
        MyDoorRight.qml
        TrunkLid.qml
)
