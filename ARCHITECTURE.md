# 🏗️ PureHabits - Architectural Blueprint

This document outlines the architectural design, data flow, and technical decisions behind **PureHabits**. 

---

## 🧭 Design Philosophy

PureHabits is built strictly upon **The Composable Architecture (TCA)** by Point-Free. The core objectives of this architecture are:
1. **Unidirectional Data Flow:** Predictable and traceable state transitions.
2. **Testability:** Complete isolation of side effects for exhaustive unit testing.
3. **Thread Safety:** Conforming to modern Swift 6 strict concurrency requirements.

---

## 🔄 Unidirectional Data Flow

Every feature in the app follows a strict feedback loop:

```text
    ┌────────────────────────────────────────┐
    │                                        │
    ▼                                        │
┌───────┐         ┌─────────┐          ┌──────────┐
│ View  │ ──────> │ Action  │ ───────> │ Reducer  │
└───────┘         └─────────┘          └──────────┘
    ▲                                        │
    │                                        ▼
    │          ┌──────────────┐         ┌──────────┐
    └───────── │ State Update │ <────── │  Effect  │ (Optional)
               └──────────────┘         └──────────┘
               

User Interaction: The user interacts with the View (e.g., toggles a habit).

Action Dispatch: The View sends an explicit, exhaustive Action (e.g., .habitToggled(id: id)) to the Store.

State Mutation: The pure Reducer processes the action, mutates the State in-place, and returns any side Effects.

UI Render: The @ObservableState macro ensures the View observes only the exact pieces of state that changed and re-renders efficiently.

🗂️ Project Structure & Component Mapping
The codebase is organized into highly decoupled logical domains:

Plaintext
PureHabits/
├── Domain/
│   └── Models/          # Plain, dependency-free structs (e.g., Habit)
├── Features/
│   ├── Root/            # App entry point (AppFeature.swift & AppView.swift)
│   ├── HabitList/       # List management, toggle logic, and delegation
│   └── AddHabit/        # Modal sheet to draft and input new habits
└── Previews/            # Unified design system preview assets & mocks
💾 Reactive Persistence & Thread Safety
To satisfy modern Swift 6 Concurrency and data isolation constraints:

State Synchronization: We use TCA's @Shared(.fileStorage(...)) macro to bind our habit array to a local habits.json file. The framework handles seamless, automated disk writes.

Actor Isolation: The Habit model implements custom nonisolated encoding/decoding and conforms to Sendable to bypass implicit @MainActor containment issues forced by compiler-macro expansions.

Atomic Mutations: Since shared state requires exclusive access, mutations (like toggling a habit or appending a new one) are wrapped inside explicit atomic locks using the $shared.withLock projected value:

Swift
_ = state.$habits.withLock { habits in
    habits[id: id]?.isCompleted.toggle()
}
🧪 Testing Strategy
Since reducers are pure functions and all side effects are isolated, we can test user journeys exhaustively using TestStore:

State Verification: Every state mutation must be explicitly asserted in the test.

Effect Tracking: The TestStore enforces that all spawned effects (e.g., async tasks, timers, or saves) are fully completed or canceled before the test finishes.
