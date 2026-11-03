# EcoBin

EcoBin is a Flutter-based mobile app for sustainable waste collection, eco-rewards, and green community engagement.

## Overview

This project brings together:

- user login and registration flows
- collector dashboards and live pickup tracking
- eco-points and rewards tracking
- notification center and alerts
- marketplace offers for eco-conscious users
- responsive, material-based UI design

## Tech Stack

- Flutter
- Dart
- Material Design
- `sizer`
- `shared_preferences`
- `flutter_svg`
- `google_fonts`

## Features

- Smart, responsive app interface
- Waste collection workflow support
- Eco-points tracking and reward visibility
- Live tracking and collection status display
- Notifications for user and collector engagement
- Demo-ready screens for app exploration and UI prototyping

## Project Structure

```text
ecobin/
├── android/                 # Android configuration
├── ios/                     # iOS configuration
├── lib/
│   ├── core/                # Shared exports and utilities
│   ├── presentation/        # Screens and UI modules
│   ├── routes/              # App routing
│   ├── theme/               # Theme configuration
│   ├── widgets/             # Shared widgets
│   ├── main.dart            # App entry point
│   └── ...
├── assets/
│   └── images/              # App images
├── analysis_options.yaml    # Linting rules
├── pubspec.yaml             # Flutter dependencies
├── README.md                # Project documentation
├── .gitignore               # Git ignore entries
└── LICENSE                  # License file (if present)
```

## Prerequisites

Before running the project, install:

- Flutter SDK 3.9.0 or newer
- Dart SDK
- Android Studio or VS Code with Flutter support
- Android SDK or Xcode for device builds

## Getting Started

Clone the repo and install dependencies:

```bash
git clone https://github.com/Cyrus-Hackman/ecobin.git
cd ecobin
flutter pub get
```

Run the app:

```bash
flutter run
```

## Useful Commands

```bash
# Run in debug mode
flutter run

# Run tests
flutter test

# Build Android release APK
flutter build apk --release

# Build iOS release
flutter build ios --release
```

## Notes

This project currently includes demo-style flows for login, tracking, dashboard, and marketplace interactions, making it a solid starting point for a sustainability-focused app.

## License

This project is provided for development and learning purposes.
