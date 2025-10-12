# Copyright (C) 2025 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

set(asset_url "https://download.qt.io/learning/examples/toy-customizer-assets.zip")
set(asset_file "${CMAKE_BINARY_DIR}/.assets/toy-customizer-assets.zip")
set(asset_extract_dir "${CMAKE_SOURCE_DIR}")
set(asset_contents animations fonts images meshes)

set_property(DIRECTORY APPEND PROPERTY ADDITIONAL_CLEAN_FILES ${asset_file})

if(NOT EXISTS ${asset_file})
  message(STATUS "Downloading asset file...")
  file(DOWNLOAD
    ${asset_url} ${asset_file}
    STATUS asset_status
    TLS_VERIFY ON
  )
  list(GET asset_status 0 asset_status_code)
  if (asset_status_code EQUAL 0)
    message(STATUS "Downloading asset file done.")
  else()
    if(EXISTS "${asset_file}")
      file(REMOVE "${asset_file}")
    endif()
    list(GET asset_status 1 asset_status_message)
    message(FATAL_ERROR "Downloading asset file failed:\n  error: ${asset_status_message}")
  endif()
  message(STATUS "Extracting asset file...")
  file(MAKE_DIRECTORY ${asset_extract_dir})
  file(ARCHIVE_EXTRACT
    INPUT ${asset_file}
    DESTINATION ${asset_extract_dir})
  message(STATUS "Extracting asset file done.")
else()
  message(STATUS "Download asset file skipped: already exists.")
endif()

add_custom_target(assets_complete ALL
  COMMENT "Download and copy assets"
)
