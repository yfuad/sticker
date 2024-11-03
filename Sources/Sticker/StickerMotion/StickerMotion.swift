//
//  StickerMotion.swift
//  FoilTest
//
//  Created by Benjamin Pisano on 03/11/2024.
//

import SwiftUI
import Observation

@Observable
final class StickerMotion {
    typealias ChangeHandler = (_ transform: StickerTransform, _ isActive: Bool) -> Void

    private(set) var isActive: Bool = false
    private(set) var transform: StickerTransform = .neutral

    private let onChange: ChangeHandler

    init(onChange: @escaping @Sendable ChangeHandler) {
        self.onChange = onChange
    }

    func update(transform: StickerTransform, isActive: Bool) {
        self.transform = transform
        self.isActive = isActive
        onChange(transform, isActive)
    }
}

extension StickerMotion: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(isActive)
        hasher.combine(transform)
    }
}

extension StickerMotion: Equatable {
    static func == (lhs: StickerMotion, rhs: StickerMotion) -> Bool {
        lhs.isActive == rhs.isActive && lhs.transform == rhs.transform
    }
}

extension View {
    func onMotionChange(_ onChange: @escaping @Sendable (_ transform: StickerTransform, _ isActive: Bool) -> Void) -> some View {
        environment(\.stickerMotion, .init(onChange: onChange))
    }
}

extension EnvironmentValues {
    @Entry var stickerMotion: StickerMotion = .init(onChange: { _, _ in })
}
