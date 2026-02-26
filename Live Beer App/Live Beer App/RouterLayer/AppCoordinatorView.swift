//
//  AppCoordinatorView.swift
//  Live Beer App
//
//  Created by Константин Клинов on 25/02/26.
//

import SwiftUI

// Root view that displays the current screen based on the coordinator state
struct AppCoordinatorView: View {
    @StateObject private var store: AppStore
    
    // Initialize store with initial app state and reducer
    init() {
        _store = StateObject(wrappedValue: AppStore(
            initialState: AppCoordinatorState(),
            reduce: appCoordinatorReducer
        ))
    }
    
    var body: some View {
        Group {
            switch store.state.route {
                
            case .onboarding:
                // Show onboarding screen
                OnboardingView(
                    state: store.state.onboarding,
                    dispatch: { store.send(.onboarding($0)) }
                )
                .transition(.opacity)
                
            case .registration:
                // Show registration screen
                RegistrationView(
                    state: store.state.registration,
                    dispatch: { store.send(.registration($0)) }
                )
                .transition(.move(edge: .trailing))
                
            case .mainTab:
                // Show main tab interface
                MainTabView(
                    username: store.state.username ?? "",
                    state: store.state.mainTab,
                    dispatch: { store.send(.mainTab($0)) }
                )
                .transition(.opacity)
            }
        }
        // Animate route changes
        .animation(.easeInOut(duration: 0.3), value: store.state.route)
    }
}
