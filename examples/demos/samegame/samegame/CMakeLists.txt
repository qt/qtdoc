add_subdirectory(content)

qt_add_qml_module(samegamebase
    STATIC
    URI samegame
    QML_FILES
        samegame.qml
)
