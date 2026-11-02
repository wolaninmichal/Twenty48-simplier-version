//
//  BoardView.swift
//  Twenty48
//
//  Created by Michał Wolanin on 29/10/2026.
//

import SwiftUI

struct BoardView: View {
    let size: Int
    let tiles: [BoardTile]
    
    var body: some View {
        GeometryReader { proxy in
            let side = min(proxy.size.width, proxy.size.height)
            let spacing = side * 0.03
            let cell = (side - spacing * CGFloat(size + 1)) / CGFloat(size)
            
            ZStack(alignment: .topLeading) {
                ForEach(0..<size*size, id: \.self) { index in
                    RoundedRectangle(cornerRadius: Radius.tile)
                        .fill(Palette.emptyCell)
                        .frame(width: cell, height: cell)
                        .offset(offset(
                            row: index / size,
                            column: index % size,
                            cell: cell,
                            spacing: spacing
                        ))
                }
                
                ForEach(tiles) { tile in
                    TileView(value: tile.value, side: cell)
                        .offset(offset(
                            row: tile.row,
                            column: tile.column,
                            cell: cell,
                            spacing: spacing)
                        )
                        .transition(.scale)
                        .zIndex(Double(tile.value))
                }
            }
            .frame(width: side, height: side, alignment: .topLeading)
            .background(
                Palette.board,
                in: RoundedRectangle(cornerRadius: Radius.board)
            )
        }
        .aspectRatio(1, contentMode: .fit)
        .animation(.easeInOut(duration: 0.12), value: tiles) 
    }
    
    private func offset(
        row: Int,
        column: Int,
        cell: CGFloat,
        spacing: CGFloat
    ) -> CGSize {
        CGSize(
            width: spacing + CGFloat(column) * (cell + spacing),
            height: spacing + CGFloat(row) * (cell + spacing)
        )
    }
}

#Preview {
    BoardView(size: 2, tiles: [
        BoardTile(id: 0, value: 2, row: 0, column: 0),
        BoardTile(id: 1, value: 64, row: 0, column: 1),
        BoardTile(id: 2, value: 512, row: 1, column: 0),
        BoardTile(id: 3, value: 1024, row: 1, column: 1)
    ])
    .padding()
    .background(Palette.background)
}
