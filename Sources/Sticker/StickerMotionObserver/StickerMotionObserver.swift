//
//  StickerMotionObserver.swift
//  FoilTest
//
//  Created by Benjamin Pisano on 03/11/2024.
//

import SwiftUI
import Observation

@Observable
final class StickerMotionObserver {
    typealias ChangeHandler = (_ motion: StickerMotion) -> Void

    private(set) var motion: StickerMotion = .init()

    private let onChange: ChangeHandler

    init(onChange: @escaping @Sendable ChangeHandler) {
        self.onChange = onChange
    }

    @MainActor
    func update(motion: StickerMotion) {
        self.motion = motion
        onChange(motion)
    }
}

extension StickerMotionObserver: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(motion)
    }
}

extension StickerMotionObserver: Equatable {
    static func == (lhs: StickerMotionObserver, rhs: StickerMotionObserver) -> Bool {
        lhs.motion == rhs.motion
    }
}

extension View {
    func onStickerMotionChange(_ onChange: @escaping @Sendable StickerMotionObserver.ChangeHandler) -> some View {
        environment(\.stickerMotionObserver, .init(onChange: onChange))
    }
}

extension EnvironmentValues {
    @Entry var stickerMotionObserver: StickerMotionObserver = .init(onChange: { _ in })
}
