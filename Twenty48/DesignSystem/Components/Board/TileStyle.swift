//
//  TileStyle.swift
//  Twenty48
//
//  Created by Michał Wolanin on 29/10/2026.
//

import SwiftUI

struct TileStyle {
    let background: Color
    let foreground: Color
    
    init(
        value: Int
    ) {
        background = Self.fill(for: value)
        foreground = value <= 4 ? Palette.textDark : Palette.textLight
    }
    
    private static func fill(
        for value: Int
    ) -> Color {
        switch value {
            case 2: Color(.tile2)
            case 4: Color(.tile4)
            case 8: Color(.tile8)
            case 16: Color(.tile16)
            case 32: Color(.tile32)
            case 64: Color(.tile64)
            case 128: Color(.tile128)
            case 256: Color(.tile256)
            case 512: Color(.tile512)
            case 1024: Color(.tile1024)
            case 2048: Color(.tile2048)
            default: Color(.tileSuper)
        }
    }
}
