//
//  TileSpawner.swift
//  Twenty48
//
//  Created by Michał Wolanin on 20/10/2026.
//

import Foundation

struct TileSpawn: Equatable, Sendable {
    let index: Int
    let value: Int
}

protocol TileSpawner: Sendable {
    func spawn(in emptyIndices: [Int]) -> TileSpawn?
}
