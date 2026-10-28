//
//  MergedLineTests.swift
//  Twenty48Tests
//
//  Created by Michał Wolanin on 25/10/2026.
//

import Testing
@testable import Twenty48

struct MergedLineTests {
    @Test(
        "Slides tiles torwards the wall and merges each pari once",
        arguments: [
            ([2, 2, 2, 2], [4, 4, 0, 0]),
            ([2, 2, 4, 0], [4, 4, 0, 0]),
            ([4, 0, 0, 4], [8, 0, 0, 0]),
            ([4, 4, 4, 0], [8, 4, 0, 0]),
            ([0, 0, 0, 2], [2, 0, 0, 0]),
            ([2, 4, 8, 16], [2, 4, 8, 16])
        ],
    )
    func merging(input: [Int], output: [Int]) {
        let mergedLine: MergedLine = .init(merging: .line(input))
        #expect(mergedLine.tiles.values == output)
    }
    
    @Test
    func scoreGainIsTheSumOfMergedTiles() {
        let mergedLine: MergedLine = .init(merging: .line([2, 2, 4, 4]))
        
        #expect(mergedLine.gained == 12)
    }
    
    @Test
    func lineWithoutPairsGainsNothing() {
        let mergedLine: MergedLine = .init(merging: .line([2, 4, 8, 16]))
        #expect(mergedLine.gained == 0)
    }
    
    @Test
    func mergedTileKeepsTheIdOfTheTileNearerTheWall() throws {
        let merged: MergedLine = .init(merging: .line([2, 2, 0, 0]))
        let tile = try #require(merged.tiles[0])
        #expect(tile == Tile(id: 0, value: 4))
    }
}
