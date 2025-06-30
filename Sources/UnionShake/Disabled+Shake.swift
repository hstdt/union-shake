//
//  Disabled+Shake.swift
//  union-shake
//
//  Created by Ben Sage on 6/5/25.
//

import SwiftUI

@available(iOS 17, *)
fileprivate struct DisabledShakeModifier: ViewModifier {
    var disabled: Bool
    var shake: Bool

    @State private var toggle = false

    func body(content: Content) -> some View {
        content
            .disabled(disabled)
            .shake(on: toggle, enabled: shake)
            .animation(.default, value: toggle)
            .sensoryFeedback(.error, trigger: toggle)
            .contentShape(.rect)
            .onTapGesture {
                if disabled {
                    toggle.toggle()
                }
            }
    }
}

extension View {

    @available(iOS 17, *)
    public func disabled(_ disabled: Bool, shake: Bool) -> some View {
        modifier(DisabledShakeModifier(disabled: disabled, shake: shake))
    }
}
