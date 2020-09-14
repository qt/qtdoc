# special case skip regeneration

add_library(CMakeDoc INTERFACE)

qt_add_docs(CMakeDoc
            qtcmake.qdocconf
)
