TEMPLATE = subdirs 
SUBDIRS = doc # demos

# Doc rules

online_docs.CONFIG = recursive
online_docs.recurse_target = online_docs
online_docs.recurse = doc

dita_docs.CONFIG = recursive
dita_docs.recurse_target = dita_docs
dita_docs.recurse = doc

qch_docs.CONFIG = recursive
qch_docs.recurse_target = qch_docs
qch_docs.recurse = doc

docs.CONFIG = recursive
docs.recurse_target = docs
docs.recurse = doc

QMAKE_EXTRA_TARGETS += online_docs qch_docs docs dita_docs

