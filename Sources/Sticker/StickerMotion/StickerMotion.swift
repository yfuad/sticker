//
//  File.swift
//  Sticker
//
//  Created by Benjamin Pisano on 04/11/2024.
//

import Foundation

public struct StickerMotion: Hashable, Equatable, Sendable {
    var isActive: Bool = false
    var transform: StickerTransform = .neutral
}
