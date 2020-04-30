# Generated from qqmlparser.pro.

#####################################################################
## tst_qqmlparser Test:
#####################################################################

qt_add_test(tst_qqmlparser
    SOURCES
        tst_qqmlparser.cpp
    DEFINES
        SRCDIR=\\\"${CMAKE_CURRENT_SOURCE_DIR}\\\"
    PUBLIC_LIBRARIES
        Qt::Gui
        Qt::QmlPrivate
)

## Scopes:
#####################################################################

qt_extend_target(tst_qqmlparser CONDITION CMAKE_CROSSCOMPILING
    DEFINES
        QTEST_CROSS_COMPILED
)
