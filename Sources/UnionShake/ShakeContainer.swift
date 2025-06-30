//
//  ShakeContainer.swift
//  iShake
//
//  Created by Ben Sage on 3/31/25.
//

import SwiftUI

struct ShakeContainer<T: Equatable, Content: View>: View {
    let trigger: T
    let amount: CGFloat
    let enabled: Bool
    let shakesPerUnit: CGFloat
    let content: Content

    @State private var version: CGFloat = 0

    var body: some View {
        content
            .modifier(ShakeEffect(amount: amount, shakesPerUnit: shakesPerUnit, animatableData: version))
            .onChange(of: trigger) { _ in
                guard enabled else { return }
                withAnimation {
                    version += 1
                }
            }
    }
}
