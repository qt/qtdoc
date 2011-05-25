#####################################################################
# Qt documentation build
#####################################################################

DOCS_GENERATION_DEFINES =
GENERATOR = $$QT_BUILD_TREE/bin/qhelpgenerator
MODULE = qtdoc

win32:!win32-g++* {
    unixstyle = false
} else :win32-g++*:isEmpty(QMAKE_SH) {
    unixstyle = false
} else {
    unixstyle = true
}

$$unixstyle {
    QDOC = cd doc/config && QT_BUILD_TREE=$$QT_BUILD_TREE QT_SOURCE_TREE=$$QT_SOURCE_TREE $$QT_BUILD_TREE/bin/qdoc3 $$DOCS_GENERATION_DEFINES
} else {
    QDOC = cd doc/config && set QT_BUILD_TREE=$$QT_BUILD_TREE && set QT_SOURCE_TREE=$$QT_SOURCE_TREE && $$QT_BUILD_TREE/bin/qdoc3.exe $$DOCS_GENERATION_DEFINES
    QDOC = $$replace(QDOC, "/", "\\")
}

QT_ONLINE_DOCUMENTATION = ($$QDOC $${MODULE}-online.qdocconf)

QT_DOCUMENTATION = ($$QDOC $${MODULE}.qdocconf) && \
               (cd $$QT_BUILD_TREE && \
                $$GENERATOR doc/html/qt.qhp -o doc/qch/qt.qch)

#QT_ZH_CN_DOCUMENTATION = ($$QDOC qt-api-only_zh_CN.qdocconf) && \
#               (cd $$QT_BUILD_TREE && \
#                    $$GENERATOR doc-build/html-qt_zh_CN/qt.qhp -o doc/qch/qt_zh_CN.qch \
#               )

#QT_JA_JP_DOCUMENTATION = ($$QDOC qt-api-only_ja_JP.qdocconf) && \
#               (cd $$QT_BUILD_TREE && \
#                    $$GENERATOR doc-build/html-qt_ja_JP/qt.qhp -o doc/qch/qt_ja_JP.qch \
#               )

win32-g++*:isEmpty(QMAKE_SH) {
	QT_DOCUMENTATION = $$replace(QT_DOCUMENTATION, "/", "\\\\")
#	QT_ZH_CN_DOCUMENTATION = $$replace(QT_ZH_CN_DOCUMENTATION, "/", "\\\\")
#	QT_JA_JP_DOCUMENTATION = $$replace(QT_JA_JP_DOCUMENTATION, "/", "\\\\")
}

# Build rules:
online_docs.commands = $$QT_ONLINE_DOCUMENTATION
online_docs.depends += sub-qdoc3 # qdoc3
qch_docs.commands = $$QT_DOCUMENTATION
qch_docs.depends += sub-qdoc3

docs.depends = sub-qdoc3 online_docs qch_docs

#docs_zh_CN.depends = docs
#docs_zh_CN.commands = $$QT_ZH_CN_DOCUMENTATION

#docs_ja_JP.depends = docs
#docs_ja_JP.commands = $$QT_JA_JP_DOCUMENTATION

# Install rules
htmldocs.files = $$QT_BUILD_TREE/doc/html
htmldocs.path = $$[QT_INSTALL_DOCS]
htmldocs.CONFIG += no_check_exist directory

qchdocs.files= $$QT_BUILD_TREE/doc/qch
qchdocs.path = $$[QT_INSTALL_DOCS]
qchdocs.CONFIG += no_check_exist directory

docimages.files = $$QT_BUILD_TREE/doc/src/images
docimages.path = $$[QT_INSTALL_DOCS]/src

#sub-qdoc3.depends = sub-corelib sub-xml
sub-qdoc3.commands += (cd tools/qdoc3 && $(MAKE))

QMAKE_EXTRA_TARGETS += sub-qdoc3 online_docs qch_docs docs # docs_zh_CN docs_ja_JP
INSTALLS += htmldocs qchdocs docimages
