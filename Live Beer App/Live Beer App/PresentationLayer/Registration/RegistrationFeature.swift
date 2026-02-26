//
//  RegistrationFeature.swift
//  Live Beer App
//
//  Created by Константин Клинов on 25/02/26.
//

import SwiftUI

// State for the Registration screen
struct RegistrationState: Equatable {
    var phoneNumber = ""                  // Raw phone input
    var name = ""                         // User name
    var birthDate: Date?                  // Optional birth date
    var isAgreementChecked = false        // Terms agreement toggle
    var isDatePickerVisible = false       // Controls date picker visibility
    
    var didFinishEditingPhone = false     // Flag when phone editing ends
    var didAttemptSubmit = false          // Flag when register tapped
    
    // Only digits from phone number
    var cleanedPhoneNumber: String {
        phoneNumber.filter { $0.isNumber }
    }
    
    // Check if phone is valid (10+ digits)
    var isPhoneValid: Bool {
        cleanedPhoneNumber.count >= 10
    }
    
    // Form is valid if phone is valid and agreement checked
    var isValid: Bool {
        isPhoneValid &&
        isAgreementChecked
    }
    
    // Formatted birth date as "dd.MM.yy"
    var formattedBirthDate: String {
        guard let birthDate else { return "" }
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        return formatter.string(from: birthDate)
    }
}

// MARK: - Registration Actions

// Actions from the registration screen
enum RegistrationAction: Equatable {
    case phoneNumberChanged(String)
    case nameChanged(String)
    case birthDateChanged(Date)
    case agreementToggled
    case datePickerToggled
    case registerButtonTapped
    case phoneEditingFinished
}

// MARK: - Registration Reducer

// Handles state updates based on actions
func registrationReducer(
    state: inout RegistrationState,
    action: RegistrationAction
) -> Effect<RegistrationAction> {
    
    switch action {
        
    case .phoneNumberChanged(let phone):
        // Allow numbers and "+" only
        state.phoneNumber = phone.filter { $0.isNumber || $0 == "+" }
        return .none
        
    case .nameChanged(let name):
        state.name = name
        return .none
        
    case .birthDateChanged(let date):
        state.birthDate = date
        return .none
        
    case .agreementToggled:
        state.isAgreementChecked.toggle()
        return .none
        
    case .datePickerToggled:
        state.isDatePickerVisible.toggle()
        return .none
        
    case .phoneEditingFinished:
        state.didFinishEditingPhone = true
        return .none
        
    case .registerButtonTapped:
        state.didAttemptSubmit = true
        return .none
    }
}

