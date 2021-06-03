TEMPLATE = app

QT += qml quick
# qtHaveModule(multimedia): QT += multimedia  //QTBUG-94183
SOURCES += main.cpp
RESOURCES += maroon.qrc

target.path = $$[QT_INSTALL_EXAMPLES]/demos/maroon
INSTALLS += target
