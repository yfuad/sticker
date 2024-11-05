//
//  StickerEffectParameter.swift
//  Sticker
//
//  Created by Benjamin Pisano on 05/11/2024.
//

import SwiftUI

extension EnvironmentValues {
    @Entry var stickerScale: Float = 1.4
    @Entry var stickerIntensity: Float = 0.8
    @Entry var stickerContrast: Float = 0.9
    @Entry var stickerBlend: Float = 0.4
    @Entry var stickerNoiseScale: Float = 140
    @Entry var stickerNoiseIntensity: Float = 0.1
    @Entry var stickerLightIntensity: Float = 0.3
}

extension View {
    public func stickerScale(_ scale: Float) -> some View {
        environment(\.stickerScale, scale)
    }

    public func stickerIntensity(_ intensity: Float) -> some View {
        environment(\.stickerIntensity, intensity)
    }

    public func stickerContrast(_ contrast: Float) -> some View {
        environment(\.stickerContrast, contrast)
    }

    public func stickerBlend(_ blendFactor: Float) -> some View {
        environment(\.stickerBlend, blendFactor)
    }

    public func stickerNoiseScale(_ scale: Float) -> some View {
        environment(\.stickerNoiseScale, scale)
    }

    public func stickerNoiseIntensity(_ intensity: Float) -> some View {
        environment(\.stickerNoiseIntensity, intensity)
    }

    public func stickerLightIntensity(_ intensity: Float) -> some View {
        environment(\.stickerLightIntensity, intensity)
    }
}
