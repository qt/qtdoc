#####################################################################
# Qt documentation build
#####################################################################

DOCS_GENERATION_DEFINES =
GENERATOR = $${QT.help.bins}/qhelpgenerator
MODULE = qtdoc

win32:!win32-g++* {
    unixstyle = false
} else :win32-g++*:isEmpty(QMAKE_SH) {
    unixstyle = false
} else {
    unixstyle = true
}

$$unixstyle {
    SET =
    SEP =
} else {
    SET = set
    SEP = &&
}

# The module names correspond to the names of files in qtbase/mkspecs/modules
# that take the form qt_<module>.pri. This is why we see clucene, not qttools,
# and systeminfo, not systems.

MODULES = activeqt \
          core \ # dbus gui network opengl openvg sql testlib uilib uitools xml
          declarative \
          doc \
          clucene \ # help designer
          location \
          multimedia \
          phonon \
          publishsubscribe \
          script \ # scripttools
          sensors \
          serviceframework \
          systeminfo \
          svg \
          webkit \
          webkit-examples-and-demos \
          xmlpatterns \
          qt3support \
          contacts \
          organizer \
          versit

# Compile a list of location definitions for each of the modules and a list of
# qdocconf files to include.

LOCATIONS =
INCLUDES =
for(module, MODULES) {

    INCLUDES += $$SET

    # Take the module name and convert it to the name of the variable that
    # contains the sources path, which takes the form, QT.<module name>.sources.

    module_name = $$upper($$module)
    module_name = $$replace(module_name, "-", "_")
    module_value = $$eval(QT.$$replace(module, "-", "_").sources)
    !isEmpty(module_value) {
        LOCATIONS += $$SET
        LOCATIONS += QT_$${module_name}_SOURCES=$$module_value
        LOCATIONS += $$SEP

        INCLUDES += QT_$${module_name}_QDOCCONF=modules/qt$${module}.qdocconf
        debug : message($$module : $$module_value)
    } else {
        INCLUDES += QT_$${module_name}_QDOCCONF=modules/missing.qdocconf
        debug : message($$module not found.)
    }
    INCLUDES += $$SEP
}

# Output the locations and includes as build messages. This helps the user to
# see which modules have been installed and diagnose any problems.

message($$LOCATIONS)
message($$INCLUDES)

# Input files in the source tree
ONLINE_QDOCCONF = $${QT.doc.sources}/doc/config/qt-build-docs-online.qdocconf
ONLINE_QDOCCONF = $$replace(ONLINE_QDOCCONF, "/", $$QMAKE_DIR_SEP)

DITA_QDOCCONF = $${QT.doc.sources}/doc/config/qt-ditaxml.qdocconf
DITA_QDOCCONF = $$replace(DITA_QDOCCONF, "/", $$QMAKE_DIR_SEP)

OFFLINE_QDOCCONF = $${QT.doc.sources}/doc/config/qt-build-docs.qdocconf
OFFLINE_QDOCCONF = $$replace(OFFLINE_QDOCCONF, "/", $$QMAKE_DIR_SEP)

MODULE_ONLINE_QDOCCONF = $${QT.doc.sources}/doc/config/$${MODULE}-online.qdocconf
MODULE_ONLINE_QDOCCONF = $$replace(ONLINE_QDOCCONF, "/", $$QMAKE_DIR_SEP)

MODULE_OFFLINE_QDOCCONF = $${QT.doc.sources}/doc/config/$${MODULE}.qdocconf
MODULE_OFFLINE_QDOCCONF = $$replace(OFFLINE_QDOCCONF, "/", $$QMAKE_DIR_SEP)

# Output files in the build tree
QHP_FILE = html/qt.qhp
QHP_FILE = $$replace(QHP_FILE, "/", $$QMAKE_DIR_SEP)
QCH_FILE = qch/qt.qch
QCH_FILE = $$replace(QCH_FILE, "/", $$QMAKE_DIR_SEP)

INDEX_FILE = html/qt.index
INDEX_FILE = $$replace(INDEX_FILE, "/", $$QMAKE_DIR_SEP)
INDEX_DEST = $$INDEX_DESTDIR/qt.index
INDEX_DEST = $$replace(INDEX_DEST, "/", $$QMAKE_DIR_SEP)

MODULE_QHP_FILE = html/$${MODULE}.qhp
MODULE_QHP_FILE = $$replace(QHP_FILE, "/", $$QMAKE_DIR_SEP)
MODULE_QCH_FILE = qch/$${MODULE}.qch
MODULE_QCH_FILE = $$replace(QCH_FILE, "/", $$QMAKE_DIR_SEP)

MODULE_INDEX_FILE = html/$${MODULE}.index
MODULE_INDEX_FILE = $$replace(INDEX_FILE, "/", $$QMAKE_DIR_SEP)
MODULE_INDEX_DEST = $$INDEX_DESTDIR/$${MODULE}.index
MODULE_INDEX_DEST = $$replace(INDEX_DEST, "/", $$QMAKE_DIR_SEP)

$$unixstyle {
    QDOC = $$LOCATIONS $$INCLUDES MODULE_SOURCE_TREE=$${QT.doc.sources} MODULE_BUILD_TREE=$$MODULE_BUILD_DIR $$QT.doc.bins/qdoc3 $$DOCS_GENERATION_DEFINES
} else {
    QDOC = $$LOCATIONS $$INCLUDES set MODULE_SOURCE_TREE=$${QT.doc.sources} && set MODULE_BUILD_TREE=$$MODULE_BUILD_DIR && $$QT.doc.bins/qdoc3.exe $$DOCS_GENERATION_DEFINES
    QDOC = $$replace(QDOC, "/", $$QMAKE_DIR_SEP)
}

# Build rules:

online_docs.commands = ($$QDOC $$ONLINE_QDOCCONF)

dita_docs.commands = ($$QDOC $$DITA_QDOCCONF)

qch_docs.commands = ($$QDOC $$OFFLINE_QDOCCONF && \
                     $$GENERATOR -platform minimal $$QHP_FILE -o $$QCH_FILE)

docs.commands = ($$QDOC $$OFFLINE_QDOCCONF && \
                 $$GENERATOR -platform minimal $$QHP_FILE -o $$QCH_FILE && \
                 $$QDOC $$ONLINE_QDOCCONF)

# Install rules

htmldocs.files = html
htmldocs.path = $$[QT_INSTALL_DOCS]
htmldocs.CONFIG += no_check_exist directory

qchdocs.files= qch
qchdocs.path = $$[QT_INSTALL_DOCS]
qchdocs.CONFIG += no_check_exist directory

docimages.files = src/images
docimages.path = $$[QT_INSTALL_DOCS]/src

QMAKE_EXTRA_TARGETS += online_docs qch_docs docs dita_docs
INSTALLS += htmldocs qchdocs docimages

