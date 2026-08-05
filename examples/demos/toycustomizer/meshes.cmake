# Copyright (C) 2025 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

set(assets_meshes
    meshes/mesh_022_mesh.mesh
    meshes/mesh_025_mesh.mesh
    meshes/mesh_027_mesh.mesh
    meshes/mesh_029_mesh.mesh
    meshes/mesh_035_mesh.mesh
    meshes/mesh_063_mesh.mesh
    meshes/mesh_076_mesh.mesh
    meshes/mesh_079_mesh.mesh
    meshes/mesh_081_mesh.mesh
    meshes/mesh_094_mesh.mesh
    meshes/mesh_095_mesh.mesh
    meshes/mesh_096_mesh.mesh
    meshes/mesh_097_mesh.mesh
    meshes/mesh_098_mesh.mesh
    meshes/mesh_099_mesh.mesh
    meshes/mesh_100_mesh.mesh
    meshes/mesh_101_mesh.mesh
    meshes/mesh_102_mesh.mesh
    meshes/mesh_103_mesh.mesh
    meshes/mesh_104_mesh.mesh
    meshes/mesh_105_mesh.mesh
    meshes/mesh_106_mesh.mesh
    meshes/mesh_107_mesh.mesh
    meshes/mesh_108_mesh.mesh
    meshes/mesh_109_mesh.mesh
    meshes/mesh_110_mesh.mesh
    meshes/mesh_111_mesh.mesh
    meshes/mesh_112_mesh.mesh
    meshes/mesh_002_mesh.mesh
    meshes/mesh_124_mesh.mesh
    meshes/mesh_mesh.mesh
    meshes/plane_016_mesh.mesh
    meshes/skin_bear.mesh
    meshes/skin_deer.mesh
    meshes/skin_cat.mesh
    meshes/skin_sheep.mesh
    meshes/skin_lion.mesh
    meshes/skin_raccoon.mesh
    meshes/skin_squirrel.mesh
    meshes/skin_monkey.mesh
    meshes/skin_panda.mesh
    meshes/skin_koala.mesh
    meshes/skin_sloth.mesh
    meshes/skin_pig.mesh
    meshes/skin_rabbit.mesh
    meshes/skin_tiger.mesh
    meshes/mesh_003_mesh.mesh
    meshes/mesh_013_mesh.mesh
    meshes/torus_001_mesh.mesh
    meshes/cylinder_009_mesh.mesh
    meshes/plane_018_mesh.mesh
    meshes/empty_003_mesh.mesh
    meshes/empty_mesh.mesh
    meshes/mesh_019_mesh.mesh
    meshes/mesh_011_mesh.mesh
    meshes/cylinder_004_mesh.mesh
    meshes/nvgoggles_mesh.mesh
    meshes/plane_014_mesh.mesh
    meshes/plane_015_mesh.mesh
    meshes/cap_mesh.mesh
    meshes/cylinder_002_mesh.mesh
    meshes/mesh_005_mesh.mesh
    meshes/mesh_006_mesh.mesh
    meshes/mesh_009_mesh.mesh
    meshes/mesh_007_mesh.mesh
    meshes/mesh_010_mesh.mesh
    meshes/mesh_015_mesh.mesh
    meshes/mesh_014_mesh.mesh
    meshes/mesh_016_mesh.mesh
    meshes/empty_001_mesh.mesh
    meshes/mesh_004_mesh.mesh
    meshes/plane_017_mesh.mesh
    meshes/cylinder_001_mesh.mesh
    meshes/cylinder_005_mesh.mesh
    meshes/mesh_012_mesh.mesh
    meshes/cone_mesh.mesh
    meshes/cube_001_mesh.mesh
    meshes/torus_002_mesh.mesh
    meshes/plane_001_mesh.mesh
    meshes/mesh_008_mesh.mesh
)

qt_target_qml_sources(${TARGET_NAME}
    PREFIX "/qt/qml/ToyCustomizer/qml/"
    RESOURCES "${assets_meshes}"
)

set(clean_meshes "${assets_meshes}")
list(TRANSFORM clean_meshes PREPEND "${CMAKE_CURRENT_SOURCE_DIR}/")
set_property(DIRECTORY APPEND PROPERTY ADDITIONAL_CLEAN_FILES "${clean_meshes}")
