//
//  TileSpawnerStub.swift
//  Twenty48Tests
//
//  Created by Michał Wolanin on 23/10/2026.
//

@testable import Twenty48

struct TileSpawnerStub: TileSpawner {

    private let decide: @Sendable ([Position]) -> TileSpawn?
    
    init(decide: @Sendable @escaping ([Position]) -> TileSpawn?) {
        self.decide = decide
    }
    
    func spawn(in emptyPositions: [Position]) -> TileSpawn? {
        decide(emptyPositions)
    }
}

extension TileSpawnerStub {
    static let neverSpawn = TileSpawnerStub { _ in nil }
    static func onFirstEmptyCell(value: Int = 2) -> TileSpawnerStub {
        .init { $0.first.map { TileSpawn(position: $0, value: value) } }
    }
}
