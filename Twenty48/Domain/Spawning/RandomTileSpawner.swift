//
//  RandomTileSpawner.swift
//  Twenty48
//
//  Created by Michał Wolanin on 20/10/2026.
//

import Foundation

/// Production spawner: a random empty cell, usually a 2, sometimes a 4.
struct RandomTileSpawner: TileSpawner {
    /// Probability of spawning a 4 instead of a 2.
    var fourProbability = 0.1

    func spawn(in emptyPositions: [Position]) -> TileSpawn? {
        guard let position = emptyPositions.randomElement() else { return nil }
        let value = Double.random(in: 0..<1) < fourProbability ? 4 : 2
        return TileSpawn(position: position, value: value)
    }
}
