# PureHabits 🎯

A modular iOS Habit Tracker built with **SwiftUI** and **The Composable Architecture (TCA)**. 

The goal of this project is to explore functional architecture, unidirectional data flow, modern Swift concurrency, and robust testing strategies.

## 🛠 Tech Stack
- **Platform:** iOS 18.0+
- **UI:** SwiftUI
- **Architecture:** The Composable Architecture (TCA) 1.7+
- **Testing:** Swift Testing & `TestStore`
- **Concurrency:** Swift Concurrency (`async/await`)

## 🏗 Architecture Overview
This app is built using **TCA**, meaning each feature is strictly modeled with:
- **State:** Immutable representation of the UI.
- **Action:** Exhaustive list of user and system events.
- **Reducer:** Pure functions that mutate the State and return side `Effects`.

Dependencies are injected via TCA's `@Dependency` property wrapper, ensuring the "impure world" (Persistence, Date, UUID) is completely controllable during unit tests.