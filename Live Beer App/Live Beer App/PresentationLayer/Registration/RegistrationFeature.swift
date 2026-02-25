//
//  RegistrationFeature.swift
//  Live Beer App
//
//  Created by Константин Клинов on 25/02/26.
//

import Foundation
import SwiftUI
import Combine

// MARK: - Registration State
struct RegistrationState: Equatable {
    var phoneNumber: String = ""
    var name: String = ""
    var birthDate: Date = Calendar.current.date(byAdding: .year, value: -18, to: Date()) ?? Date()
    var isAgreementChecked: Bool = false
    var isDatePickerVisible: Bool = false
    var isLoading: Bool = false
    
    var isValid: Bool {
        !phoneNumber.isEmpty &&
        !name.isEmpty &&
        isAgreementChecked &&
        phoneNumber.count >= 10
    }
    
    var formattedBirthDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd / MM / yyyy"
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
    case registrationCompleted
}

// MARK: - Registration Reducer
func registrationReducer(
    state: inout RegistrationState,
    action: RegistrationAction
) -> Effect<RegistrationAction> {
    switch action {
    case .phoneNumberChanged(let phone):
        state.phoneNumber = phone
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
        
    case .registerButtonTapped:
        guard state.isValid else { return .none }
        state.isLoading = true
        return .run { dispatch in
            // Simulate network call
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                dispatch(.registrationCompleted)
            }
        }
        
    case .registrationCompleted:
        state.isLoading = false
        return .none
    }
}

// MARK: - Registration ViewModel
@MainActor
final class RegistrationViewModel: ObservableObject {
    @Published var state: RegistrationState
    let dispatch: (RegistrationAction) -> Void
    
    init(state: RegistrationState, dispatch: @escaping (RegistrationAction) -> Void) {
        self.state = state
        self.dispatch = dispatch
    }
    
    func phoneChanged(_ value: String) { dispatch(.phoneNumberChanged(value)) }
    func nameChanged(_ value: String) { dispatch(.nameChanged(value)) }
    func dateChanged(_ value: Date) { dispatch(.birthDateChanged(value)) }
    func toggleAgreement() { dispatch(.agreementToggled) }
    func toggleDatePicker() { dispatch(.datePickerToggled) }
    func register() { dispatch(.registerButtonTapped) }
}
