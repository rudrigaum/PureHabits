//
//  HabitListFeature.swift
//  PureHabits
//
//  Created by Rodrigo Cerqueira Reis on 11/05/26.
//

import ComposableArchitecture
import Foundation

@Reducer
public struct HabitListFeature {
    @ObservableState
    public struct State: Equatable, Sendable {
        @Shared(.fileStorage(URL.documentsDirectory.appending(path: "habits.json")))
        public var habits: IdentifiedArrayOf<Habit> = []
        
        @Presents public var addHabit: AddHabitFeature.State?
        
        public init() {}
    }
    
    public enum Action: Equatable, Sendable {
        case addHabitButtonTapped
        case habitToggled(id: Habit.ID)
        case addHabit(PresentationAction<AddHabitFeature.Action>)
    }
    
    public init() {}
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .addHabitButtonTapped:
                state.addHabit = AddHabitFeature.State()
                return .none
                
            case let .habitToggled(id: id):
                _ = state.$habits.withLock { habits in
                    habits[id: id]?.isCompleted.toggle()
                }
                return .none
                
            case let .addHabit(.presented(.delegate(.didSaveHabit(newHabit)))):
                
                _ = state.$habits.withLock { habits in
                    habits.append(newHabit)
                }
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
