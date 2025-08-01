set_source_files_properties(Constants.qml
    PROPERTIES
        QT_QML_SINGLETON_TYPE true
)

qt_add_library(PocketDemo STATIC)
qt_add_qml_module(PocketDemo
    URI "PocketDemo"
    VERSION 1.0
    QML_FILES
        Constants.qml
)
