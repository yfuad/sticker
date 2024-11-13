//
//  PointerHoverStickerMotionEffect.swift
//  FoilTest
//
//  Created by Benjamin Pisano on 03/11/2024.
//

import SwiftUI

public struct PointerHoverStickerMotionEffect: StickerMotionEffect {
    let intensity: Double

    @Environment(\.stickerMotionObserver) private var motionObserver

    public func body(content: Content) -> some View {
        content
            .withViewSize { view, size in
                let xRotation: Double = motionObserver.motion.transform.x / size.width
                let yRotation: Double = motionObserver.motion.transform.y / size.height
                view
                    .rotation3DEffect(
                        motionObserver.motion.isActive ?.radians((xRotation) * intensity) : .degrees(0),
                        axis: (0, 1, 0)
                    )
                    .rotation3DEffect(
                        motionObserver.motion.isActive ? .radians((yRotation) * intensity) : .degrees(0),
                        axis: (-1, 0, 0)
                    )
                    .onContinuousHover { phase in
                        switch phase {
                        case .active(let location):
                            motionObserver.update(
                                motion: .init(
                                    isActive: true,
                                    transform: .init(
                                        x: location.x - size.width / 2,
                                        y: location.y - size.height / 2
                                    )
                                )
                            )
                        case .ended:
                            motionObserver.update(
                                motion: .init(
                                    isActive: false,
                                    transform: .neutral
                                )
                            )
                        }
                    }
            }
    }
}

public extension StickerMotionEffect where Self == PointerHoverStickerMotionEffect {
    static var pointerHover: Self {
        .pointerHover()
    }
    
    static func pointerHover(intensity: Double = 1) -> Self {
        .init(intensity: intensity)
    }
}
