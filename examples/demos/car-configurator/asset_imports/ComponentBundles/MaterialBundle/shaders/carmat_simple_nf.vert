precision mediump int;
precision mediump float;

VARYING vec3 vColor;

void MAIN(){
    vColor = mix(vec3(1.0),COLOR.rgb, vcoloron);
}
