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

// MARK: - Onboarding Store
final class OnboardingStore: ObservableObject {
    @MainActor @Published private(set) var state: OnboardingState

    init(initialState: OnboardingState = OnboardingState()) {
        self.state = initialState
    }

    @MainActor func send(_ action: OnboardingAction) {
        _ = onboardingReducer(state: &state, action: action)
    }
}

