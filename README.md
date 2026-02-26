
# Live Beer App - iOS Application

A SwiftUI iOS application built with a **TCA-inspired** (The Composable Architecture) pattern, using **only native Swift/SwiftUI/Combine**, with no external dependencies.

---

## Architecture

### Layers

- **AppLayer** – Entry point and application setup (`@main`, App Store initialization), Core TCA implementation (`Store`, `Effect`, Reducers)
- **CoreLayer** – Custom Enums, Views, Exstensions
- **RouterLayer** – AppCoordinator, root state, actions, reducer, navigation logic
- **PresentationLayer** – Features and UI for all screens (Onboarding, Registration, MainTab)

### Patterns Used

- **TCA (The Composable Architecture)** – Custom implementation without PointFree's library
- **Coordinator / Router Pattern** – `AppCoordinator` handles all navigation between screens

---

## Project Structure

TCAApp/
├── AppLayer/
│   ├── TCAAppApp.swift          # @main entry point
│   └── Store.swift              # Core TCA: Store<State, Action> + Effect
│
├── RouterLayer/
│   ├── AppCoordinator.swift     # Root State, Actions, Reducer + navigation logic
│   └── AppCoordinatorView.swift # Root view switching screens by route
│
├── PresentationLayer/
│   ├── Onboarding/
│   │   ├── OnboardingFeature.swift   # State, Action, Reducer
│   │   └── OnboardingView.swift      # SwiftUI View
│   │
│   ├── Registration/
│   │   ├── RegistrationFeature.swift # State, Action, Reducer
│   │   └── RegistrationView.swift    # SwiftUI View
│   │
│   └── MainTab/
│       ├── MainTabFeature.swift      # State, Action, Reducer
│       └── MainTabView.swift         # TabView + placeholder screens

---

## Screens

1. **Onboarding Screen**
    - 3 buttons: Registration (enabled), Enter without registration (disabled), Enter (disabled)
    - Tapping **Registration** navigates to **Registration screen**

2. **Registration Screen**
    - Header + subtitle
    - Phone number field
    - Name field
    - Birth date field with expandable calendar picker
    - "I agree" checkbox
    - **Register button** (enabled only when all fields are valid + checkbox checked)
    - After register → navigates to **Main Tab screen**

3. **Main Tab Screen**
    - 4 tabs: Main, Discounts, Markets, Profile
    - Default tab: Main
    - All tabs have empty placeholder views

---

## TCA Core Concepts

```swift
// Effect<Action> — wraps async/side effects
Effect<Action>.none
Effect<Action>.send(.someAction)
Effect<Action>.run { dispatch in ... }
effect.map { action in transform(action) }

// Store<State, Action> — observable state container  
@MainActor final class Store<State, Action>: ObservableObject {
    func send(_ action: Action)
}

// Reducer — pure function
func featureReducer(state: inout State, action: Action) -> Effect<Action>


⸻

Requirements
	•	iOS 16+
	•	Xcode 15+
	•	Swift 5.9+
	•	No external dependencies

⸻

Notes
	•	Entire app is built with SwiftUI and Combine
	•	Uses a custom TCA-inspired architecture without external frameworks
	•	Navigation handled via AppCoordinator using Router / Coordinator pattern
