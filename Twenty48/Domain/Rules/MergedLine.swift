//
//  MergedLine.swift
//  Twenty48
//
//  Created by Michał Wolanin on 22/10/2026.
//

import Foundation

/// One line after a move: tiles slid towards index 0, equal neighbours merged at most once.
struct MergedLine: Equatable, Sendable {
    let tiles: [Tile?]
    let gained: Int
}

extension MergedLine {
    
    init(
        merging line: [Tile?]
    ){
        var merged: [Tile?] = []
        var gained = 0
        var waiting: Tile?
        
        for t in line.compactMap({ $0 }) {
            if let candidate = waiting, candidate.value == t.value {
                let sum: Tile = .init(id: candidate.id, value: candidate.value * 2)
                merged.append(sum)
                gained += sum.value
                waiting = nil
            } else {
                if let candidate = waiting { merged.append(candidate) }
                waiting = t
            }
        }
        
        if let candidate = waiting { merged.append(candidate) }
        
        let padding = [Tile?](repeating: nil, count: line.count - merged.count)
        self.init(tiles: merged + padding, gained: gained)
    }
}
