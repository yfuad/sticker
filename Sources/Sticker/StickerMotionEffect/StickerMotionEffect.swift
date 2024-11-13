//
//  StickerMotionEffect.swift
//  FoilTest
//
//  Created by Benjamin Pisano on 03/11/2024.
//

import SwiftUI

public protocol StickerMotionEffect: ViewModifier { }

extension View {
    func stickerTransformation(_ transformer: some StickerMotionEffect) -> AnyView {
        AnyView(modifier(transformer))
    }

    public func stickerMotionEffect(_ effect: some StickerMotionEffect) -> some View {
        environment(\.stickerMotionEffect, effect)
    }
}

public extension EnvironmentValues {
    @Entry var stickerMotionEffect: any StickerMotionEffect = IdentityStickerMotionEffect()
}
