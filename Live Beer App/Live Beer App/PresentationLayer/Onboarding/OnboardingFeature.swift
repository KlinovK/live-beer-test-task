//
//  OnboardingFeature.swift
//  Live Beer App
//
//  Created by Константин Клинов on 25/02/26.
//

import SwiftUI

// Holds UI state for the Onboarding screen
struct OnboardingState: Equatable {
    var isRegistrationEnabled: Bool = true              // Register button state
    var isEnterWithoutRegistrationEnabled: Bool = false // Guest login button state
    var isEnterEnabled: Bool = false                    // Enter button state
}

// MARK: - Onboarding Actions

// User actions from Onboarding screen
enum OnboardingAction: Equatable {
    case registerTapped
    case enterWithoutRegistrationTapped
    case enterTapped
}

// MARK: - Onboarding Reducer

// Handles state changes for Onboarding
func onboardingReducer(
    state: inout OnboardingState,
    action: OnboardingAction
) -> Effect<OnboardingAction> {
    
    switch action {
        
    case .registerTapped:
        // Navigation is handled by the coordinator
        return .none
        
    case .enterWithoutRegistrationTapped:
        return .none
        
    case .enterTapped:
        return .none
    }
}

