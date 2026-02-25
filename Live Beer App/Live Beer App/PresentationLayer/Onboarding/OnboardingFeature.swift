//
//  OnboardingFeature.swift
//  Live Beer App
//
//  Created by Константин Клинов on 25/02/26.
//

import Foundation
import SwiftUI
import Combine

// MARK: - Onboarding State
struct OnboardingState: Equatable {
    var isRegistrationEnabled: Bool = true
    var isEnterWithoutRegistrationEnabled: Bool = false
    var isEnterEnabled: Bool = false
}

// MARK: - Onboarding Actions
enum OnboardingAction: Equatable {
    case registerTapped
    case enterWithoutRegistrationTapped
    case enterTapped
}

// MARK: - Onboarding Reducer
func onboardingReducer(
    state: inout OnboardingState,
    action: OnboardingAction
) -> Effect<OnboardingAction> {
    switch action {
    case .registerTapped:
        return .none
    case .enterWithoutRegistrationTapped:
        return .none
    case .enterTapped:
        return .none
    }
}

// MARK: - Onboarding ViewModel
@MainActor
final class OnboardingViewModel: ObservableObject {
    @Published var state: OnboardingState
    let dispatch: (OnboardingAction) -> Void

    init(state: OnboardingState, dispatch: @escaping (OnboardingAction) -> Void) {
        self.state = state
        self.dispatch = dispatch
    }

    func registerTapped() { dispatch(.registerTapped) }
    func enterWithoutRegistrationTapped() { dispatch(.enterWithoutRegistrationTapped) }
    func enterTapped() { dispatch(.enterTapped) }
}
