# special case skip regeneration

add_library(qtcmake INTERFACE)

qt_internal_add_docs(qtcmake
                     qtcmake.qdocconf
)
