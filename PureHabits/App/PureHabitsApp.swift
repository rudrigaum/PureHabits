//
//  PureHabitsApp.swift
//  PureHabits
//
//  Created by Rodrigo Cerqueira Reis on 22/01/26.
//

import ComposableArchitecture
import SwiftUI

@main
struct PureHabitsApp: App {
    
    static let store = Store(initialState: AppFeature.State()) {
        AppFeature()
        ._printChanges()
    }

    var body: some Scene {
        WindowGroup {
            AppView(store: PureHabitsApp.store)
        }
    }
}
