TEMPLATE = app

QT += qml quick xmlpatterns
CONFIG += lrelease embed_translations

SOURCES += main.cpp

lupdate_only {
SOURCES = *.qml \
          PhotoViewerCore/*.qml \
          PhotoViewerCore/script/*.js
}

TRANSLATIONS += i18n/qml_fr.ts \
                i18n/qml_de.ts

RESOURCES += qml.qrc

target.path = $$[QT_INSTALL_EXAMPLES]/demos/photoviewer
INSTALLS += target
