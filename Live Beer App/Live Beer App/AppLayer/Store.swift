//
//  Store.swift
//  Live Beer App
//
//  Created by Константин Клинов on 25/02/26.
//

import Foundation
import Combine

// Represents a side effect that can produce actions asynchronously
struct Effect<Action> {
    
    // Executes the effect and optionally returns a cancellable
    let operation: (@escaping (Action) -> Void) -> AnyCancellable?

    // No effect
    static var none: Effect<Action> {
        Effect { _ in nil }
    }

    // Immediately sends an action on the main thread
    static func send(_ action: Action) -> Effect<Action> {
        Effect { dispatch in
            DispatchQueue.main.async { dispatch(action) }
            return AnyCancellable {}
        }
    }

    // Runs custom async work and allows dispatching actions
    static func run(_ body: @escaping (@escaping (Action) -> Void) -> Void) -> Effect<Action> {
        Effect { dispatch in
            body(dispatch)
            return AnyCancellable {}
        }
    }

    // Transforms Effect<Action> into Effect<NewAction>
    func map<NewAction>(_ transform: @escaping (Action) -> NewAction) -> Effect<NewAction> {
        Effect<NewAction> { dispatchNew in
            self.operation { action in
                dispatchNew(transform(action))
            }
        }
    }
}

@MainActor
final class Store<State, Action>: ObservableObject {
    
    // Current state of the app
    @Published private(set) var state: State
    
    // Reducer function
    private let _reduce: (inout State, Action) -> Effect<Action>
    
    // Stores active cancellables
    private var cancellables = Set<AnyCancellable>()

    init(initialState: State, reduce: @escaping (inout State, Action) -> Effect<Action>) {
        self.state = initialState
        self._reduce = reduce
    }

    // Sends an action to the reducer
    func send(_ action: Action) {
        
        // Update state and get effect
        let effect = _reduce(&state, action)
        
        // Execute effect if it exists
        if let cancellable = effect.operation({ [weak self] nextAction in
            self?.send(nextAction)
        }) {
            cancellable.store(in: &cancellables)
        }
    }
}
