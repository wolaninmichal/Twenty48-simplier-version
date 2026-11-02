//
//  TileView.swift
//  Twenty48
//
//  Created by Michał Wolanin on 29/10/2026.
//

import SwiftUI

struct TileView: View {
    let value: Int
    let side: CGFloat
    
    var body: some View {
        let style: TileStyle = .init(value: value)
        
        Text(verbatim: String(value))
            .font(Typography.tile(digits: String(value).count, side: side))
            .minimumScaleFactor(0.5)
            .lineLimit(1)
            .foregroundStyle(style.foreground)
            .frame(width: side, height: side)
            .background(style.background, in: RoundedRectangle(cornerRadius: Radius.tile))
    }
}

#Preview {
    LazyVGrid(columns: Array(repeating: GridItem(.fixed(72)), count: 4)) {
        ForEach([2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048], id: \.self) { value in
            TileView(value: value, side: 72)
        }
    }
    .padding()
    .background(Palette.board)
}
