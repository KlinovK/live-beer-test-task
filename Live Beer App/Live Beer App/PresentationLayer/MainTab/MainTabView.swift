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
    
    let username: String
    let state: MainTabState
    let dispatch: (MainTabAction) -> Void
    
    init(username: String, state: MainTabState, dispatch: @escaping (MainTabAction) -> Void) {
        self.state = state
        self.dispatch = dispatch
        self.username = username
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(AppColor.yellow)
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor(AppColor.yellow)
        ]
        
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
            
            MainScreenView(
                username: username,
                state: state,
                dispatch: dispatch
            )
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
    
    let username: String
    let state: MainTabState
    let dispatch: (MainTabAction) -> Void

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
                VStack {
                    
                    headerSection
                    actionSection
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
                    
                    Text(username)
                    .font(AppFont.MainTab.title)
                    .foregroundColor(AppColor.primaryText)
            }
        }
        .padding(.bottom, 24)
    }
}

private extension MainScreenView {
    
    var actionSection: some View {
        Group {
            if state.isShowingBarcode,
               let value = state.barcodeValue {
                
                BarcodeView(code: value)
                
            } else {
                
                AppButton(
                    title: "Показать мой код",
                    style: .qr,
                    isEnabled: true,
                    icon: "barcode"
                ) {
                    dispatch(.showBarcodeTapped)
                }
            }
        }
        .padding(.bottom, 16)
    }
}

private extension MainScreenView {
        
    var iconsSection: some View {
        
        let addedCount = Int.random(in: 0...9)

        return VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 7) {
                    ForEach(0..<10, id: \.self) { index in
                        if index < addedCount {
                            Image("CupAddedIcon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 54)
                            
                        } else if index == 9 {
                            Image("LastCupIcon")
                                .frame(width: 24, height: 54)
                            
                        } else {
                            Image("CupIcon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 54)
                        }
                    }
                }
                .padding(.horizontal)
            }
            
            // Row 2
            HStack(alignment: .top, spacing: 16) {
                
                VStack(alignment: .leading, spacing: 3) {
                    Text("\(addedCount)/10")
                        .font(AppFont.MainTab.largeTitle)
                        .foregroundColor(.white)
                    
                    Text("Накоплено литров")
                        .font(AppFont.MainTab.subTitle)
                        .foregroundColor(.white)
                }
                
                Rectangle()
                    .fill(Color.gray.opacity(0.4))
                    .frame(width: 1, height: 56)
                
                Text("Копите литры и получайте пиво бесплатно")
                    .font(AppFont.MainTab.subTitle)
                    .foregroundColor(.white)
            }
            .padding(.horizontal)
        }
        .padding(.bottom, 6)
        .frame(maxWidth: .infinity)
        .frame(height: 152)
        .background(AppColor.brandBlack)
        .cornerRadius(10)
    }
}

private extension MainScreenView {
    
    var infoCardSection: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("3017")
                    .font(AppFont.MainTab.largeTitle)
                    .foregroundColor(.white)
                    .padding(.bottom, 3)
                
                Text("Накоплено баллов")
                    .font(AppFont.MainTab.subTitle)
                    .foregroundColor(.white)
                    .padding(.bottom, 7)
                
                Text("Собирайте баллы и получайте бонусы")
                    .font(AppFont.MainTab.subTitle)
                    .foregroundColor(.white)
            }
                        
            Image("GlassSmallIcon")

        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
        .frame(height: 126)
        .background(AppColor.brandBlack)
        .cornerRadius(10)
        
         .overlay(alignment: .topTrailing) {
             ZStack {
                 Circle()
                     .fill(AppColor.background)
                     .frame(width: 36, height: 36)
                 
                 Circle()
                     .fill(AppColor.yellow)
                     .frame(width: 32, height: 32)
                 
                 Image(systemName: "questionmark.circle")
                     .resizable()
                     .scaledToFit()
                     .frame(width: 20, height: 20)
             }
             .offset(x: 3, y: -3)
         }
    }
}

private extension MainScreenView {
    
    var labelWithIconSection: some View {
        HStack {
            Text("Будь в курсе")
                .font(AppFont.MainTab.subLargeTitle)
                .foregroundColor(AppColor.primaryText)
            
            Spacer()
            
            Image("ArrowIcon")
        }
        .padding(.bottom, 16)
    }
}

private extension MainScreenView {
    
    var horizontalCardsSection: some View {
        
        let cardsDescriptionArray: [(String, String)] = [
            ("Новые сорта крафта уже в наличии в магазинах", "20.01.2022"),
            ("Нам 10 лет повышаем скидку до 10% на всё!", "21.01.2022")
        ]
        
        return ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(0..<4, id: \.self) { index in
                    
                    let item = index.isMultiple(of: 2)
                        ? cardsDescriptionArray[0]
                        : cardsDescriptionArray[1]
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(item.0)
                            .font(AppFont.MainTab.cardTitle)
                            .foregroundColor(AppColor.primaryText)
                        Text(item.1)
                            .font(AppFont.MainTab.cardSubTitle)
                            .foregroundColor(AppColor.secondaryText)

                    }
                    .padding()
                    .frame(width: 138, height: 132)
                    .background(AppColor.yellow)
                    .cornerRadius(10)
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
