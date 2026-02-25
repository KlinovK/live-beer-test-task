//
//  OnboardingFeature.swift
//  Live Beer App
//
//  Created by Константин Клинов on 25/02/26.
//

import SwiftUI

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
        // Navigation handled by coordinator
        return .none
    case .enterWithoutRegistrationTapped:
        return .none
    case .enterTapped:
        return .none
    }
}

