//
//  ShaderLibraryExtension.swift
//  Sticker
//
//  Created by Benjamin Pisano on 03/11/2024.
//

import SwiftUI

extension ShaderLibrary {
    static var moduleLibrary: ShaderLibrary { .bundle(.module) }

    static func foilShader(
        offset: CGPoint = .zero,
        size: CGSize = .zero,
        scale: Float = 1.4,
        intensity: Float = 0.8,
        contrast: Float = 0.9,
        blendFactor: Float = 0.4,
        noiseScale: Float = 140,
        noiseIntensity: Float = 0.1
    ) -> Shader {
        moduleLibrary.foil(
            .float2(offset),
            .float2(size),
            .float(scale),
            .float(intensity),
            .float(contrast),
            .float(blendFactor),
            .float(noiseScale),
            .float(noiseIntensity)
        )
    }

    static func reflectionShader(
        size: CGSize = .zero,
        reflectionPosition: CGPoint = .zero,
        reflectionSize: Float = 0,
        reflectionIntensity: Float = 0
    ) -> Shader {
        moduleLibrary.reflection(
            .float2(size),
            .float2(reflectionPosition),
            .float(reflectionSize),
            .float(reflectionIntensity)
        )
    }

    @available(iOS 18.0, macOS 15.0, visionOS 2.0, tvOS 18.0, watchOS 11.0, *)
    static func compileStickerShaders() async throws {
        try await foilShader().compile(as: .colorEffect)
        try await reflectionShader().compile(as: .colorEffect)
    }
}
