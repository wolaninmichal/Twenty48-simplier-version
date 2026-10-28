//
//  Position+Fixtures.swift
//  Twenty48Tests
//
//  Created by Michał Wolanin on 23/10/2026.
//

@testable import Twenty48

extension Position {
    
    /// `Position(1, 2)` let us create functions like a coordinate in test tables
    init(_ row: Int, _ column: Int) {
        self.init(row: row, column: column)
    }
}
