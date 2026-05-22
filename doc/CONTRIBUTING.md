# Contributing to Hyve

Welcome to the **Hyve** contributor guidelines! This document is designed to help you set up your development environment, understand the repository architecture, and write code that conforms to our project standards.

---

## 1. Getting Started (The Basics)

Before you begin contributing, ensure you have the appropriate tools and setup on your local machine:

### Setup and Environment
* **Flutter SDK**: Hyve requires Flutter SDK matching the SDK environment `^3.11.3` (Dart SDK `>=3.11.3 <4.0.0`).
* **IDEs**: We recommend using VS Code (with Dart/Flutter extensions) or Android Studio.
* **Format & Linting**: Always format your code using `flutter format .` and check for issues using `flutter analyze` before committing.

### Running the App
1. Clone the repository and navigate to the project directory:
   ```bash
   cd hyve
   ```
2. Retrieve the dependencies:
   ```bash
   flutter pub get
   ```
3. Start a simulator/emulator or connect a physical device, and run the app in debug mode:
   ```bash
   flutter run
   ```

---

## 2. Directory Structure (`lib`)

To keep the codebase modular, clean, and highly scalable, we follow a strict directory structure inside `lib/`:

```text
lib/
├── core/
│   ├── constants/           # Global constants
│   ├── services/            # App-wide services (e.g., API clients, local storage)
│   ├── settings/            # Global settings or configuration classes
│   ├── theme/               # Application themes and custom semantic colors
│   └── widgets/             # Core widgets used across the entire app (e.g., custom buttons, input fields)
│
├── features/
│   ├── auth/
│   ├── home/
│   ├── profile/
│   └── onboarding/
│
├── shared/
│   ├── models/              # Global/Core models used across features
│   └── utils/               # App-wide utility classes/helpers
│
├── main.dart                # Application entry point (initializes services, runs runApp)
└── app.dart                 # MaterialApp wrapper (sets up routing, theme, and global BlocProviders)
```

