add_subdirectory(asset_imports)
add_subdirectory(content)
add_subdirectory(imports)

target_link_libraries(CarRenderingApp PRIVATE
    CarConfiguratorContentplugin
    CarRenderingplugin
    Quick3DAssets_EV_SportsCar_lowplugin
    Quick3DAssets_InteriorShadowplugin
    Quick3DAssets_LightDecalplugin
    Quick3DAssets_Pebblesplugin
    Quick3DAssets_ShadowPlaneplugin
    Quick3DAssets_Venodhbplugin
    Quick3DAssets_Ventdeeplugin
)
