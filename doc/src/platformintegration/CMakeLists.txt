# special case skip regeneration

add_library(PlatformIntegrationDoc INTERFACE)

qt_internal_add_docs(PlatformIntegrationDoc
                     qtplatformintegration.qdocconf
)
