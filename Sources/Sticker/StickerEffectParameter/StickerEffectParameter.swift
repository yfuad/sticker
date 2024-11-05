//
//  File.swift
//  Sticker
//
//  Created by Benjamin Pisano on 05/11/2024.
//

import SwiftUI

extension EnvironmentValues {
    @Entry var stickerEffectScale: Float = 1.4
    @Entry var stickerEffectIntensity: Float = 0.8
    @Entry var stickerEffectContrast: Float = 0.9
    @Entry var stickerEffectBlendFactor: Float = 0.4
    @Entry var stickerEffectNoiseScale: Float = 140
    @Entry var stickerEffectNoiseIntensity: Float = 0.1
    @Entry var stickerEffectLightIntensity: Float = 0.3
}

public extension View {
    func stickerEffectScale(_ scale: Float) -> some View {
        environment(\.stickerEffectScale, scale)
    }

    func stickerEffectIntensity(_ intensity: Float) -> some View {
        environment(\.stickerEffectIntensity, intensity)
    }

    func stickerEffectContrast(_ contrast: Float) -> some View {
        environment(\.stickerEffectContrast, contrast)
    }

    func stickerEffectBlendFactor(_ blendFactor: Float) -> some View {
        environment(\.stickerEffectBlendFactor, blendFactor)
    }

    func stickerEffectNoiseScale(_ scale: Float) -> some View {
        environment(\.stickerEffectNoiseScale, scale)
    }

    func stickerEffectNoiseIntensity(_ intensity: Float) -> some View {
        environment(\.stickerEffectNoiseIntensity, intensity)
    }

    func stickerEffectLightIntensity(_ intensity: Float) -> some View {
        environment(\.stickerEffectLightIntensity, intensity)
    }
}
