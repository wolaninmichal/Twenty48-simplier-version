//
//  Board+Fixtures.swift
//  Twenty48Tests
//
//  Created by Michał Wolanin on 24/10/2026.
//

@testable import Twenty48

extension Board {
    
    static func make(
        _ rows: [[Int]]
    ) -> Board {
        precondition(rows.allSatisfy { $0.count == rows.count }, "Board must be square.")
        return .init(size: rows.count, cells: [Tile?].line(rows.flatMap({$0})))
    }

    var rowValues: [[Int]] {
        return rows.map { row in row.map { position in self[position]?.value ?? 0 } }
    }
}
