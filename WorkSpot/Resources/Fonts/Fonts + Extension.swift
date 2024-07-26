//
//  CustomFonts.swift
//  WorkSpot
//
//  Created by Abdul Muneer Ahmed on 20/07/24.
//

import SwiftUI

enum LexendFontWeight: String {
    case black      = "Lexend-Black"
    case bold       = "Lexend-Bold"
    case light      = "Lexend-Light"
    case medium     = "Lexend-Medium"
    case regular    = "Lexend-Regular"
    case semiBold   = "Lexend-SemiBold"
    case thin       = "Lexend-Thin"
}

enum LexendFontSize: CGFloat {
    case h0 = 28.0
    case h1 = 20.0
    case h2 = 18.0
    case h3 = 16.0
    case h4 = 14.0
    case h5 = 12.0
    case h6 = 11.0
}

extension Font {
    static let lexendFont: (LexendFontWeight, LexendFontSize) -> Font = { style, size in
        Font.custom(style.rawValue, size: size.rawValue)
    }
}

extension View {
    func lexendFont(_ fontWeight: LexendFontWeight = .regular, _ size: LexendFontSize = .h3) -> some View {
        self.modifier(LexendFontModifier(font: .lexendFont(fontWeight, size)))
    }
}

fileprivate struct LexendFontModifier: ViewModifier {
    var font: Font

    func body(content: Content) -> some View {
        content
            .environment(\.font, font)
    }
}
