precision highp float;
precision highp int;
uniform float uTime;
const float alpha = 1.0;
const float PI2 = 6.28318530718;
const float TAU = PI2;

varying vec4 vTexCoord;
varying vec3 vNormal;

vec2 waveEffect(vec2 coord){
  coord.x += 0.0035 * sin(coord.x * 100.0 + uTime * TAU);
  coord.x += 0.0015 * cos(coord.x * 250.0 + uTime * TAU);
  
  coord.y += 0.0035 * sin(coord.y * 100.0 + uTime * TAU);
  coord.y += 0.0015 * cos(coord.y * 250.0 + uTime * TAU);
  
  return coord;
}


vec3 fade(vec3 x){
  vec3 result = x * x * x * (x * (x * 6.0 - 15.0) + 10.0);

  return result;
}

// 3次元乱数
vec3 random3(vec3 p){
  p = fract(mat3(1.2989833, 7.8233198, 2.3562332,
                  6.7598192, 3.4857334, 8.2837193,
                   2.9175399, 2.9884245, 5.4987265) * p);
    p = ((2384.2345 * p - 1324.3438) * p + 3884.2243) * p - 4921.2354;
    return normalize(fract(p) * 2.0 - 1.0);
}

// 3次元ノイズ
float noiseValue3(vec3 p)
{
    vec3 ip = floor(p);
    vec3 fp = fract(p);
    float d000 = dot(random3(ip), fp);
    float d001 = dot(random3(ip + vec3(0.0, 0.0, 1.0)), fp - vec3(0.0, 0.0, 1.0));
    float d010 = dot(random3(ip + vec3(0.0, 1.0, 0.0)), fp - vec3(0.0, 1.0, 0.0));
    float d011 = dot(random3(ip + vec3(0.0, 1.0, 1.0)), fp - vec3(0.0, 1.0, 1.0));
    float d100 = dot(random3(ip + vec3(1.0, 0.0, 0.0)), fp - vec3(1.0, 0.0, 0.0));
    float d101 = dot(random3(ip + vec3(1.0, 0.0, 1.0)), fp - vec3(1.0, 0.0, 1.0));
    float d110 = dot(random3(ip + vec3(1.0, 1.0, 0.0)), fp - vec3(1.0, 1.0, 0.0));
    float d111 = dot(random3(ip + vec3(1.0, 1.0, 1.0)), fp - vec3(1.0, 1.0, 1.0));
    fp = fade(fp);
    return mix(mix(mix(d000, d001, fp.z), mix(d010, d011, fp.z), fp.y),
              mix(mix(d100, d101, fp.z), mix(d110, d111, fp.z), fp.y), fp.x);
}

// 3次元フラクタルブラウン運動
float fbm3(vec3 value){
  const int Max = 5;
  float result = 0.0;
  float amp = 0.5;
  for(int i = 0; i < Max; i++){
    result += amp * noiseValue3(value);
    value *= 2.01;
    amp *= 0.5;
  }

  return result;
}

vec3 rgbShift(vec2 uv){
  
  vec3 fbmValue1 = vec3(gl_FragCoord.xy * 10.0 / uv.y, uTime * 0.05);
  float n1 = fbm3(fbmValue1) / 2.0 + 0.5;
  
  vec3 fbmValue2 = vec3(gl_FragCoord.xy * 10.0 / uv.y, uTime * 0.05);
  float n2 = fbm3(fbmValue2) / 2.0 + 0.5;
  
  vec3 fbmValue3 = vec3(gl_FragCoord.xy * 10.0 / uv.y, uTime * 0.05);
  float n3 = fbm3(fbmValue3) / 2.0 + 0.5;
  
  vec3 fbmValue = vec3(n1, n2, n3);

  return vec3(smoothstep(0.5, 0.6, fbmValue));
}

/*
  color(t) = a + b * cos(2pi(c * t + d))
*/
vec3 palette1(vec3 a, vec3 b, vec3 c, vec3 d, float t){
  return a + b * cos(PI2 * (c * t + d));
}

/*
  color(t) = a + b * sin(2pi(c * t + d))
*/
vec3 palette2(vec3 a, vec3 b, vec3 c, vec3 d, float t){
  return a + b * sin(PI2 * (c * t + d));
}

float hexagon(vec2 uv, float r){
  const vec3 k = vec3(-0.866025404,0.5,0.577350269);
  uv = abs(uv);
  uv -= 2.0 * min(dot(k.xy, uv), 0.0) * k.xy;
  uv -= vec2(clamp(uv.x, -k.z * r, k.z * r), r);

  return length(uv) * sign(uv.y);
}


void main(void){
  vec2 uv = vTexCoord.xy;

  vec3 color1 = palette2(
    vec3(0.5, 0.5, 0.5), 
    vec3(0.5, 0.5, 0.5), 
    vec3(1.0, 1.0, 1.0), 
    vec3(0.0, 0.333, 0.666),
    hexagon(uv, 0.5)
  );

  vec3 color2 = palette2(
    vec3(0.0, 0.5, 0.5), 
    vec3(0.0, 0.5, 0.5), 
    vec3(1.0, 1.0, 1.0), 
    vec3(0.0, 0.0, 0.2), 
    hexagon(uv, 0.5)
  );

  vec3 bgColor = rgbShift(uv);
  bgColor += mix(color1, color2, hexagon(uv, 0.5));
  

  gl_FragColor = vec4(bgColor, 1.0);
}