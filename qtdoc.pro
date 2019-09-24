load(qt_parts)

cmake.file = doc/src/cmake/cmake.pro

doc.file = doc/doc.pro
doc.depends = cmake

SUBDIRS += doc cmake

