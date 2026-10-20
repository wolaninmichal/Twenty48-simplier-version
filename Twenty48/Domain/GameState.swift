//
//  GameState.swift
//  Twenty48
//
//  Created by Michał Wolanin on 20/10/2026.
//

import Foundation

struct GameState: Equatable, Sendable {
    enum Status: Equatable, Sendable {
        case playing, won, los
    }
    
    let size: Int
    let cells: [Tile?]
    var score: Int
    var status: Status
    var nextTileId: Int
    
    init(
        size: Int,
        cells: [Tile?]? = nil,
        score: Int = 0,
        status: Status = .playing,
        nextTileId: Int = 0
    ) {
        let cells = cells ?? .init(repeating: nil, count: size * size)
        precondition(size >= 2, "A board needs at least 2x2 cells.")
        precondition(cells.count == size * size, "Expected \(size * size) cells, got \(cells.count)")
        
        self.size = size
        self.cells = cells
        self.score = score
        self.status = status
        self.nextTileId = nextTileId
    }
}
