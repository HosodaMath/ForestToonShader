precision highp float;
precision highp int;
uniform vec2 uResolution;
uniform vec2 uMouse;
uniform float uTime;
varying vec4 vTexCoord;
varying vec3 vNormal;
const float PI2 = 6.28318530718;
const float TAU = PI2;

void main(){

  vec2 uv = vTexCoord.xy;

  vec3 bgColor = vNormal;

  gl_FragColor = vec4(bgColor, 1.0);
}