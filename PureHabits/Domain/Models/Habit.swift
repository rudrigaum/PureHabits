//
//  Habit.swift
//  PureHabits
//
//  Created by Rodrigo Cerqueira Reis on 11/05/26.
//

import Foundation

public struct Habit: Equatable, Identifiable, Sendable {
    public let id: UUID
    public var title: String
    public var isCompleted: Bool

    public init(id: UUID, title: String, isCompleted: Bool = false) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
}

// MARK: - Mocks for Previews & Tests
extension Habit {
    static let mockUncompleted = Self(id: UUID(), title: "Read 10 pages", isCompleted: false)
    static let mockCompleted = Self(id: UUID(), title: "Morning Workout", isCompleted: true)
}
