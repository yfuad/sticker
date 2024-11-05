//
//  StickerEffect.swift
//  Sticker
//
//  Created by Benjamin Pisano on 03/11/2024.
//

import SwiftUI

private struct StickerEffectViewModifier: ViewModifier {
    @State private var motion: StickerMotion = .init()

    @Environment(\.stickerMotionEffect) private var effect
    @Environment(\.stickerScale) private var stickerScale
    @Environment(\.stickerIntensity) private var stickerIntensity
    @Environment(\.stickerContrast) private var stickerContrast
    @Environment(\.stickerBlend) private var stickerBlend
    @Environment(\.stickerNoiseScale) private var stickerNoiseScale
    @Environment(\.stickerNoiseIntensity) private var stickerNoiseIntensity
    @Environment(\.stickerLightIntensity) private var stickerLightIntensity

    func body(content: Content) -> some View {
        content
            .visualEffect {
                [
                    motion, stickerScale, stickerIntensity, stickerContrast, stickerBlend,
                    stickerNoiseScale, stickerNoiseIntensity
                ] view, proxy in
                view
                    .colorEffect(
                        ShaderLibrary.foilShader(
                            offset: motion.isActive
                                ? (motion.transform * -150).point : StickerTransform.neutral.point,
                            size: proxy.size,
                            scale: stickerScale,
                            intensity: stickerIntensity,
                            contrast: stickerContrast,
                            blendFactor: stickerBlend,
                            noiseScale: stickerNoiseScale,
                            noiseIntensity: stickerNoiseIntensity
                        )
                    )
            }
            .visualEffect { [motion, stickerLightIntensity] view, proxy in
                view
                    .colorEffect(
                        ShaderLibrary.reflectionShader(
                            size: proxy.size,
                            reflectionPosition: CGPoint(
                                x: motion.transform.x,
                                y: motion.transform.y
                            ),
                            reflectionSize: Float(min(proxy.size.width, proxy.size.height) / 2),
                            reflectionIntensity: motion.isActive ? stickerLightIntensity : 0
                        )
                    )
            }
            .mask(content)
            .rotation3DEffect(
                motion.isActive ? .radians(motion.transform.x - 0.5) : .degrees(0),
                axis: (0, 1, 0)
            )
            .rotation3DEffect(
                motion.isActive ? .radians(motion.transform.y - 0.5) : .degrees(0),
                axis: (-1, 0, 0)
            )
            .stickerTransformation(effect)
            .onStickerMotionChange { motion in
                self.motion = motion
            }
    }
}

extension View {
    @ViewBuilder
    public func stickerEffect(_ isEnabled: Bool = true) -> some View {
        if isEnabled {
            modifier(StickerEffectViewModifier())
        } else {
            self
        }
    }
}

#Preview {
    VStack {
        Circle()
            .fill(.white)
            .stroke(.black, lineWidth: 5)
            .frame(height: 30)
            .animation(.snappy) { view in
                view
                    .stickerEffect()
                    .stickerMotionEffect(.pointerHover)
            }
            .shadow(radius: 20)
            .padding()

        Circle()
            .fill(.white)
            .stroke(.black, lineWidth: 10)
            .frame(height: 300)
            .animation(.snappy) { view in
                view
                    .stickerEffect()
                    .stickerMotionEffect(.pointerHover)
            }
            .shadow(radius: 20)
            .padding()
    }
}
