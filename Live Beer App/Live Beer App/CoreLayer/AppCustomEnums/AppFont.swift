//
//  AppFont.swift
//  Live Beer App
//
//  Created by Константин Клинов on 25/02/26.
//

import SwiftUI

enum AppFont {
    
    enum Onboarding {
        static let title = Font.custom("SFUIDisplay-Bold", size: 30)
    }
    
    enum Registration {
        static let title = Font.custom("SFUIDisplay-Bold", size: 36)
        static let subTitle = Font.custom("SFUIDisplay-Regular", size: 14)
    }
    
    enum MainTab {
        static let title = Font.custom("SFUIDisplay-Bold", size: 20)
        static let largeTitle = Font.custom("SFUIDisplay-Bold", size: 32)
        static let subLargeTitle = Font.custom("SFUIDisplay-Semibold", size: 24)
        static let subTitle = Font.custom("SFUIDisplay-Semibold", size: 16)
        static let cardTitle = Font.custom("SFUIDisplay-Semibold", size: 14)
        static let cardSubTitle = Font.custom("SFUIDisplay-Regular", size: 12)
    }
    
    enum Button {
        static let primary = Font.system(size: 16, weight: .semibold)
    }
    
}
