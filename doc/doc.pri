#####################################################################
# Qt documentation build
#####################################################################

DOCS_GENERATION_DEFINES =
qtPrepareTool(GENERATOR, qhelpgenerator)
qtPrepareTool(QDOC, qdoc)

win32:!win32-g++* {
    unixstyle = false
} else :win32-g++*:isEmpty(QMAKE_SH) {
    unixstyle = false
} else {
    unixstyle = true
}

NEWLINE = $$escape_expand(\\n\\t)
$$unixstyle {
    SET =
    SEP =
} else {
    SET = set
    SEP = $$NEWLINE
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
          publishsubscribe \
          3d \
          qml \
          quick \
          script \ # scripttools
          sensors \
          serviceframework \
          systeminfo \
          svg \
          webkit \
          webkit-examples-and-demos \
          xmlpatterns \
          contacts \
          organizer \
          versit \
          bluetooth

# Pretend there is a doc module. Simplifies things a bit.
QT.doc.sources = $$dirname(PWD)

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
        LOCATIONS += QT_$${module_name}_SOURCES=$$module_value$$SEP

        INCLUDES += QT_$${module_name}_QDOCCONF=modules/qt$${module}.qdocconf$$SEP
        debug : message($$module : $$module_value)
    } else {
        INCLUDES += QT_$${module_name}_QDOCCONF=modules/missing.qdocconf$$SEP
        debug : message($$module not found.)
    }
}

# Input files in the source tree
ONLINE_QDOCCONF = $${QT.doc.sources}/doc/config/qt-build-docs-online.qdocconf

DITA_QDOCCONF = $${QT.doc.sources}/doc/config/qt-ditaxml.qdocconf

OFFLINE_QDOCCONF = $${QT.doc.sources}/doc/config/qt-build-docs.qdocconf

MODULE_ONLINE_QDOCCONF = $${QT.doc.sources}/doc/config/$${MODULE}-online.qdocconf

MODULE_OFFLINE_QDOCCONF = $${QT.doc.sources}/doc/config/$${MODULE}.qdocconf

# Output files in the build tree
QHP_FILE = html/qt.qhp
QCH_FILE = qch/qt.qch

INDEX_FILE = html/qt.index
INDEX_DEST = $$INDEX_DESTDIR/qt.index

MODULE_QHP_FILE = html/$${MODULE}.qhp
MODULE_QCH_FILE = qch/$${MODULE}.qch

MODULE_INDEX_FILE = html/$${MODULE}.index
MODULE_INDEX_DEST = $$INDEX_DESTDIR/$${MODULE}.index

COMMAND_ENV = $$LOCATIONS $$INCLUDES $$SET MODULE_SOURCE_TREE=$${QT.doc.sources}$$SEP $$SET MODULE_BUILD_TREE=$$shadowed($$QT.doc.sources)$$SEP
COMMAND = $$QDOC $$DOCS_GENERATION_DEFINES

# Build rules:

online_docs.commands = $$COMMAND_ENV $$COMMAND $$ONLINE_QDOCCONF

dita_docs.commands = $$COMMAND_ENV $$COMMAND $$DITA_QDOCCONF

docs.commands = $$COMMAND_ENV $$COMMAND $$ONLINE_QDOCCONF

# Install rules

htmldocs.files = html
htmldocs.path = $$[QT_INSTALL_DOCS]
htmldocs.CONFIG += no_check_exist directory no_default_install

docimages.files = src/images
docimages.path = $$[QT_INSTALL_DOCS]/src

QMAKE_EXTRA_TARGETS += online_docs docs dita_docs
INSTALLS += htmldocs docimages

# Rules for QCH docs, which depend on qhelpgenerator
isEmpty(GENERATOR) {
    message("qhelpgenerator is not available. Documentation for use with Qt Assistant and Qt Creator cannot be generated.")
} else {
    qch_docs.commands = ( $$COMMAND_ENV $$COMMAND $$OFFLINE_QDOCCONF && \
                         $$GENERATOR -platform minimal $$QHP_FILE -o $$QCH_FILE)

    qchdocs.files = qch
    qchdocs.path = $$[QT_INSTALL_DOCS]
    qchdocs.CONFIG += no_check_exist directory no_default_install

    QMAKE_EXTRA_TARGETS += qch_docs
    INSTALLS += qchdocs

    docs.commands = $$COMMAND_ENV $$COMMAND $$OFFLINE_QDOCCONF $$NEWLINE \
                     $$GENERATOR -platform minimal $$QHP_FILE -o $$QCH_FILE $$NEWLINE \
                     $$COMMAND_ENV $$COMMAND $$ONLINE_QDOCCONF
}
