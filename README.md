# PureHabits 🎯

A modular iOS Habit Tracker built with **SwiftUI** and **The Composable Architecture (TCA)**. 

The goal of this project is to explore functional architecture, unidirectional data flow, modern Swift 6 concurrency, and robust testing strategies.

## 🛠 Tech Stack
- **Platform:** iOS 18.0+
- **UI:** SwiftUI
- **Architecture:** The Composable Architecture (TCA) 1.15+
- **Testing:** Swift Testing & `TestStore`
- **Concurrency:** Swift 6 Concurrency (`async/await`, `Sendable` conformity)
- **Persistence:** Thread-safe JSON file storage via `@Shared`

## 🏗 Architecture Overview
This app is built using modern **TCA** principles, meaning each feature is strictly modeled with:
- **State:** Immutable representation of the UI using `@ObservableState`.
- **Action:** Exhaustive list of user and system events.
- **Reducer:** Pure functions that mutate the State and return side `Effects`.

### Data Persistence
We leverage TCA's `@Shared(.fileStorage(...))` macro to automatically persist the habit list to the disk as a JSON file. All shared state mutations are wrapped in `$shared.withLock` blocks to guarantee data isolation and thread safety, fully conforming to strict concurrency requirements.

Dependencies are injected via TCA's `@Dependency` property wrapper, ensuring the "impure world" (Persistence, Date, UUID) is completely controllable during unit tests.
