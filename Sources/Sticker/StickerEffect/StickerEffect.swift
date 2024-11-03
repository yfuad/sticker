//
//  File.swift
//  Sticker
//
//  Created by Benjamin Pisano on 03/11/2024.
//

import SwiftUI

private struct StickerEffectViewModifier: ViewModifier {
    @State private var transform: StickerTransform = .neutral
    @State private var isTransforming: Bool = false

    @Environment(\.stickerTransformer) private var transformer

    func body(content: Content) -> some View {
        content
            .visualEffect { [transform, isTransforming] view, proxy in
                view
                    .colorEffect(
                        ShaderLibrary.foilShader(
                            offset: isTransforming ? (transform * -150).point : StickerTransform.neutral.point,
                            size: proxy.size
                        )
                    )
                    .colorEffect(
                        ShaderLibrary.reflectionShader(
                            size: proxy.size,
                            reflectionPosition: CGPoint(
                                x: transform.x,
                                y: transform.y
                            ),
                            reflectionSize: Float(min(proxy.size.width, proxy.size.height) / 2),
                            reflectionIntensity: isTransforming ? 0.3 : 0
                        )
                    )
            }
            .mask(content)
            .rotation3DEffect(
                isTransforming ? .radians(transform.x - 0.5) : .degrees(0),
                axis: (0, 1, 0)
            )
            .rotation3DEffect(
                isTransforming ? .radians(transform.y - 0.5) : .degrees(0),
                axis: (-1, 0, 0)
            )
            .stickerTransformation(transformer)
            .onMotionChange { transform, isActive in
                self.transform = transform
                self.isTransforming = isActive
            }
    }
}

public extension View {
    @ViewBuilder
    func stickerEffect(_ isEnabled: Bool = true) -> some View {
        if isEnabled {
            modifier(StickerEffectViewModifier())
        } else {
            self
        }
    }
}

#Preview {
    VStack {
        Image(systemName: "star.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 30)
            .animation(.snappy) { view in
                view
                    .stickerEffect()
                    .stickerTransformer(.pointerHover)
            }
            .shadow(radius: 20)
            .padding()
        Image(systemName: "star.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 300)
            .animation(.snappy) { view in
                view
                    .stickerEffect()
                    .stickerTransformer(.pointerHover)
            }
            .shadow(radius: 20)
            .padding()
    }
}
