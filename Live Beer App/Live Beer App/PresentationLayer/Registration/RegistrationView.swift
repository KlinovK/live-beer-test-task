//
//  RegistrationView.swift
//  Live Beer App
//
//  Created by Константин Клинов on 25/02/26.
//

import Foundation
import SwiftUI

struct RegistrationView: View {
    let state: RegistrationState
    let dispatch: (RegistrationAction) -> Void
    
    @FocusState private var focusedField: Field?
    
    enum Field { case phone, name }
    
    var body: some View {
        ZStack {
            Color(hex: "F5F7FA").ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    // Header
                    headerSection
                        .padding(.top, 60)
                        .padding(.horizontal, 24)
                    
                    // Form
                    formSection
                        .padding(.top, 32)
                        .padding(.horizontal, 24)
                    
                    // Register Button
                    registerButton
                        .padding(.top, 32)
                        .padding(.horizontal, 24)
                        .padding(.bottom, 40)
                }
            }
        }
        .onTapGesture { focusedField = nil }
    }
    
    // MARK: - Header
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Create Account")
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(Color(hex: "1A1A2E"))
            
            Text("Fill in the details below to get started")
                .font(.system(size: 15, weight: .regular))
                .foregroundColor(Color(hex: "8A8FA8"))
        }
    }
    
    // MARK: - Form
    private var formSection: some View {
        VStack(spacing: 20) {
            // Phone field
            FormField(icon: "phone.fill", placeholder: "Phone Number", text: Binding(
                get: { state.phoneNumber },
                set: { dispatch(.phoneNumberChanged($0)) }
            ), keyboardType: .phonePad)
            .focused($focusedField, equals: .phone)
            
            // Name field
            FormField(icon: "person.fill", placeholder: "Full Name", text: Binding(
                get: { state.name },
                set: { dispatch(.nameChanged($0)) }
            ))
            .focused($focusedField, equals: .name)
            
            // Birth date field
            birthDateField
            
            // Agreement
            agreementRow
        }
    }
    
    // MARK: - Birth Date
    private var birthDateField: some View {
        VStack(spacing: 0) {
            Button(action: { dispatch(.datePickerToggled) }) {
                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(Color(hex: "E94560"))
                        .frame(width: 20)
                    
                    Text(state.formattedBirthDate)
                        .font(.system(size: 15))
                        .foregroundColor(Color(hex: "1A1A2E"))
                    
                    Spacer()
                    
                    Image(systemName: state.isDatePickerVisible ? "chevron.up" : "chevron.down")
                        .foregroundColor(Color(hex: "8A8FA8"))
                        .font(.system(size: 12, weight: .semibold))
                }
                .padding(.horizontal, 16)
                .frame(height: 54)
                .background(Color.white)
                .cornerRadius(14)
                .shadow(color: Color.black.opacity(0.05), radius: 6, x: 0, y: 2)
            }
            
            if state.isDatePickerVisible {
                DatePicker(
                    "",
                    selection: Binding(
                        get: { state.birthDate },
                        set: { dispatch(.birthDateChanged($0)) }
                    ),
                    displayedComponents: .date
                )
                .datePickerStyle(.graphical)
                .background(Color.white)
                .cornerRadius(14)
                .padding(.top, 4)
                .transition(.scale(scale: 0.95, anchor: .top).combined(with: .opacity))
                .animation(.spring(response: 0.3), value: state.isDatePickerVisible)
            }
        }
    }
    
    // MARK: - Agreement
    private var agreementRow: some View {
        Button(action: { dispatch(.agreementToggled) }) {
            HStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(
                            state.isAgreementChecked ? Color(hex: "E94560") : Color(hex: "D0D3E0"),
                            lineWidth: 2
                        )
                        .frame(width: 22, height: 22)
                        .background(
                            RoundedRectangle(cornerRadius: 6)
                                .fill(state.isAgreementChecked ? Color(hex: "E94560") : Color.clear)
                        )
                    
                    if state.isAgreementChecked {
                        Image(systemName: "checkmark")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
                
                Text("I agree to the Terms & Conditions")
                    .font(.system(size: 14))
                    .foregroundColor(Color(hex: "4A4F6B"))
                
                Spacer()
            }
        }
    }
    
    // MARK: - Register Button
    private var registerButton: some View {
        Button(action: { dispatch(.registerButtonTapped) }) {
            ZStack {
                if state.isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .tint(.white)
                } else {
                    Text("Register")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 54)
            .background(
                state.isValid
                ? LinearGradient(colors: [Color(hex: "E94560"), Color(hex: "C62A47")], startPoint: .leading, endPoint: .trailing)
                : LinearGradient(colors: [Color(hex: "D0D3E0"), Color(hex: "D0D3E0")], startPoint: .leading, endPoint: .trailing)
            )
            .cornerRadius(14)
        }
        .disabled(!state.isValid || state.isLoading)
    }
}

// MARK: - Form Field Component
private struct FormField: View {
    let icon: String
    let placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(Color(hex: "E94560"))
                .frame(width: 20)
            
            TextField(placeholder, text: $text)
                .font(.system(size: 15))
                .keyboardType(keyboardType)
                .foregroundColor(Color(hex: "1A1A2E"))
        }
        .padding(.horizontal, 16)
        .frame(height: 54)
        .background(Color.white)
        .cornerRadius(14)
        .shadow(color: Color.black.opacity(0.05), radius: 6, x: 0, y: 2)
    }
}

// MARK: - Preview
struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView(
            state: RegistrationState(),
            dispatch: { _ in }
        )
    }
}
