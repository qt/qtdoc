TEMPLATE = subdirs 
SUBDIRS = doc # demos

# Doc rules

UPDATE_PRI = "echo \"MODULE_BUILD_DIR=$$OUT_PWD\" > $$OUT_PWD/qtdoc.pri"
UPDATE_PRI = $$replace(UPDATE_PRI, "/", $$QMAKE_DIR_SEP)
system($$UPDATE_PRI)
force_qmake.commands = $$UPDATE_PRI

online_docs.CONFIG = recursive
online_docs.recurse_target = online_docs
online_docs.recurse = doc
online_docs.depends += force_qmake

dita_docs.CONFIG = recursive
dita_docs.recurse_target = dita_docs
dita_docs.recurse = doc
dita_docs.depends += force_qmake

qch_docs.CONFIG = recursive
qch_docs.recurse_target = qch_docs
qch_docs.recurse = doc
qch_docs.depends += force_qmake

docs.CONFIG = recursive
docs.recurse_target = docs
docs.recurse = doc
docs.depends += force_qmake

QMAKE_EXTRA_TARGETS += force_qmake online_docs qch_docs docs dita_docs

