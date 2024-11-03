//
//  PointerHoverStickerTransformer.swift
//  FoilTest
//
//  Created by Benjamin Pisano on 03/11/2024.
//

import SwiftUI

public struct PointerHoverStickerTransformer: StickerTransformer {
    @Environment(\.stickerMotion) private var motion

    public func body(content: Content) -> some View {
        content
            .withViewSize { view, size in
                view
                    .onContinuousHover { phase in
                        DispatchQueue.main.async {
                            switch phase {
                            case .active(let location):
                                motion.update(
                                    transform: .init(
                                        x: location.x / size.width,
                                        y: location.y / size.height
                                    ),
                                    isActive: true
                                )
                            case .ended:
                                motion.update(
                                    transform: .neutral,
                                    isActive: false
                                )
                            }
                        }
                    }
            }
    }
}

public extension StickerTransformer where Self == PointerHoverStickerTransformer {
    static var pointerHover: Self {
        .init()
    }
}
