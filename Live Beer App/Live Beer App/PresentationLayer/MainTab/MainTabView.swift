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
    
    init(state: MainTabState, dispatch: @escaping (MainTabAction) -> Void) {
        self.state = state
        self.dispatch = dispatch
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        // Selected item
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(AppColor.yellow)
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor(AppColor.yellow)
        ]
        
        // Unselected item
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor(AppColor.secondaryText)
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor(AppColor.secondaryText)
        ]
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
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
        .tint(AppColor.yellow)
    }
}

// MARK: - Empty Tab Screens

struct MainScreenView: View {
    
    var userName: String = "Name"
    
    var body: some View {
        ZStack(alignment: .top) {
            
            Image("BrandingBackgroundIcon")
                .resizable()
                .scaledToFill()
                .frame(height: 400)
                .frame(maxWidth: .infinity)
                .clipped()
                .ignoresSafeArea(edges: [.top, .horizontal])
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    
                    headerSection
                    iconsSection
                    infoCardSection
                    labelWithIconSection
                    horizontalCardsSection
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 40)
            }
        }
        .background(AppColor.background)
    }
}

private extension MainScreenView {
    
    var headerSection: some View {
        
        VStack {
            
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(AppColor.yellow)
                        .frame(width: 40, height: 40)
                    
                    Image("PersonIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                }
                
                    Text("Привет,")
                    .font(AppFont.MainTab.title)
                    .foregroundColor(AppColor.secondaryText)
                    
                    Text(userName)
                    .font(AppFont.MainTab.title)
                    .foregroundColor(AppColor.primaryText)
            }
            
            
            Spacer()
            
            Button {
                print("Показать код")
            } label: {
                HStack(spacing: 6) {
                    Image(systemName: "qrcode")
                    Text("Показать мой код")
                        .font(.subheadline)
                        .bold()
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color.yellow)
                .cornerRadius(10)
                .foregroundColor(.black)
            }
        }
    }
}

private extension MainScreenView {
    
    var iconsSection: some View {
        VStack(spacing: 16) {
            
            // Row 1 – горизонтальные 10 иконок
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(0..<10) { _ in
                        Image(systemName: "star.fill")
                            .frame(width: 44, height: 44)
                            .background(Color.yellow.opacity(0.2))
                            .clipShape(Circle())
                    }
                }
            }
            
            // Row 2
            HStack(alignment: .top, spacing: 16) {
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Баланс")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text("1 250 ₽")
                        .font(.title3)
                        .bold()
                }
                
                Text("Используйте баллы для получения скидок и бонусов в магазинах.")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
        }
    }
}

private extension MainScreenView {
    
    var infoCardSection: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Мои заказы")
                    .font(.headline)
                
                Text("Просмотреть историю")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.gray.opacity(0.08))
        .cornerRadius(14)
    }
}

private extension MainScreenView {
    
    var labelWithIconSection: some View {
        HStack {
            Text("Поддержка")
                .font(.headline)
            
            Spacer()
            
            Image(systemName: "headphones")
        }
    }
}

private extension MainScreenView {
    
    var horizontalCardsSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(0..<3) { index in
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Карточка \(index + 1)")
                            .font(.headline)
                        
                        Text("Описание карточки")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .frame(width: 220)
                    .background(Color.yellow.opacity(0.15))
                    .cornerRadius(16)
                }
            }
        }
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

struct EmptyTabView: View {
    let tab: AppTab
    
    var body: some View {
        ZStack {
            AppColor.background.ignoresSafeArea()
            Text("Coming soon")
                .font(.system(size: 14))
                .foregroundColor(Color(hex: "8A8FA8"))
            
        }
        .navigationTitle(tab.title)
    }
}
