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
            AppColor.background.ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    headerSection
                        .padding(.top, 56)
                        .padding(.horizontal, 24)
                    
                    formSection
                        .padding(.top, 32)
                        .padding(.horizontal, 24)
                    
                    registerButton
                        .padding(.top, 24)
                        .padding(.horizontal, 24)
                        .padding(.bottom, 40)
                }
            }
        }
        .onTapGesture { focusedField = nil }
        .onChange(of: focusedField) { newValue in
            if newValue != .phone {
                dispatch(.phoneEditingFinished)
            }
        }
    }
    
    // MARK: - Header
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Регистрация аккаунта")
                .font(AppFont.Registration.title)
                .foregroundColor(AppColor.primaryText)
            
            Text("Заполните поля данных ниже")
                .font(AppFont.Registration.subTitle)
                .foregroundColor(AppColor.secondaryText)
        }
    }
    
    // MARK: - Form
    private var formSection: some View {
        VStack(spacing: 8) {
            FormField(
                title: "Номер телефона",
                placeholder: "+7",
                text: Binding(
                    get: { state.phoneNumber },
                    set: { dispatch(.phoneNumberChanged($0)) }
                ),
                keyboardType: .phonePad,
                isInvalid: state.didFinishEditingPhone && !state.isPhoneValid
            )
            .focused($focusedField, equals: .phone)
            
            FormField(
                title: "Ваше имя",
                placeholder: "Введите имя",
                text: Binding(
                    get: { state.name },
                    set: { dispatch(.nameChanged($0)) }
                ),
                isInvalid: false
            )
            .focused($focusedField, equals: .name)
            
            birthDateField
            agreementRow
        }
    }
    
    // MARK: - Birth Date
    private var birthDateField: some View {
        VStack(alignment: .leading, spacing: 6) {
            
            Text("Дата рождения")
                .font(AppFont.Registration.subTitle)
                .foregroundColor(AppColor.secondaryText)
            
            Button {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                    dispatch(.datePickerToggled)
                }
            } label: {
                HStack {
                    Text(state.formattedBirthDate.isEmpty ? "ДД.ММ.ГГ" : state.formattedBirthDate)
                        .font(.system(size: 15))
                        .foregroundColor(
                            state.formattedBirthDate.isEmpty
                            ? AppColor.secondaryText.opacity(0.6)
                            : AppColor.secondaryText
                        )
                    
                    Spacer()
                }
                .padding(.horizontal, 16)
                .frame(height: 54)
                .background(Color.white)
                .cornerRadius(14)
                .shadow(color: Color.black.opacity(0.05), radius: 6, x: 0, y: 2)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            
            if state.isDatePickerVisible {
                DatePicker(
                    "",
                    selection: Binding(
                        get: { state.birthDate ?? Date() },
                        set: { dispatch(.birthDateChanged($0)) }
                    ),
                    in: ...Date(),
                    displayedComponents: .date
                )
                .datePickerStyle(.wheel)
                .labelsHidden()
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(14)
                .padding(.top, 4)
                .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
    }
    
    private var agreementRow: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.15)) {
                dispatch(.agreementToggled)
            }
        } label: {
            HStack(alignment: .top, spacing: 10) {
                
                ZStack {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(AppColor.border, lineWidth: 2)
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .fill(state.isAgreementChecked ? AppColor.border : Color.clear)
                        )
                        .frame(width: 22, height: 22)
                    
                    if state.isAgreementChecked {
                        Image(systemName: "checkmark")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
                .padding(.top, 2)
                
                Text("Я согласен с условиями обработки персональных данных.")
                    .font(AppFont.Registration.subTitle)
                    .foregroundColor(AppColor.primaryText)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer(minLength: 0)
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
    
    // MARK: - Register Button
    private var registerButton: some View {
        OnboardingButton(
            title: "Зарегистрироваться",
            style: .yellow,
            isEnabled: state.isValid
        ) {
            dispatch(.registerButtonTapped)
        }
    }
}

private struct FormField: View {
    
    let title: String
    let placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    let isInvalid: Bool
        
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            
            Text(title)
                .font(AppFont.Registration.subTitle)
                .foregroundColor(isInvalid ? AppColor.error : AppColor.secondaryText)
            
            HStack {
                TextField(placeholder, text: $text)
                    .font(AppFont.Registration.subTitle)
                    .foregroundColor(AppColor.primaryText)
                    .keyboardType(keyboardType)
            }
            .padding(.horizontal, 16)
            .frame(height: 48)
            .background(AppColor.background)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(
                        isInvalid ? AppColor.error : AppColor.border,
                        lineWidth: 1
                    )
            )
        }
    }
}
