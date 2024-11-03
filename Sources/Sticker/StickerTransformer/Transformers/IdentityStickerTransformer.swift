//
//  File.swift
//  Sticker
//
//  Created by Benjamin Pisano on 03/11/2024.
//

import SwiftUI

public struct IdentityStickerTransformer: StickerTransformer {
    public func body(content: Content) -> some View {
        content
    }
}

public extension StickerTransformer where Self == IdentityStickerTransformer {
    static var identity: Self {
        .init()
    }
}
