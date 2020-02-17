//
//  Basic.metal
//  App
//
//  Created by Tomoya Hirano on 2020/02/17.
//

#include <metal_stdlib>
using namespace metal;

struct ColorInOut {
  float4 position [[ position ]];
  float2 texCoords;
};

vertex ColorInOut vertexShader(device float4 *position [[ buffer(0) ]],
                               device float2 *texCoords [[ buffer(1) ]],
                               uint    vid      [[ vertex_id ]]) {
  ColorInOut out;
  out.position = position[vid];
  out.texCoords = texCoords[vid];
  return out;
}

fragment float4 fragmentShader(ColorInOut in [[ stage_in ]],
                                            texture2d<float> texture [[ texture(0) ]]) {
  constexpr sampler colorSampler;
  return texture.sample(colorSampler, in.texCoords);
}
