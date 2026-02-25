//
//  RegistrationFeature.swift
//  Live Beer App
//
//  Created by Константин Клинов on 25/02/26.
//

import SwiftUI

struct RegistrationState: Equatable {
    var phoneNumber = ""
    var name = ""
    var birthDate: Date?
    var isAgreementChecked = false
    var isDatePickerVisible = false
    
    var didFinishEditingPhone = false
    var didAttemptSubmit = false
    
    var cleanedPhoneNumber: String {
        phoneNumber.filter { $0.isNumber }
    }
    
    var isPhoneValid: Bool {
        cleanedPhoneNumber.count >= 10
    }
    
    var isValid: Bool {
        isPhoneValid &&
        isAgreementChecked
    }
    
    var formattedBirthDate: String {
        guard let birthDate else { return "" }
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        return formatter.string(from: birthDate)
    }
}

// MARK: - Registration Actions
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
func registrationReducer(
    state: inout RegistrationState,
    action: RegistrationAction
) -> Effect<RegistrationAction> {
    
    switch action {
        
    case .phoneNumberChanged(let phone):
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

