//
//  View+Style.swift
//  Twenty48
//
//  Created by Michał Wolanin on 29/10/2026.
//

import SwiftUI

extension View {
    @MainActor
    func onSwipe(
        minimumDistance: CGFloat = 20,
        perform action: @escaping (SwipeDirection) -> Void
    ) -> some View {
       gesture(
        DragGesture(minimumDistance: minimumDistance)
            .onEnded({ val in
                let translation = val.translation
                if abs(translation.width) > abs(translation.height) {
                    action(translation.width > 0 ? .right : .left)
                } else {
                    action(translation.height > 0 ? .down : .up)
                }
            })
       )
    }
}
