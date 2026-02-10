//
//  AppFeature.swift
//  PureHabits
//
//  Created by Rodrigo Cerqueira Reis on 10/02/26.
//

import Foundation
import ComposableArchitecture
import SwiftUI

@Reducer
struct AppFeature {
    @ObservableState
    struct State: Equatable {
    }

    enum Action: Equatable {
        case onAppear
    }

    var body: some Reducer<State, Action> {
        Reduce { (state: inout State, action: Action) -> Effect<Action> in
            switch action {
            case .onAppear:
                return .none
            }
        }
    }
}

// MARK: - View
struct AppView: View {
    let store: StoreOf<AppFeature>

    var body: some View {
        VStack {
            Image(systemName: "checkmark.circle.fill")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Welcome to PureHabits")
        }
        .padding()
        .onAppear {
            store.send(.onAppear)
        }
    }
}

#Preview {
    AppView(
        store: Store(
            initialState: AppFeature.State(),
            reducer: { AppFeature() }
        )
    )
}
