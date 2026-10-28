//
//  GameEngine.swift
//  Twenty48
//
//  Created by Michał Wolanin on 20/10/2026.
//

import Foundation

/// The rules of 2048, composed from `Board` and `MergedLine`.
struct GameEngine: Sendable {
    let size: Int
    let winningValue: Int
    private let spawner: any TileSpawner

    init(size: Int = 4, winningValue: Int = 2048, spawner: any TileSpawner) {
        self.size = size
        self.winningValue = winningValue
        self.spawner = spawner
    }

    /// A fresh board with two spawned tiles.
    func newGame() -> GameState {
        var state = GameState(board: Board(size: size))
        spawnTile(in: &state)
        spawnTile(in: &state)
        return state
    }

    /// Applies a swipe. A move that changes nothing returns the state untouched, without a spawn.
    func move(_ state: GameState, _ direction: Direction) -> GameState {
        guard state.status == .playing else { return state }

        var next = state
        for line in state.board.lines(toward: direction) {
            let merged = MergedLine(merging: line.map { state.board[$0] })
            for (position, tile) in zip(line, merged.tiles) {
                next.board[position] = tile
            }
            next.score += merged.gained
        }

        guard next.board != state.board else { return state }

        spawnTile(in: &next)
        next.status = status(of: next)
        return next
    }

    /// Won on the winning tile; playing while a cell is empty or two neighbours match; lost otherwise.
    func status(of state: GameState) -> GameState.Status {
        let board = state.board
        if board.containsTile(where: { $0.value >= winningValue }) { return .won }
        if !board.isFull || board.hasAdjacentEqualTiles { return .playing }
        return .lost
    }

    private func spawnTile(in state: inout GameState) {
        guard let spawn = spawner.spawn(in: state.board.emptyPositions) else { return }
        state.board[spawn.position] = Tile(id: state.nextTileID, value: spawn.value)
        state.nextTileID += 1
    }
}
