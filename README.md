# EcoBin

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.9+-02569B?style=for-the-badge&logo=flutter" alt="Flutter" />
  <img src="https://img.shields.io/badge/Dart-3.9+-0175C2?style=for-the-badge&logo=dart" alt="Dart" />
  <img src="https://img.shields.io/badge/Android-iOS-34A853?style=for-the-badge" alt="Android and iOS" />
</p>

<p align="center">
  <strong>EcoBin</strong> is a premium, sustainability-focused mobile app experience designed to make waste collection smarter, more rewarding, and more community-driven.
</p>

## Why EcoBin?

EcoBin helps users and collectors engage in greener daily habits through an elegant, app-store-inspired experience built around:

- eco-reward tracking and points
- smart collection flows and pickup visibility
- real-time status updates and notifications
- marketplace deals and green incentives
- a responsive, modern user interface

## App Experience

EcoBin blends utility and lifestyle into a clean mobile-first product that feels polished, intuitive, and built for real-world sustainability impact.

### Core features

- User authentication and onboarding
- Collector dashboard and waste pickup workflows
- Live tracking and status monitoring
- Eco-points rewards overview
- Notification center and reminders
- Marketplace offers and community-driven promotions
- Elegant Material Design UI with responsive layouts

## Tech Stack

- Flutter
- Dart
- Material Design
- `sizer` for responsive UI
- `shared_preferences` for local state
- `flutter_svg` for vector assets
- `google_fonts` for typography

## Project Structure

```text
ecobin/
├── android/                  # Android project files
├── ios/                      # iOS project files
├── lib/
│   ├── core/                 # Core exports and utilities
│   ├── presentation/         # Screens and UI modules
│   ├── routes/               # Routing configuration
│   ├── theme/                # App theming
│   ├── widgets/              # Reusable UI components
│   ├── main.dart             # App entry point
│   └── ...
├── assets/
│   └── images/               # Visual assets
├── analysis_options.yaml     # Lint config
├── pubspec.yaml              # Dependencies and metadata
├── README.md                 # Project documentation
├── .gitignore                # Git ignore rules
└── LICENSE                   # License file
```

## Getting Started

### Prerequisites

- Flutter SDK 3.9.0 or newer
- Dart SDK
- Android Studio or VS Code with Flutter support
- Android SDK / Xcode for device builds

### Install

```bash
git clone https://github.com/Cyrus-Hackman/ecobin.git
cd ecobin
flutter pub get
```

### Run the app

```bash
flutter run
```

## Useful Commands

```bash
# Run the app
flutter run

# Run tests
flutter test

# Build Android release
flutter build apk --release

# Build iOS release
flutter build ios --release
```

## Notes

This project currently includes demo-style flows for login, dashboard exploration, collection, and marketplace screens, making it a strong foundation for a sustainability-focused mobile product.

## License

This project is provided for development and learning purposes.
