//
//  Typography.swift
//  Twenty48
//
//  Created by Michał Wolanin on 29/10/2026.
//

import SwiftUI

enum Typography {
    static var title: Font { .system(size: 48, weight: .heavy, design: .rounded) }
    static var message: Font { .system(size: 32, weight: .bold, design: .rounded) }
    static var label: Font { .system(.caption, design: .rounded, weight: .bold) }
    static var value: Font { .system(.title3, design: .rounded, weight: .bold) }
    static var button: Font { .system(.headline, design: .rounded, weight: .semibold) }
    
    static func tile(
        digits: Int,
        side: CGFloat
    ) -> Font {
        let scale: CGFloat = switch digits {
            case ...2: 0.5
            case 3: 0.4
            default: 0.3
        }
        
        return .system(
            size: side * scale,
            weight: .bold,
            design: .rounded
        )
    }
}
