//
//  MainTabFeature.swift
//  Live Beer App
//
//  Created by Константин Клинов on 25/02/26.
//

import Foundation
import SwiftUI

enum AppTab: Int, CaseIterable, Equatable {
    case main = 0
    case discounts
    case markets
    case profile
    
    var title: String {
        switch self {
        case .main: return "Главная"
        case .discounts: return "Акции"
        case .markets: return "Магазины"
        case .profile: return "Профиль"
        }
    }
    
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
struct MainTabState: Equatable {
    var selectedTab: AppTab = .main
    var username: String = ""
    var isShowingBarcode: Bool = false
    var barcodeValue: String? = nil
}

// MARK: - MainTab Actions
enum MainTabAction: Equatable {
    case tabSelected(AppTab)
    case showBarcodeTapped
}

// MARK: - MainTab Reducer
func mainTabReducer(
    state: inout MainTabState,
    action: MainTabAction
) -> Effect<MainTabAction> {
    switch action {
    case .tabSelected(let tab):
        state.selectedTab = tab
        return .none
        
    case .showBarcodeTapped:
        
        let randomCode = String(Int.random(in: 100000000...999999999))
        
        state.barcodeValue = randomCode
        state.isShowingBarcode = true
        
        return .none
    }
}
