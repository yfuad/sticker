//
//  IdentityStickerMotionEffect.swift
//  Sticker
//
//  Created by Benjamin Pisano on 03/11/2024.
//

import SwiftUI

public struct IdentityStickerMotionEffect: StickerMotionEffect {
    public func body(content: Content) -> some View {
        content
    }
}

extension StickerMotionEffect where Self == IdentityStickerMotionEffect {
    public static var identity: Self {
        .init()
    }
}
