//
//  AppCoordinator.swift
//  Live Beer App
//
//  Created by Константин Клинов on 25/02/26.
//

import Foundation
import SwiftUI

// MARK: - Router / Navigation

enum Route: Equatable {
    case onboarding
    case registration
    case mainTab
}

// MARK: - App Coordinator (Root)

struct AppCoordinatorState: Equatable {
    var route: Route = .onboarding
    var onboarding = OnboardingState()
    var registration = RegistrationState()
    var mainTab = MainTabState()
}

enum AppCoordinatorAction {
    case onboarding(OnboardingAction)
    case registration(RegistrationAction)
    case mainTab(MainTabAction)
    case navigate(Route)
}

func appCoordinatorReducer(
    state: inout AppCoordinatorState,
    action: AppCoordinatorAction
) -> Effect<AppCoordinatorAction> {
    switch action {
    case .onboarding(let onboardingAction):
        let effect = onboardingReducer(state: &state.onboarding, action: onboardingAction)
        switch onboardingAction {
        case .registerTapped:
            state.route = .registration
        default:
            break
        }
        return effect.map(AppCoordinatorAction.onboarding)

    case .registration(let registrationAction):
        let effect = registrationReducer(state: &state.registration, action: registrationAction)
        switch registrationAction {
        case .registerButtonTapped where state.registration.isValid:
            state.route = .mainTab
        default:
            break
        }
        return effect.map(AppCoordinatorAction.registration)

    case .mainTab(let tabAction):
        return mainTabReducer(state: &state.mainTab, action: tabAction)
            .map(AppCoordinatorAction.mainTab)

    case .navigate(let route):
        state.route = route
        return .none
    }
}

typealias AppStore = Store<AppCoordinatorState, AppCoordinatorAction>
