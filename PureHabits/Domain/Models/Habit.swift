//
//  Habit.swift
//  PureHabits
//
//  Created by Rodrigo Cerqueira Reis on 11/05/26.
//

import Foundation

public struct Habit: Equatable, Sendable {
    public let uniqueID: UUID
    public var title: String
    public var isCompleted: Bool

    public init(id: UUID, title: String, isCompleted: Bool = false) {
        self.uniqueID = id
        self.title = title
        self.isCompleted = isCompleted
    }
}

// MARK: - Identifiable Conformance
extension Habit: Identifiable {
    nonisolated public var id: UUID { self.uniqueID }
}

// MARK: - Codable Conformance
extension Habit: Codable {
    enum CodingKeys: String, CodingKey {
        case uniqueID = "id"
        case title
        case isCompleted
    }

    nonisolated public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.uniqueID = try container.decode(UUID.self, forKey: .uniqueID)
        self.title = try container.decode(String.self, forKey: .title)
        self.isCompleted = try container.decode(Bool.self, forKey: .isCompleted)
    }

    nonisolated public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.uniqueID, forKey: .uniqueID)
        try container.encode(self.title, forKey: .title)
        try container.encode(self.isCompleted, forKey: .isCompleted)
    }
}

// MARK: - Mocks for Previews & Tests
extension Habit {
    public static let mockUncompleted = Self(id: UUID(), title: "Read 10 pages", isCompleted: false)
    public static let mockCompleted = Self(id: UUID(), title: "Morning Workout", isCompleted: true)
}
