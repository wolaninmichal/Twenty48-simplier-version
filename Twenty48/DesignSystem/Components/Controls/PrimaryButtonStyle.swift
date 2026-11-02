//
//  PrimaryButtonStyle.swift
//  Twenty48
//
//  Created by Michał Wolanin on 29/10/2026.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(
        configuration: Configuration
    ) -> some View {
        configuration.label
            .font(Typography.button)
    }
}

extension ButtonStyle where Self == PrimaryButtonStyle {
    @MainActor
    static var primary: PrimaryButtonStyle { PrimaryButtonStyle() }
}

#Preview {
    Button("New game") { }
        .buttonStyle(.primary)
        .padding()
}
