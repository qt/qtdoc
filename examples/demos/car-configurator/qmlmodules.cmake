add_subdirectory(asset_imports)
add_subdirectory(content)
add_subdirectory(imports)

target_link_libraries(CarRenderingApp PRIVATE
    CarConfiguratorContentplugin
    CarRenderingplugin
    CarRenderingMaterialBundleplugin
    Quick3DAssets_EV_SportsCar_lowplugin
    Quick3DAssets_Hoodplugin
    Quick3DAssets_InteriorShadowplugin
    Quick3DAssets_LightDecalplugin
    Quick3DAssets_Pebblesplugin
    Quick3DAssets_ShadowPlaneplugin
    Quick3DAssets_Uk5ofdeplugin
    Quick3DAssets_Uk5pebvplugin
    Quick3DAssets_Ulbrbdtplugin
    Quick3DAssets_Venodhbplugin
    Quick3DAssets_Ventdeeplugin
)
