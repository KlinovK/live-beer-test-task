//
//  LiveBeerApp.swift
//  Live Beer App
//
//  Created by Константин Клинов on 25/02/26.
//

import SwiftUI

@main
struct LiveBeerApp: App {
    
    // Main app store.
    // Created once at app launch and holds global state.
    @StateObject private var store = AppStore(
        initialState: AppCoordinatorState(),   // Initial app state
        reduce: appCoordinatorReducer          // Root reducer
    )

    var body: some Scene {
        WindowGroup {
            
            // Root view of the app
            AppCoordinatorView()
            
            // Pass store here if needed:
            // AppCoordinatorView(store: store)
        }
    }
}
