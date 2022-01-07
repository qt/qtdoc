# special case skip regeneration

add_library(QtDoc INTERFACE)

qt_internal_add_docs(QtDoc
                     config/qtdoc.qdocconf
)
