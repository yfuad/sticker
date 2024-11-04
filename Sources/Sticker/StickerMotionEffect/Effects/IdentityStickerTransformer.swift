//
//  File.swift
//  Sticker
//
//  Created by Benjamin Pisano on 03/11/2024.
//

import SwiftUI

public struct IdentityStickerTransformer: StickerMotionEffect {
    public func body(content: Content) -> some View {
        content
    }
}

public extension StickerMotionEffect where Self == IdentityStickerTransformer {
    static var identity: Self {
        .init()
    }
}
