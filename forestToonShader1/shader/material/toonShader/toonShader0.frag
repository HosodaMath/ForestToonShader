precision highp float;
precision highp int;
uniform vec2 uResolution;
uniform vec2 uMouse;
uniform float uTime;
uniform vec3 lightNormal[8];
varying vec4 vTexCoord;
varying vec3 vNormal;
// varying vec3 vLightDir;
const float PI2 = 6.28318530718;
const float TAU = PI2;

void main(){

  vec2 uv = vTexCoord.xy;

   // 逆ライトベクトル
  vec3 invertLightVec = -lightNormal[0];

  float intensity = max(0.0, dot(invertLightVec, vNormal));
  vec3 bgColor = vec3(0.0, 0.0, 0.0);

  if(intensity > 0.95){
    bgColor = vec3(1.0, 1.0, 0.5);
  } else if(intensity > 0.5){
    bgColor = vec3(0.5, 1.0, 1.0);
  } else if(intensity > 0.25){
    bgColor = vec3(0.2, 0.5, 1.0);
  } else {
    bgColor = vec3(0.0, 0.0, 0.5);
  }

  gl_FragColor = vec4(bgColor, 1.0);
}