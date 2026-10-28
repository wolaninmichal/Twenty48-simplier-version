//
//  GameEngineTests.swift
//  Twenty48Tests
//
//  Created by Michał Wolanin on 25/10/2026.
//

import Testing
@testable import Twenty48

struct GameEngineTests {
    private let engine: GameEngine = .init(size: 4, winningValue: 2048, spawner: TileSpawnerStub.neverSpawn)
    
    private static let board: [[Int]] = [
        [2, 2, 0, 0],
        [4, 0, 4, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 2]
    ]
    
    // MARK: - Moving
    
    @Test(
        arguments: [
            (.left, [
                [4, 0, 0, 0],
                [8, 0, 0, 0],
                [0, 0, 0, 0],
                [2, 0, 0, 0]
            ]),
            (.right, [
                [0, 0, 0, 4],
                [0, 0, 0, 8],
                [0, 0, 0, 0],
                [0, 0, 0, 2],
            ]),
            (.up, [
                [2, 2, 4, 2],
                [4, 0, 0, 0],
                [0, 0, 0, 0],
                [0, 0, 0, 0]
            ]),
            (.down, [
                [0, 0, 0, 0],
                [0, 0, 0, 0],
                [2, 0, 0, 0],
                [4, 2, 4, 2]
            ]),
        ] as [(Direction, [[Int]])])
    func moveSlidesAndMergesTowardsTheWall(
        direction: Direction,
        expected: [[Int]]
    ) {
        let next = engine.move(.make(Self.board), direction)
        #expect(next.rowValues == expected)
    }
    
    @Test
    func moveAddsMergedValuesToTheScore() {
        let nextGameState = engine.move(.make(Self.board, score: 100), .left)
        #expect(nextGameState.score == 112)
    }
    
    //MARK: - Moving
    
    @Test
    func newGameStartsWithTwoTailsAndNoScore() {
        let engine: GameEngine = .init(size: 4, winningValue: 1024, spawner: TileSpawnerStub.onFirstEmptyCell())
        let state = engine.newGame()
        
        #expect(state.rowValues == [
            [2, 2, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0]
        ])
        #expect(state.score == 0)
        #expect(state.status == .playing)
        #expect(state.nextTileID == 2)
    }
    
    @Test
    func moveWithoutEffectChangesNothingAndSpawnsNothing() {
        let engine: GameEngine = .init(size: 4, winningValue: 1024, spawner: TileSpawnerStub.onFirstEmptyCell())
        let state = GameState.make([
            [2, 4, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0]
        ])
        
        #expect(engine.move(state, .left) == state)
    }
    
    @Test
    func successfulMoveSpawnsOneTileWithAFreshID() {
        let engine: GameEngine = .init(size: 4, winningValue: 1024, spawner: TileSpawnerStub.onFirstEmptyCell(value: 4))
        let state = GameState.make([
            [0, 0, 0, 2],
            [0, 0, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0]
        ])
        
        let next = engine.move(state, .left)
        
        #expect(next.rowValues == [
            [2, 4, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0]
        ])
        #expect(next.board[Position(0, 1)]?.id == state.nextTileID)
        #expect(next.nextTileID == state.nextTileID + 1)
        
    }
    
    // MARK: - Status

    @Test func reachingTheWinningTileWinsTheGame() {
        let engine: GameEngine = .init(size: 4, winningValue: 2048, spawner: TileSpawnerStub.onFirstEmptyCell(value: 2))
        let state: GameState = .make([
            [1024, 1024, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0]
        ])
        
        let nextMove = engine.move(state, .left)
        
        #expect(nextMove.board[Position(0, 0)]?.value == 2048)
        #expect(nextMove.status == .won)
    }
    
    @Test func winningValueIsConfigurable() {
        let engine = GameEngine(size: 2, winningValue: 8, spawner: TileSpawnerStub.neverSpawn)

        let next = engine.move(.make([[4, 4], [0, 0]]), .left)

        #expect(next.status == .won)
    }
    
    @Test(arguments: [
        ([[2, 4, 2, 4], [4, 2, 4, 2], [2, 4, 2, 4], [4, 2, 4, 8]], .lost),     // full, no pairs
        ([[2, 4, 2, 4], [4, 2, 4, 2], [2, 4, 2, 4], [4, 2, 4, 4]], .playing),  // full, one pair
        ([[2, 4, 2, 4], [4, 2, 4, 2], [2, 4, 2, 4], [4, 2, 4, 0]], .playing),  // one empty cell
    ] as [([[Int]], GameState.Status)])
    func gameContinuesWhileAMoveIsPossible(rows: [[Int]], expected: GameState.Status) {
        #expect(engine.status(of: .make(rows)) == expected)
    }
    
    @Test(arguments: [GameState.Status.won, .lost])
     func finishedGameIgnoresMoves(status: GameState.Status) {
         let state = GameState.make([[0, 2], [0, 0]], status: status)

         #expect(engine.move(state, .left) == state)
     }
}
