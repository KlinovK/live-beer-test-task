//
//  OnboardingView.swift
//  Live Beer App
//
//  Created by Константин Клинов on 25/02/26.
//

import Foundation
import SwiftUI

struct OnboardingView: View {
    let state: OnboardingState
    let dispatch: (OnboardingAction) -> Void
    
    @StateObject private var viewModel: OnboardingViewModel
    
    init(state: OnboardingState, dispatch: @escaping (OnboardingAction) -> Void) {
        self.state = state
        self.dispatch = dispatch
        _viewModel = StateObject(wrappedValue: OnboardingViewModel(state: state, dispatch: dispatch))
    }
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(hex: "1A1A2E"), Color(hex: "16213E"), Color(hex: "0F3460")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer()
                
                // Logo / Brand area
                VStack(spacing: 16) {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [Color(hex: "E94560"), Color(hex: "0F3460")],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 100, height: 100)
                        .overlay(
                            Image(systemName: "star.fill")
                                .font(.system(size: 44))
                                .foregroundColor(.white)
                        )
                    
                    Text("Welcome")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("Your journey starts here")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(Color.white.opacity(0.6))
                }
                
                Spacer()
                
                // Buttons
                VStack(spacing: 16) {
                    OnboardingButton(
                        title: "Registration",
                        style: .primary,
                        isEnabled: state.isRegistrationEnabled
                    ) {
                        dispatch(.registerTapped)
                    }
                    
                    OnboardingButton(
                        title: "Enter without registration",
                        style: .secondary,
                        isEnabled: state.isEnterWithoutRegistrationEnabled
                    ) {
                        dispatch(.enterWithoutRegistrationTapped)
                    }
                    
                    OnboardingButton(
                        title: "Enter",
                        style: .ghost,
                        isEnabled: state.isEnterEnabled
                    ) {
                        dispatch(.enterTapped)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 52)
            }
        }
    }
}

// MARK: - Button Styles
private enum OnboardingButtonStyle {
    case primary, secondary, ghost
}

private struct OnboardingButton: View {
    let title: String
    let style: OnboardingButtonStyle
    let isEnabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .frame(maxWidth: .infinity)
                .frame(height: 54)
                .background(backgroundView)
                .foregroundColor(foregroundColor)
                .cornerRadius(14)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(borderColor, lineWidth: style == .ghost ? 1.5 : 0)
                )
        }
        .disabled(!isEnabled)
        .opacity(isEnabled ? 1.0 : 0.35)
    }
    
    @ViewBuilder
    private var backgroundView: some View {
        switch style {
        case .primary:
            LinearGradient(
                colors: [Color(hex: "E94560"), Color(hex: "C62A47")],
                startPoint: .leading,
                endPoint: .trailing
            )
        case .secondary:
            Color.white.opacity(0.12)
        case .ghost:
            Color.clear
        }
    }
    
    private var foregroundColor: Color {
        switch style {
        case .primary: return .white
        case .secondary: return .white.opacity(0.85)
        case .ghost: return .white.opacity(0.6)
        }
    }
    
    private var borderColor: Color {
        style == .ghost ? Color.white.opacity(0.3) : Color.clear
    }
}

// MARK: - Color Extension
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        let r = Double((rgb >> 16) & 0xFF) / 255
        let g = Double((rgb >> 8) & 0xFF) / 255
        let b = Double(rgb & 0xFF) / 255
        self.init(red: r, green: g, blue: b)
    }
}

// MARK: - Preview
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(
            state: OnboardingState(),
            dispatch: { _ in }
        )
    }
}
