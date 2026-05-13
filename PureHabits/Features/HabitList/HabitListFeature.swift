//
//  HabitListFeature.swift
//  PureHabits
//
//  Created by Rodrigo Cerqueira Reis on 11/05/26.
//

import Foundation
import ComposableArchitecture

@Reducer
public struct HabitListFeature {
    @ObservableState
    public struct State: Equatable, Sendable {
        public var habits: IdentifiedArrayOf<Habit>

        @Presents public var addHabit: AddHabitFeature.State?

        public init(habits: IdentifiedArrayOf<Habit> = []) {
            self.habits = habits
        }
    }

    public enum Action: Equatable, Sendable {
        case addHabitButtonTapped
        case habitToggled(id: Habit.ID)
        case addHabit(PresentationAction<AddHabitFeature.Action>)
    }

    public init() {}

    public var body: some Reducer<State, Action> {
        Reduce { (state: inout State, action: Action) -> Effect<Action> in
            switch action {
            case .addHabitButtonTapped:
                state.addHabit = AddHabitFeature.State()
                return .none

            case let .habitToggled(id: id):
                state.habits[id: id]?.isCompleted.toggle()
                return .none

            case let .addHabit(.presented(.delegate(.didSaveHabit(newHabit)))):
                state.habits.append(newHabit)
                return .none

            case .addHabit:
                return .none
            }
        }
        .ifLet(\.$addHabit, action: \.addHabit) {
            AddHabitFeature()
        }
    }
}
