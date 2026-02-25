//
//  AppCoordinatorView.swift
//  Live Beer App
//
//  Created by Константин Клинов on 25/02/26.
//

import Foundation
import SwiftUI

struct AppCoordinatorView: View {
    @StateObject private var store: AppStore
    
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
                MainTabView(
                    state: store.state.mainTab,
                    dispatch: { store.send(.mainTab($0)) }
                )
                .transition(.opacity)
                #warning("")
//                OnboardingView(
//                    state: store.state.onboarding,
//                    dispatch: { store.send(.onboarding($0)) }
//                )
//                .transition(.opacity)
                
            case .registration:
                RegistrationView(
                    state: store.state.registration,
                    dispatch: { store.send(.registration($0)) }
                )
                .transition(.move(edge: .trailing))
                
            case .mainTab:
                MainTabView(
                    state: store.state.mainTab,
                    dispatch: { store.send(.mainTab($0)) }
                )
                .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: store.state.route)
    }
}
