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
        var habitList = HabitListFeature.State(
            habits: [
                .mockUncompleted,
                .mockCompleted
            ]
        )
    }

    enum Action {
        case habitList(HabitListFeature.Action)
    }

    var body: some Reducer<State, Action> {
        Scope(state: \.habitList, action: \.habitList) {
            HabitListFeature()
        }
    }
}

// MARK: - View
struct AppView: View {
    let store: StoreOf<AppFeature>

    var body: some View {
        HabitListView(
            store: store.scope(state: \.habitList, action: \.habitList)
        )
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
