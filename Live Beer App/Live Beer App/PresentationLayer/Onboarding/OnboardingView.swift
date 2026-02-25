//
//  OnboardingView.swift
//  Live Beer App
//
//  Created by Константин Клинов on 25/02/26.
//

import Foundation
import SwiftUI

// MARK: - Onboarding View

struct OnboardingView: View {
    
    let state: OnboardingState
    let dispatch: (OnboardingAction) -> Void
    
    var body: some View {
        ZStack {
            AppColor.background
                .ignoresSafeArea()
            
            VStack {
                headerSection
                
                Spacer()
                
                titleSection
                
                Spacer()
                
                buttonsSection
            }
        }
    }
}

// MARK: - Sections

private extension OnboardingView {
    
    var headerSection: some View {
        ZStack {
            Image("BrandingBackgroundIcon")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .clipped()
            
            Image("LiveBeerBrandingIcon")
                .resizable()
                .scaledToFit()
        }
        .ignoresSafeArea(edges: [.top, .horizontal])
    }
    
    var titleSection: some View {
        Text("Программа лояльности для клиентов LiveBeer")
            .font(AppFont.Onboarding.title)
            .multilineTextAlignment(.center)
            .foregroundColor(AppColor.primaryText)
            .padding(.horizontal, 25)
    }
    
    var buttonsSection: some View {
        VStack(spacing: 12) {
            
            HStack(spacing: 10) {
                OnboardingButton(
                    title: "Вход",
                    style: .yellow,
                    isEnabled: state.isEnterEnabled
                ) {
                    dispatch(.enterTapped)
                }
                
                OnboardingButton(
                    title: "Регистрация",
                    style: .yellow,
                    isEnabled: state.isRegistrationEnabled
                ) {
                    dispatch(.registerTapped)
                }
            }
            
            OnboardingButton(
                title: "Войти без регистрации",
                style: .secondary,
                isEnabled: state.isEnterWithoutRegistrationEnabled
            ) {
                dispatch(.enterWithoutRegistrationTapped)
            }
        }
        .padding(.horizontal, 30)
        .padding(.bottom, 13)
    }
}



