//
//  StickerTransformer.swift
//  FoilTest
//
//  Created by Benjamin Pisano on 03/11/2024.
//

import SwiftUI

public protocol StickerTransformer: ViewModifier { }

extension View {
    func stickerTransformation(_ transformer: some StickerTransformer) -> AnyView {
        AnyView(modifier(transformer))
    }

    public func stickerTransformer(_ transformer: some StickerTransformer) -> some View {
        environment(\.stickerTransformer, transformer)
    }
}

public extension EnvironmentValues {
    @Entry var stickerTransformer: any StickerTransformer = IdentityStickerTransformer()
}
