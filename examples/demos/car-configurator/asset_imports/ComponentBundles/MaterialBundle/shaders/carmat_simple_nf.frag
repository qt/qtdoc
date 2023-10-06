precision mediump int;
precision mediump float;

VARYING vec3 vColor;

void MAIN(){
    vec3 fNormal = normalize(VAR_WORLD_NORMAL);
    vec3 fView = normalize(VIEW_VECTOR);
    float fresnelBase = 1.0-max(0.0,dot(fNormal, fView));
    float clearcoatMask = fresnelBase*clearcoat;

    float fresnel = fresnelBase;
    FRESNEL_POWER = 5.0;
    fresnel = pow(fresnel,FRESNEL_POWER);

    NORMAL  = fNormal;

    float specVal = mix(mix(mix(fresnel*specular,specular,specular),1.0,metalness),1.0,clearcoatMask);
    SPECULAR_AMOUNT = specVal*vColor.r;
    vec4 albedo = mix(baseColor, secondaryColor,fresnelBase);
    BASE_COLOR = albedo*vec4(vColor.rrr,1.0);

    vec3 vNormalWsDdx = dFdx(fNormal.xyz);
    vec3 vNormalWsDdy = dFdy(fNormal.xyz);
    float flGeometricRoughnessFactor = pow(clamp(max(dot(vNormalWsDdx, vNormalWsDdx), dot(vNormalWsDdy, vNormalWsDdy)), 0.0, 1.0),0.333);
    METALNESS = mix(metalness,0.0,clearcoatMask);
    ROUGHNESS = mix(mix(mix(roughness,0.0,fresnel),0.0,clearcoatMask),1.0,flGeometricRoughnessFactor);
}
