//
//  HabitListFeatureTests.swift
//  PureHabitsTests
//
//  Created by Rodrigo Cerqueira Reis on 16/07/26.
//

import ComposableArchitecture
import Foundation
import Testing

@testable import PureHabits

@Suite("HabitListFeature Tests")
@MainActor
struct HabitListFeatureTests {

    @Test("Toggling a habit toggles its completion state safely")
    func testToggleHabit() async {
        let habitId = UUID()

        let mockHabit = Habit(
            id: habitId,
            title: "Drink 2L of Water",
            isCompleted: false
        )

        let state = HabitListFeature.State()

        state.$habits.withLock { habits in
            habits = [mockHabit]
        }

        let store = TestStore(initialState: state) {
            HabitListFeature()
        }

        await store.send(.habitToggled(id: habitId)) { state in
            state.$habits.withLock { habits in
                habits[id: habitId]?.isCompleted = true
            }
        }
    }

    @Test(
        "Receiving a delegated habit saves it and dismisses the sheet"
    )
    func testAddHabit_Delegation() async {
        var initialState = HabitListFeature.State()
        initialState.addHabit = AddHabitFeature.State()

        let store = TestStore(initialState: initialState) {
            HabitListFeature()
        }

        let newHabit = Habit(
            id: UUID(),
            title: "HIIT Workout",
            isCompleted: false
        )

        await store.send(
            .addHabit(
                .presented(
                    .delegate(.didSaveHabit(newHabit))
                )
            )
        ) { state in
            _ = state.$habits.withLock { habits in
                habits.append(newHabit)
            }


            state.addHabit = nil
        }
    }
}
