# Generated from qqmlparser.pro.

#####################################################################
## tst_qqmlparser Test:
#####################################################################

qt_internal_add_test(tst_qqmlparser_doc # special case
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

qt_internal_extend_target(tst_qqmlparser_doc CONDITION CMAKE_CROSSCOMPILING # special case
    DEFINES
        QTEST_CROSS_COMPILED
)
