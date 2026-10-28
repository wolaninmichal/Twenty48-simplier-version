//
//  TileSpawner.swift
//  Twenty48
//
//  Created by Michał Wolanin on 20/10/2026.
//

import Foundation

/// Where a new tile appears and what value it has.
struct TileSpawn: Equatable, Sendable {
    let position: Position
    let value: Int
}

/// The only source of randomness in the game.
///
/// It sits behind a protocol so tests can replace it with a deterministic implementation.
protocol TileSpawner: Sendable {
    /// Picks one of `emptyPositions` and a value for the new tile,
    /// or returns `nil` when there is no room left.
    func spawn(in emptyPositions: [Position]) -> TileSpawn?
}
