//
//  GameState+Fixtures.swift
//  Twenty48Tests
//
//  Created by Michał Wolanin on 25/10/2026.
//

@testable import Twenty48

extension GameState {
    
    static func make(_ rows: [[Int]], score: Int = 0, status: Status = .playing) -> GameState {
        let board: Board = Board.make(rows)
        return .init(board: board, score: score, status: status, nextTileID: board.size * board.size)
    }
    
    var rowValues: [[Int]] {
        board.rowValues
    }
    
}
