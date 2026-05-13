//
//  AddHabitFeature.swift
//  PureHabits
//
//  Created by Rodrigo Cerqueira Reis on 12/05/26.
//

import Foundation
import ComposableArchitecture

@Reducer
public struct AddHabitFeature {
    @ObservableState
    public struct State: Equatable, Sendable {
        public var title: String

        public init(title: String = "") {
            self.title = title
        }
    }

    public enum Action: Equatable, Sendable, BindableAction {
        case binding(BindingAction<State>)
        case cancelButtonTapped
        case saveButtonTapped
        case delegate(Delegate)

        public enum Delegate: Equatable, Sendable {
            case didSaveHabit(Habit)
        }
    }

    @Dependency(\.dismiss) var dismiss
    @Dependency(\.uuid) var uuid

    public init() {}

    public var body: some Reducer<State, Action> {
        BindingReducer()

        Reduce { (state: inout State, action: Action) -> Effect<Action> in
            switch action {
            case .binding:
                return .none

            case .cancelButtonTapped:
                return .run { _ in await self.dismiss() }

            case .saveButtonTapped:
                guard !state.title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                    return .none
                }

                let newHabit = Habit(id: self.uuid(), title: state.title)

                return .run { send in
                    await send(.delegate(.didSaveHabit(newHabit)))
                    await self.dismiss()
                }

            case .delegate:
                return .none
            }
        }
    }
}
