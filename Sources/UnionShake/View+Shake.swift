//
//  View+Shake.swift
//  iShake
//
//  Created by Ben Sage on 3/31/25.
//

import SwiftUI

extension View {
    
    /// Applies a shaking animation to the view when the trigger value changes.
    ///
    /// Use this modifier to visually indicate an event or error by shaking the view.
    /// The intensity and frequency of the shake can be customized.
    ///
    /// To make the shake visible, apply an animation modifier, such as `animation(.default, value: trigger)`.
    ///
    /// Example usage:
    ///
    /// ```swift
    /// struct ContentView: View {
    ///     @State private var trigger = false
    ///
    ///     var body: some View {
    ///         VStack {
    ///             Text("Shake Me")
    ///                 .padding()
    ///                 .shake(on: trigger)
    ///                 .animation(.default, value: trigger)
    ///
    ///             Button("Trigger Shake") {
    ///                 trigger.toggle()
    ///             }
    ///         }
    ///     }
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - trigger: An `Equatable` value that triggers the shake animation when it changes.
    ///   - amount: The maximum displacement of the shake, in points. Defaults to 5.
    ///   - shakesPerUnit: The number of shakes per unit of animation duration. Defaults to 3.
    /// - Returns: A view modified with the shake effect.
    public func shake<T: Equatable>(
        on trigger: T,
        enabled: Bool = true,
        amount: CGFloat = 5,
        shakesPerUnit: CGFloat = 3
    ) -> some View {
        ShakeContainer(
            trigger: trigger,
            amount: amount,
            enabled: enabled,
            shakesPerUnit: shakesPerUnit,
            content: self
        )
    }
}
