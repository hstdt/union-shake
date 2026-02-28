//
//  ShakeContainer.swift
//  iShake
//
//  Created by Ben Sage on 3/31/25.
//

import SwiftUI
import Combine

@MainActor
class ShakeContainerObservation: ObservableObject {
    static let shared = ShakeContainerObservation()
    var cancellables = Set<AnyCancellable>()
    @Published var version: CGFloat = 0
    private let versionSubject = PassthroughSubject<Void, Never>()

    private init() {
        versionSubject
            .debounce(for: .seconds(0.05), scheduler: DispatchQueue.main)
            .sink { [weak self] in
                guard let self else { return }
                version += 1
            }
            .store(in: &cancellables)
    }

    func versionIncrease() {
        versionSubject.send()
    }
}

struct ShakeContainer<T: Equatable, Content: View>: View {
    let trigger: T
    let amount: CGFloat
    let enabled: Bool
    let shakesPerUnit: CGFloat
    let content: Content
    @StateObject private var shake = ShakeContainerObservation.shared
    @State private var animation: Bool = false

    var body: some View {
        content
            .modifier(ShakeEffect(amount: amount, shakesPerUnit: shakesPerUnit, animatableData: shake.version))
            .animation(animation ? .default : .none, value: shake.version)
            .onChange(of: trigger) { _ in
                guard enabled else { return }
                animation = true
                shake.versionIncrease()
            }
            .onChange(of: shake.version) { _ in
                DispatchQueue.main.async {
                    animation = false
                }
            }
    }
}
