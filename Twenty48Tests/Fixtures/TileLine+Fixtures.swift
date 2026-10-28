//
//  TileLine+Fixtures.swift
//  Twenty48Tests
//
//  Created by Michał Wolanin on 24/10/2026.
//

@testable import Twenty48

extension Array where Element == Tile? {
    
    /// it builds a line from numbers
    /// 0 is empty cell;
    /// any other value build Tile object, e.g. `.line([2, 0, 4])` -> `[Tile(0, 2), nil, Tile(2, 4)]`
    static func line(_ values: [Int]) -> [Tile?] {
        values.enumerated().map { id, val in
            val == 0 ? nil : Tile(id: id, value: val)
        }
    }
    
    /// the line as numbers
    var values: [Int] {
        map { $0?.value ?? 0 }
    }
    
}
