//
//  Store.swift
//  Live Beer App
//
//  Created by Константин Клинов on 25/02/26.
//

import Foundation
import Combine

// MARK: - Effect
struct Effect<Action> {
    let operation: (@escaping (Action) -> Void) -> AnyCancellable?

    static var none: Effect<Action> {
        Effect { _ in nil }
    }

    static func send(_ action: Action) -> Effect<Action> {
        Effect { dispatch in
            DispatchQueue.main.async { dispatch(action) }
            return AnyCancellable {}
        }
    }

    static func run(_ body: @escaping (@escaping (Action) -> Void) -> Void) -> Effect<Action> {
        Effect { dispatch in
            body(dispatch)
            return AnyCancellable {}
        }
    }

    func map<NewAction>(_ transform: @escaping (Action) -> NewAction) -> Effect<NewAction> {
        Effect<NewAction> { dispatchNew in
            self.operation { action in
                dispatchNew(transform(action))
            }
        }
    }
}

// MARK: - Store
@MainActor
final class Store<State, Action>: ObservableObject {
    @Published private(set) var state: State
    private let _reduce: (inout State, Action) -> Effect<Action>
    private var cancellables = Set<AnyCancellable>()

    init(initialState: State, reduce: @escaping (inout State, Action) -> Effect<Action>) {
        self.state = initialState
        self._reduce = reduce
    }

    func send(_ action: Action) {
        let effect = _reduce(&state, action)
        if let cancellable = effect.operation({ [weak self] nextAction in
            self?.send(nextAction)
        }) {
            cancellable.store(in: &cancellables)
        }
    }
}
