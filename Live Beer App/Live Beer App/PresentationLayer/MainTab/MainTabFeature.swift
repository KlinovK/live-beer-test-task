//
//  MainTabFeature.swift
//  Live Beer App
//
//  Created by Константин Клинов on 25/02/26.
//

import SwiftUI

// Available tabs in the main TabView
enum AppTab: Int, CaseIterable, Equatable {
    case main = 0
    case discounts
    case markets
    case profile
    
    // Tab title
    var title: String {
        switch self {
        case .main: return "Главная"
        case .discounts: return "Акции"
        case .markets: return "Магазины"
        case .profile: return "Профиль"
        }
    }
    
    // SF Symbol icon for tab
    var icon: String {
        switch self {
        case .main: return "house.fill"
        case .discounts: return "tag.fill"
        case .markets: return "storefront.fill"
        case .profile: return "person.fill"
        }
    }
}

// MARK: - MainTab State

// State for MainTab feature
struct MainTabState: Equatable {
    var selectedTab: AppTab = .main      // Currently selected tab
    var username: String = ""           // Current user name
    var isShowingBarcode: Bool = false  // Controls barcode visibility
    var barcodeValue: String? = nil     // Generated barcode value
}

// MARK: - MainTab Actions

// User and system actions for MainTab
enum MainTabAction: Equatable {
    case tabSelected(AppTab)
    case showBarcodeTapped
}

// MARK: - MainTab Reducer

// Handles state changes based on actions
func mainTabReducer(
    state: inout MainTabState,
    action: MainTabAction
) -> Effect<MainTabAction> {
    
    switch action {
        
    case .tabSelected(let tab):
        state.selectedTab = tab
        return .none
        
    case .showBarcodeTapped:
        
        // Generate random 9-digit barcode
        let randomCode = String(Int.random(in: 100000000...999999999))
        
        state.barcodeValue = randomCode
        state.isShowingBarcode = true
        
        return .none
    }
}
