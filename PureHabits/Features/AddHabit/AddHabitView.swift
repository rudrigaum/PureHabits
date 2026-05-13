//
//  AddHabitView.swift
//  PureHabits
//
//  Created by Rodrigo Cerqueira Reis on 13/05/26.
//

import Foundation
import ComposableArchitecture
import SwiftUI

public struct AddHabitView: View {
    @Bindable var store: StoreOf<AddHabitFeature>

    public init(store: StoreOf<AddHabitFeature>) {
        self.store = store
    }

    public var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Habit Name (e.g. Read 10 pages)", text: $store.title)
                } footer: {
                    Text("Keep it simple and actionable.")
                }
            }
            .navigationTitle("New Habit")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        store.send(.cancelButtonTapped)
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        store.send(.saveButtonTapped)
                    }
                    .disabled(store.title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    AddHabitView(
        store: Store(
            initialState: AddHabitFeature.State(),
            reducer: { AddHabitFeature() }
        )
    )
}
