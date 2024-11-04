//
//  PointerHoverStickerTransformer.swift
//  FoilTest
//
//  Created by Benjamin Pisano on 03/11/2024.
//

import SwiftUI

public struct PointerHoverStickerTransformer: StickerMotionEffect {
    @Environment(\.stickerMotionObserver) private var motionObserver

    public func body(content: Content) -> some View {
        content
            .withViewSize { view, size in
                view
                    .onContinuousHover { phase in
                        DispatchQueue.main.async {
                            switch phase {
                            case .active(let location):
                                motionObserver.update(
                                    motion: .init(
                                        isActive: true,
                                        transform: .init(
                                            x: location.x / size.width,
                                            y: location.y / size.height
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
}

public extension StickerMotionEffect where Self == PointerHoverStickerTransformer {
    static var pointerHover: Self {
        .init()
    }
}
