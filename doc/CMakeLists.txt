# special case skip regeneration

add_library(Doc INTERFACE)

qt_internal_add_docs(Doc
                     config/qtdoc.qdocconf
)
