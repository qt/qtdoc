CONFIG += testcase
TARGET = tst_qqmlparser
QT += qml-private testlib
macos:CONFIG -= app_bundle

SOURCES += tst_qqmlparser.cpp
DEFINES += SRCDIR=\\\"$$PWD\\\"

cross_compile: DEFINES += QTEST_CROSS_COMPILED
