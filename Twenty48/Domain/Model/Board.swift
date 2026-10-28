//
//  Board.swift
//  Twenty48
//
//  Created by Michał Wolanin on 22/10/2026.
//

import Foundation

struct Board: Equatable, Sendable {
    let size: Int
    private var cells: [Tile?]

    init(size: Int, cells: [Tile?]? = nil) {
        let cells = cells ?? Array(repeating: nil, count: size * size)
        precondition(size >= 2, "A board needs at least 2×2 cells.")
        precondition(cells.count == size * size, "Expected \(size * size) cells, got \(cells.count).")
        self.size = size
        self.cells = cells
    }

    subscript(position: Position) -> Tile? {
        get { cells[index(of: position)] }
        set { cells[index(of: position)] = newValue }
    }

    // MARK: - Geometry

    var rows: [[Position]] {
        (0..<size).map { row in (0..<size).map { Position(row: row, column: $0) } }
    }

    var columns: [[Position]] {
        (0..<size).map { column in (0..<size).map { Position(row: $0, column: column) } }
    }

    /// All positions, row by row.
    var positions: [Position] {
        rows.flatMap { $0 }
    }

    /// The lines a move works on, each ordered from the wall the tiles move towards.
    func lines(toward direction: Direction) -> [[Position]] {
        switch direction {
        case .left: rows
        case .right: rows.map { Array($0.reversed()) }
        case .up: columns
        case .down: columns.map { Array($0.reversed()) }
        }
    }

    // MARK: - Queries

    var emptyPositions: [Position] {
        positions.filter { self[$0] == nil }
    }

    var isFull: Bool {
        !cells.contains(nil)
    }

    func containsTile(where predicate: (Tile) -> Bool) -> Bool {
        cells.contains { $0.map(predicate) ?? false }
    }

    /// `true` when two horizontally or vertically adjacent tiles have the same value.
    var hasAdjacentEqualTiles: Bool {
        (rows + columns).contains { line in
            zip(line, line.dropFirst()).contains { first, second in
                guard let a = self[first], let b = self[second] else { return false }
                return a.value == b.value
            }
        }
    }

    private func index(of position: Position) -> Int {
        position.row * size + position.column
    }
}
