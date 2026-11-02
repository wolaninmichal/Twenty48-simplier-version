//
//  ScoreBadge.swift
//  Twenty48
//
//  Created by Michał Wolanin on 29/10/2026.
//

import SwiftUI

struct ScoreBadge: View {
    let title: String
    let value: Int

    var body: some View {
        VStack(spacing: Spacing.xs) {
            Text(title)
                .font(Typography.label)
                .foregroundStyle(Palette.emptyCell)
            Text(verbatim: String(value))
                .font(Typography.value)
                .monospacedDigit()
                .foregroundStyle(Palette.textLight)
                .contentTransition(.numericText())
        }
        .frame(minWidth: 72)
        .padding(.vertical, Spacing.s)
        .padding(.horizontal, Spacing.m)
        .background(Palette.board, in: RoundedRectangle(cornerRadius: Radius.control))
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    ScoreBadge(title: "SCORE", value: 1024)
        .padding()
}
