//
//  File.swift
//  Sticker
//
//  Created by Benjamin Pisano on 13/11/2024.
//

import SwiftUI

public struct DragStickerMotionEffect: StickerMotionEffect {
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
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                motionObserver.update(
                                    motion: .init(
                                        isActive: true,
                                        transform: .init(
                                            x: gesture.location.x - size.width / 2,
                                            y: gesture.location.y - size.height / 2
                                        )
                                    )
                                )
                            }
                            .onEnded { _ in
                                motionObserver.update(
                                    motion: .init(
                                        isActive: false,
                                        transform: .neutral
                                    )
                                )
                            }
                    )
            }
    }
}

public extension StickerMotionEffect where Self == DragStickerMotionEffect {
    static var dragGesture: Self {
        .dragGesture()
    }
    
    static func dragGesture(intensity: Double = 1) -> Self {
        .init(intensity: intensity)
    }
}
