//
//  AppCoordinator.swift
//  Live Beer App
//
//  Created by Константин Клинов on 25/02/26.
//

import Foundation
import SwiftUI

// Defines navigation routes in the app
enum Route: Equatable {
    case onboarding
    case registration
    case mainTab
}

// Holds all coordinator-level state
struct AppCoordinatorState: Equatable {
    var route: Route = .onboarding           // Current screen
    var onboarding = OnboardingState()       // Onboarding state
    var registration = RegistrationState()   // Registration state
    var mainTab = MainTabState()             // MainTab state
    var username: String?                     // Logged-in username
}

// Coordinator actions wrapping feature actions or navigation
enum AppCoordinatorAction {
    case onboarding(OnboardingAction)
    case registration(RegistrationAction)
    case mainTab(MainTabAction)
    case navigate(Route)                      // Explicit route change
}

// MARK: - Coordinator Reducer

// Handles all app-level state updates and navigation
func appCoordinatorReducer(
    state: inout AppCoordinatorState,
    action: AppCoordinatorAction
) -> Effect<AppCoordinatorAction> {
    
    switch action {
        
    case .onboarding(let onboardingAction):
        // Delegate to onboarding reducer
        let effect = onboardingReducer(state: &state.onboarding, action: onboardingAction)
        
        // Navigate to registration if user tapped Register
        switch onboardingAction {
        case .registerTapped:
            state.route = .registration
        default:
            break
        }
        
        return effect.map(AppCoordinatorAction.onboarding)
        
    case .registration(let registrationAction):
        // Delegate to registration reducer
        let effect = registrationReducer(state: &state.registration, action: registrationAction)
        
        // Navigate to main tab if registration succeeded
        switch registrationAction {
        case .registerButtonTapped where state.registration.isValid:
            state.username = state.registration.name
            state.route = .mainTab
        default:
            break
        }
        
        return effect.map(AppCoordinatorAction.registration)
        
    case .mainTab(let tabAction):
        // Delegate to MainTab reducer
        return mainTabReducer(state: &state.mainTab, action: tabAction)
            .map(AppCoordinatorAction.mainTab)
        
    case .navigate(let route):
        // Direct route change
        state.route = route
        return .none
    }
}

// Convenience typealias for the global app store
typealias AppStore = Store<AppCoordinatorState, AppCoordinatorAction>
