//
//  StickerMotionEffect.swift
//  FoilTest
//
//  Created by Benjamin Pisano on 03/11/2024.
//

import SwiftUI

public protocol StickerMotionEffect: ViewModifier { }

extension View {
    func applyTransform(for effect: some StickerMotionEffect) -> AnyView {
        AnyView(modifier(effect))
    }

    public func stickerMotionEffect(_ effect: some StickerMotionEffect) -> some View {
        environment(\.stickerMotionEffect, effect)
    }
}

public extension EnvironmentValues {
    @Entry var stickerMotionEffect: any StickerMotionEffect = IdentityStickerMotionEffect()
}
