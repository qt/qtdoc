TEMPLATE = subdirs
QT_FOR_CONFIG += qml-private

qtConfig(private_tests): \
    SUBDIRS += qqmlparser

