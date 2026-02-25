//
//  OnboardingButton.swift
//  Live Beer App
//
//  Created by Константин Клинов on 25/02/26.
//

import SwiftUI

struct OnboardingButton: View {
    
    let title: String
    let style: OnboardingButtonStyle
    let isEnabled: Bool
    let action: () -> Void
    
    var body: some View {
        let config = style.configuration
        
        Button(action: action) {
            Text(title)
                .font(AppFont.Button.primary)
                .frame(maxWidth: .infinity)
                .frame(height: 54)
                .background(config.background)
                .foregroundColor(config.foregroundColor)
                .cornerRadius(config.cornerRadius)
                .overlay(
                    RoundedRectangle(cornerRadius: config.cornerRadius)
                        .stroke(config.borderColor, lineWidth: config.borderWidth)
                )
        }
        .disabled(!isEnabled)
        .opacity(isEnabled ? 1.0 : 0.35)
    }
}


// MARK: - Button Style

enum OnboardingButtonStyle {
    case primary
    case secondary
    case ghost
    case yellow
    
    var configuration: OnboardingButtonStyleConfiguration {
        switch self {
            
        case .primary:
            return .init(
                background: AnyView(
                    LinearGradient(
                        colors: [AppColor.gradientStart, AppColor.gradientEnd],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                ),
                foregroundColor: .white,
                borderColor: .clear,
                borderWidth: 0,
                cornerRadius: 14
            )
            
        case .secondary:
            return .init(
                background: AnyView(AppColor.white),
                foregroundColor: AppColor.primaryText,
                borderColor: AppColor.border,
                borderWidth: 1,
                cornerRadius: 10
            )
            
        case .ghost:
            return .init(
                background: AnyView(AppColor.clear),
                foregroundColor: .white.opacity(0.6),
                borderColor: .white.opacity(0.3),
                borderWidth: 1.5,
                cornerRadius: 14
            )
            
        case .yellow:
            return .init(
                background: AnyView(AppColor.yellow),
                foregroundColor: AppColor.primaryText,
                borderColor: .clear,
                borderWidth: 0,
                cornerRadius: 10
            )
        }
    }
}

struct OnboardingButtonStyleConfiguration {
    let background: AnyView
    let foregroundColor: Color
    let borderColor: Color
    let borderWidth: CGFloat
    let cornerRadius: CGFloat
}
