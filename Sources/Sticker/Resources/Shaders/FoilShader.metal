//
//  FoilShader.metal
//  FoilTest
//
//  Created by Benjamin Pisano on 31/10/2024.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

// A helper function to generate pseudo-random noise based on position
float random(float2 uv) {
    return fract(sin(dot(uv.xy, float2(12.9898, 78.233))) * 43758.5453);
}

// Helper function to calculate brightness
float calculateBrightness(half4 color) {
    return (color.r * 0.299 + color.g * 0.587 + color.b * 0.114);
}

float noise(float2 uv) {
    float2 i = floor(uv);
    float2 f = fract(uv);

    // Four corners in 2D of a tile
    float a = random(i);
    float b = random(i + float2(1.0, 0.0));
    float c = random(i + float2(0.0, 1.0));
    float d = random(i + float2(1.0, 1.0));

    // Smooth Interpolation
    float2 u = smoothstep(0.0, 1.0, f);

    // Mix 4 corners percentages
    return mix(a, b, u.x) + (c - a) * u.y * (1.0 - u.x) + (d - b) * u.x * u.y;
}

// Main foil shader function
[[ stitchable ]] half4 foil(float2 position, half4 color, float2 offset, float2 imageSize, float scale, float intensity, float contrast, float blendFactor, float noiseScale, float noiseIntensity) {
    // Normalize the position based on image size to make noise scale uniform
    float2 normalizedPosition = position / (imageSize * scale);

    // Scale the noise based on the normalized position and noiseScale parameter
    float gradientNoise = random(normalizedPosition) * 0.1;

    // Calculate the normalized offsets
    float offsetWeight = 0.002;
    float normalizedOffsetX = normalizedPosition.x + offset.x * offsetWeight;
    float normalizedOffsetY = normalizedPosition.y + offset.y * offsetWeight;

    // Calculate less saturated color shifts for a metallic effect
    half baseIntensity = contrast;
    half r = half(baseIntensity + 0.25 * sin(normalizedOffsetX * 10.0 + gradientNoise));
    half g = half(baseIntensity + 0.25 * cos(normalizedOffsetY * 10.0 + gradientNoise));
    half b = half(baseIntensity + 0.25 * sin((normalizedOffsetX + normalizedOffsetY) * 10.0 - gradientNoise));

    // Apply color shifts to create foil-like iridescence
    half4 foilColor = half4(r, g, b, 1.0);

    // Calculate brightness of the input color
    float brightness = calculateBrightness(color);

    // Determine mix factor based on brightness
    float mixFactor = smoothstep(0.3, 0.7, brightness);

    // Ensure minimum mix factor for black and white colors
    float minMixFactor = blendFactor; // Adjust this value for the minimum foil effect
    mixFactor = max(mixFactor, minMixFactor); // Ensure at least minMixFactor is applied

    // Blend the foil effect with the original color using the adjusted mix factor
    half4 gradient = mix(color, foilColor, mixFactor * intensity); // Mix less for darker colors, more for lighter/vibrant colors

    // Add a noise effect
    float noiseOverlay = noise(position / imageSize * noiseScale);

    return mix(gradient, noiseOverlay, mixFactor * noiseIntensity);
}
