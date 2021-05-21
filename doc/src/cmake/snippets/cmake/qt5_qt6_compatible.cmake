#! [versionless_targets]
find_package(Qt6 COMPONENTS Widgets)
if (NOT Qt6_FOUND)
    find_package(Qt5 5.15 COMPONENTS Core REQUIRED)

add_executable(helloworld
    ...
)

target_link_libraries(helloworld PRIVATE Qt::Core)
#! [versionless_targets]

#! [older_qt_versions]
find_package(QT NAMES Qt6 Qt5 COMPONENTS Core REQUIRED)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Core REQUIRED)

add_executable(helloworld
    ...
)

target_link_libraries(helloworld PRIVATE Qt${QT_VERSION_MAJOR}::Core)
#! [older_qt_versions]

#! [disable_unicode_defines]

find_package(Qt6 COMPONENTS Core)

add_executable(helloworld
    ...
)

qt_disable_unicode_defines(helloworld)

#! [disable_unicode_defines]