### 📁 Core Directory (`lib/core/`)
`core/` holds the absolute infrastructure foundation of the application. Code in `core/` should be completely independent of specific feature requirements and must never depend on code from `features/` or `shared/`.
* **constants/**: Hardcoded strings, dimensions, assets paths, and configuration keys.
* **services/**: Singleton or long-lived services (e.g., `LocalStorageService`, `HttpService`).
* **settings/**: Environment config files or app configuration options.
* **theme/**: Contains our typography, light & dark theme definitions, and theme extensions (`app_theme.dart`).
* **widgets/**: Highly reusable, generic visual elements used across multiple modules.

### 📁 Shared Directory (`lib/shared/`)
`shared/` contains entities that are shared across features but are not fundamental infrastructure code:
* **models/**: Global/Core models utilized system-wide (e.g., a generic `UserResponse` or `ApiResponse`).
* **utils/**: App-wide utility classes, pure helper functions, and extensions (e.g., date formatting, validation helpers).

### 📁 Features Directory (`lib/features/`)
Each directory inside `features/` represents a self-contained module or flow of the app (e.g., `auth`, `onboarding`, `profile`).

#### Detailed Feature Folder Layout
To maintain absolute separation of concerns, each feature should strictly adhere to the following internal layout:

```text
features/onboarding/
├── bloc/                    # State Management (BLoC, Events, and States)
│   ├── onboarding_bloc.dart
│   ├── onboarding_event.dart
│   └── onboarding_state.dart
├── data/                    # (Optional) Local data layer
│   ├── models/              # Feature-specific models
│   └── services/            # Feature-specific API clients / data sources
├── view/                    # Layouts and Pages (entry points)
│   └── onboarding_page.dart
└── widgets/                 # Feature-specific UI components
    ├── onboarding_card.dart
    └── next_button.dart
```

* **`bloc/`**: Contains the BLoC file, states, and events. All business logic, asynchronous actions, and state transitions belong here.
* **`data/`**: Feature-specific models and data sources/services. This allows the module to be completely portable.
* **`view/`**: Contains the high-level screens and page views. These views use `BlocProvider` to supply the BLoC to their children, configure layouts, and handle navigation triggers inside a `BlocListener` or `BlocConsumer`.
* **`widgets/`**: Contains sub-widgets specific to this feature. Keeping feature-specific widgets nested inside the feature ensures they don't clutter `core/widgets/`.

---

## 3. Themes and Colors (Context-Driven)

To ensure that both **Light Mode** and **Dark Mode** work automatically throughout the application, **you must retrieve colors and typography from the build context**.

### The Rules
* ❌ **Do NOT** reference raw colors directly or hardcode theme palettes (e.g., `AppTheme.light.colorScheme.primary` or `Colors.white`).
*  **Do** access theme settings dynamically via `Theme.of(context)` or our semantic color extension helper `context.appColors`.

### Standard Color Scheme Access
Use the Material design `ColorScheme` from context for main backgrounds, surface colors, and typography colors:
```dart
final colorScheme = Theme.of(context).colorScheme;

Scaffold(
  backgroundColor: colorScheme.surface,
  body: Text(
    'Hello World',
    style: TextStyle(color: colorScheme.onSurface),
  ),
)
```

### Semantic Colors Access
For specific stateful/semantic colors (such as `danger`, `warning`, `success`, `info`, `primary`, and `secondary`), use the `context.appColors` context extension (defined in `lib/core/theme/app_theme.dart`):
```dart
// Retrieve adaptive semantic colors directly from context
final semanticColors = context.appColors;

Container(
  color: semanticColors.success, // Automatically changes based on Light/Dark brightness
  child: Text(
    'Action Completed Successfully',
    style: TextStyle(color: semanticColors.primary),
  ),
)
```

---

## 4. State Management (BLoC)

We use the [BLoC (Business Logic Component)](https://pub.dev/packages/flutter_bloc) pattern via the `flutter_bloc` package to separate presentation from business logic.

### Structure of a Bloc
Inside your feature's `bloc` directory, create three main files using Dart's `part` and `part of` directive to manage dependencies cleanly:
1. `<feature>_bloc.dart` — Contains the Business Logic Component class, registers handlers, and emits new states.
2. `<feature>_event.dart` — Defines user interactions and system triggers (subclassing a sealed event).
3. `<feature>_state.dart` — Represents the UI states (subclassing a sealed state).

#### Example Setup
`onboarding_event.dart`:
```dart
part of 'onboarding_bloc.dart';

sealed class OnboardingEvent {}

class OnboardingNextTapped extends OnboardingEvent {}
class OnboardingPageChanged extends OnboardingEvent {
  final int index;
  OnboardingPageChanged(this.index);
}
```

`onboarding_state.dart`:
```dart
part of 'onboarding_bloc.dart';

sealed class OnboardingState {}

class OnboardingInProgress extends OnboardingState {
  final int currentIndex;
  final int totalPages;
  OnboardingInProgress({required this.currentIndex, required this.totalPages});
}
class OnboardingComplete extends OnboardingState {}
```

`onboarding_bloc.dart`:
```dart
import 'package:flutter_bloc/flutter_bloc.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc({required int totalPages})
      : super(OnboardingInProgress(currentIndex: 0, totalPages: totalPages)) {
    on<OnboardingNextTapped>(_onNextTapped);
    on<OnboardingPageChanged>(_onPageChanged);
  }

  void _onNextTapped(OnboardingNextTapped event, Emitter<OnboardingState> emit) {
    // Business logic goes here...
  }

  void _onPageChanged(OnboardingPageChanged event, Emitter<OnboardingState> emit) {
    // State transitions go here...
  }
}
```

### Implementing in the View
Provide your BLoC at the top level of the screen page/view container, and consume it in sub-widgets using `BlocBuilder`, `BlocListener`, or `BlocConsumer`.

```dart
// 1. Provide the Bloc
class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingBloc(totalPages: 3),
      child: const _OnBoardingView(),
    );
  }
}

// 2. Consume the Bloc
class _OnBoardingView extends StatelessWidget {
  const _OnBoardingView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingBloc, OnboardingState>(
      listener: (context, state) {
        if (state is OnboardingComplete) {
          // Perform side-effects like routing here
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => HomePage()),
          );
        }
      },
      builder: (context, state) {
        if (state is! OnboardingInProgress) return const SizedBox.shrink();

        return Scaffold(
          body: Center(
            child: ElevatedButton(
              onTap: () {
                // 3. Dispatch events to trigger state changes
                context.read<OnboardingBloc>().add(OnboardingNextTapped());
              },
              child: Text(state.currentIndex == 2 ? 'Get Started' : 'Next'),
            ),
          ),
        );
      },
    );
  }
}
```

Thank you for contributing to Hyve! If you have any questions, feel free to open a discussion or ask the project maintainers.
