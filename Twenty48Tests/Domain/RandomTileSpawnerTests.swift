//
//  RandomTileSpawnerTests.swift
//  Twenty48Tests
//
//  Created by Michał Wolanin on 28/10/2026.
//

import Testing
@testable import Twenty48

struct RandomTileSpawnerTests {
    private let emptyPositions = [Position(0, 1), Position(1, 0)]
    
    @Test(arguments: [
        (0.0, 2),
        (1.0, 4)
    ])
    func probabilityDecidesTheSpawnedValue(fourProbability: Double, expected: Int) throws {
        let spawner: RandomTileSpawner = .init(fourProbability: fourProbability)
        let spawn = try #require(spawner.spawn(in: emptyPositions))
        
        #expect(spawn.value == expected)
    }
    
    @Test func returnsNilWhenThereIsNoEmptyCell() {
        #expect(RandomTileSpawner().spawn(in: []) == nil)
    }
}
