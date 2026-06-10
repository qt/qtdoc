add_library(csv INTERFACE)

target_compile_definitions(csv INTERFACE CSV_ENABLE_THREADS=0)
target_include_directories(csv INTERFACE ..)
