//
//  MainTabView.swift
//  Live Beer App
//
//  Created by Константин Клинов on 25/02/26.
//

import Foundation
import SwiftUI

// MARK: - MainTabView
struct MainTabView: View {
    let state: MainTabState
    let dispatch: (MainTabAction) -> Void
    
    var body: some View {
        TabView(selection: Binding(
            get: { state.selectedTab.rawValue },
            set: { dispatch(.tabSelected(AppTab(rawValue: $0) ?? .main)) }
        )) {
            MainScreenView()
                .tabItem {
                    Label(AppTab.main.title, systemImage: AppTab.main.icon)
                }
                .tag(AppTab.main.rawValue)
            
            DiscountsScreenView()
                .tabItem {
                    Label(AppTab.discounts.title, systemImage: AppTab.discounts.icon)
                }
                .tag(AppTab.discounts.rawValue)
            
            MarketsScreenView()
                .tabItem {
                    Label(AppTab.markets.title, systemImage: AppTab.markets.icon)
                }
                .tag(AppTab.markets.rawValue)
            
            ProfileScreenView()
                .tabItem {
                    Label(AppTab.profile.title, systemImage: AppTab.profile.icon)
                }
                .tag(AppTab.profile.rawValue)
        }
        .tint(Color(hex: "E94560"))
    }
}

// MARK: - Empty Tab Screens

struct MainScreenView: View {
    var body: some View {
        EmptyTabView(tab: .main)
    }
}

struct DiscountsScreenView: View {
    var body: some View {
        EmptyTabView(tab: .discounts)
    }
}

struct MarketsScreenView: View {
    var body: some View {
        EmptyTabView(tab: .markets)
    }
}

struct ProfileScreenView: View {
    var body: some View {
        EmptyTabView(tab: .profile)
    }
}

// MARK: - Generic Empty Tab View
struct EmptyTabView: View {
    let tab: AppTab
    
    var body: some View {
        ZStack {
            Color(hex: "F5F7FA").ignoresSafeArea()
            
            VStack(spacing: 20) {
                Image(systemName: tab.icon)
                    .font(.system(size: 60))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [Color(hex: "E94560").opacity(0.6), Color(hex: "0F3460").opacity(0.4)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                
                Text(tab.title)
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(Color(hex: "1A1A2E"))
                
                Text("Coming soon")
                    .font(.system(size: 14))
                    .foregroundColor(Color(hex: "8A8FA8"))
            }
        }
        .navigationTitle(tab.title)
    }
}

// MARK: - Preview
struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView(
            state: MainTabState(),
            dispatch: { _ in }
        )
    }
}
