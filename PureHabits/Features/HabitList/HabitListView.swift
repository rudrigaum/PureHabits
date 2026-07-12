//
//  HabitListView.swift
//  PureHabits
//
//  Created by Rodrigo Cerqueira Reis on 12/05/26.
//

import Foundation
import ComposableArchitecture
import SwiftUI

public struct HabitListView: View {
    @Bindable var store: StoreOf<HabitListFeature>

    public init(store: StoreOf<HabitListFeature>) {
        self.store = store
    }

    public var body: some View {
        NavigationStack {
            List {
                ForEach(store.habits, id: \.id) { habit in
                    HStack {
                        Text(habit.title)
                            .strikethrough(habit.isCompleted, color: .secondary)
                            .foregroundColor(habit.isCompleted ? .secondary : .primary)

                        Spacer()

                        Image(systemName: habit.isCompleted ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(habit.isCompleted ? .green : .gray)
                            .imageScale(.large)
                            .onTapGesture {
                                store.send(.habitToggled(id: habit.id))
                            }
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("My Habits")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        store.send(.addHabitButtonTapped)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(item: $store.scope(state: \.addHabit, action: \.addHabit)) { addHabitStore in
                AddHabitView(store: addHabitStore)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    HabitListView(
        store: Store(
            initialState: HabitListFeature.State(),
            reducer: { HabitListFeature() }
        )
    )
}
