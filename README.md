# 星驰汽车 (StarMotor)

A comprehensive Flutter starter project for **Starmotor** — a Chinese automotive lifestyle mobile app inspired by platforms like Li Auto, featuring 7 core feature tabs.

## Features

| Tab | Description |
|-----|-------------|
| 🏘️ 社区 (Social) | User-generated posts with image grids, likes, comments, and hashtags |
| 📰 资讯 (Publication) | Tabbed news & events feed from the brand |
| 🚗 购车 (Purchase) | Car catalog → detail (specs/colors/variants) → step-by-step configurator → order |
| 🔭 探索 (Explore) | Brand story, milestones timeline, events list, showroom locator |
| 🛍️ 商城 (Mall) | Category strip + product grid with live cart badge counter |
| 🔧 服务 (Service) | Service card grid, 3-step booking stepper, FAQ expansion tiles, warranty sheet |
| 👤 我的 (Profile) | Sliver app bar, follow stats, order history, settings |

## Tech Stack

- **Flutter** (cross-platform, Material 3)
- **Riverpod** (`StateNotifier` / `AsyncNotifier`) — state management
- **HTTP** — API client with auto Bearer-token injection
- **shared_preferences** — local token & user data storage
- **cached_network_image** — efficient image loading
- **intl** — internationalisation utilities

## Project Structure

```
lib/
├── main.dart                    # App entry point, auth-driven navigation
├── config/
│   ├── app_config.dart          # Feature flags & pagination settings
│   ├── api_config.dart          # All API endpoint constants
│   └── theme_config.dart        # Material 3 light + dark themes
├── models/                      # Data models with fromJson/toJson
│   ├── user_model.dart
│   ├── post_model.dart
│   ├── car_model.dart
│   ├── product_model.dart
│   ├── order_model.dart
│   └── service_model.dart
├── services/
│   ├── api_service.dart         # Singleton HTTP client
│   ├── auth_service.dart        # Auth flows (mock → real API hookpoints)
│   ├── storage_service.dart     # SharedPreferences wrapper
│   └── notification_service.dart# FCM skeleton
├── providers/                   # Riverpod providers
│   ├── auth_provider.dart
│   ├── social_provider.dart
│   ├── purchase_provider.dart
│   ├── mall_provider.dart
│   └── user_provider.dart
├── screens/                     # All 7 tabs + auth
│   ├── auth/
│   ├── social/
│   ├── publication/
│   ├── purchase/
│   ├── explore/
│   ├── mall/
│   ├── service/
│   ├── profile/
│   └── home/
├── widgets/
│   ├── post_card.dart
│   ├── car_card.dart
│   ├── product_card.dart
│   └── custom_app_bar.dart
└── utils/
    ├── constants.dart           # Routes, error/success strings, provinces
    └── validators.dart          # Phone (CN), email, password, OTP, nickname
```

## Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) ≥ 3.0.0
- Dart ≥ 3.0.0

### Setup

```bash
# Clone the repository
git clone https://github.com/ngcaryn/starmotor.git
cd starmotor

# Install dependencies
flutter pub get

# Run on a connected device or emulator
flutter run
```

### Running Tests

```bash
flutter test
```

## Architecture Notes

- **Auth-driven navigation**: Splash → Login or `MainNavigation` based on `authNotifierProvider` state
- **Mock data**: All providers ship with realistic mock data; swap `await Future.delayed(...)` stubs for real `ApiService` calls
- **Cart badge**: Live counter on the Mall tab uses `cartItemCountProvider`
- **Theme**: Fully supports light and dark mode via `ThemeMode.system`
| Layer | Technology |
|-------|-----------|
| Framework | React Native (Expo ~51) |
| Language | TypeScript |
| Navigation | React Navigation 6 |
| State management | Redux Toolkit |
| API client | Axios |
| Local storage | AsyncStorage |
| UI components | React Native Paper + Custom |
