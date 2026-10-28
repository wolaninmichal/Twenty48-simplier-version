//
//  BoardTests.swift
//  Twenty48Tests
//
//  Created by Michał Wolanin on 25/10/2026.
//

import Testing
@testable import Twenty48

struct BoardTests {
    @Test(
        arguments: [
            (.left, [[Position(0, 0), Position(0, 1)], [Position(1, 0), Position(1, 1)]])
    ] as [(Direction, [[Position]])])
    func linesStartAtTheWallTilesMoveTowards(
        direction: Direction,
        expected: [[Position]]
    ) {
        let board: Board = .init(size: 2)
        #expect(board.lines(toward: direction) == expected)
    }
    
    @Test
    func emptyPositionsAreListedInReadingOrder() {
        let board = Board.make(
            [
                [2, 0],
                [0, 4]
            ]
        )
        
        #expect(board.emptyPositions == [Position(0, 1), Position(1, 0)])
    }
    
    @Test
    func subscriptWritesAndReadsATileByPosition() {
        var board: Board = .init(size: 2)
        board[Position(1, 0)] = Tile(id: 7, value: 4)
        
        #expect(board[Position(1, 0)] == Tile(id: 7, value: 4))
        #expect(board.rowValues == [
            [0, 0],
            [4, 0]
        ])
    }
    
    @Test(
        arguments: [
            ([[2, 0], [0, 4]], false),
            ([[2, 4], [8, 16]], true),
        ]
    )
    func boardIsFullOnlyWithoutEmptyCells(
        rows: [[Int]],
        expected: Bool
    ) {
        #expect(Board.make(rows).isFull == expected)
    }
    
    @Test(
        arguments: [
             ([[2, 4], [4, 2]], false),
             ([[2, 2], [4, 8]], true),
             ([[2, 4], [2, 8]], true),
             ([[2, 0], [0, 2]], false)
        ]
    )
    func detectsAdjacentEqualTiles(
        rows: [[Int]],
        expected: Bool
    ) {
        #expect(Board.make(rows).hasAdjacentEqualTiles == expected)
    }
    
    @Test
    func findsTilesMatchingAPredicate() {
        let board = Board.make([
            [2, 0],
            [0, 2048]
        ])
 
        #expect(board.containsTile(where: { $0.value >= 2048 }))
        #expect(!board.containsTile(where: { $0.value == 4 }))
    }
}
