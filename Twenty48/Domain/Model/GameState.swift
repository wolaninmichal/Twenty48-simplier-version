//
//  GameState.swift
//  Twenty48
//
//  Created by Michał Wolanin on 20/10/2026.
//

import Foundation

struct GameState: Equatable, Sendable {
    enum Status: Equatable, Sendable {
        case playing, won, lost
    }

    var board: Board
    var score: Int
    var status: Status
    /// Identifier for the next spawned tile; a counter keeps IDs deterministic.
    var nextTileID: Int

    init(board: Board, score: Int = 0, status: Status = .playing, nextTileID: Int = 0) {
        self.board = board
        self.score = score
        self.status = status
        self.nextTileID = nextTileID
    }
}
