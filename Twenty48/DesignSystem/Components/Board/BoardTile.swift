//
//  BoardTile.swift
//  Twenty48
//
//  Created by Michał Wolanin on 29/10/2026.
//

import Foundation

/// What `BoardView` draws and where. Owned by the DesignSystem, so it never depends on domain types.
struct BoardTile: Identifiable, Equatable, Sendable {
    let id: Int
    let value: Int
    let row: Int
    let column: Int
}
