//
//  LiveBeerApp.swift
//  Live Beer App
//
//  Created by Константин Клинов on 25/02/26.
//

import Foundation
import SwiftUI

@main
struct LiveBeerApp: App {
    @StateObject private var store = AppStore(
        initialState: AppCoordinatorState(),
        reduce: appCoordinatorReducer
    )

    var body: some Scene {
        WindowGroup {
            AppCoordinatorView()
        }
    }
}
