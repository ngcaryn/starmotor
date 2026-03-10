# Starmotor (星驰汽车)

A comprehensive **Chinese automotive lifestyle mobile app** built with Flutter, inspired by leading Chinese EV brands like Li Auto. Starmotor delivers a full-featured experience across community, content, vehicle purchase, brand exploration, accessories shopping, and service booking.

---

## 👀 View the App

### Option 1 — Interactive HTML Preview (No setup required)

Open [`preview/index.html`](preview/index.html) directly in any modern web browser:

```bash
# macOS
open preview/index.html

# Windows
start preview/index.html

# Linux
xdg-open preview/index.html
```

All **8 screens** are interactive — use the navigation buttons or the bottom tab bar inside the phone frame to switch between them.

> **Preview screenshot:**
>
> ![Starmotor App Preview](https://github.com/user-attachments/assets/d08bd989-6387-4bf5-8acc-62ae2dbfa6cb)

---

### Option 2 — Run the Real Flutter App

See the [Getting Started](#-getting-started) section below for full instructions.

```bash
flutter pub get
flutter run          # on a connected device or emulator
```

---

## 📱 App Features (7 Main Tabs)

| Tab | Icon | Description |
|-----|------|-------------|
| **社区** (Social Space) | 👥 | User feed, posts, discussions, community engagement |
| **发布** (Official Publication) | 📰 | Brand news, announcements, official updates |
| **购车** (Purchase) | 🚗 | Browse cars, configure, order, financing |
| **探索** (Explore Brand) | 🌟 | Brand story, events, showrooms, gallery |
| **商城** (Mall) | 🛍️ | Accessories, merchandise, parts shop |
| **服务** (Service) | 🔧 | Maintenance booking, support, warranty |
| **我的** (Profile) | 👤 | User profile, orders, settings |

---

## 🛠️ Tech Stack

- **Framework:** Flutter (iOS + Android cross-platform)
- **State Management:** Riverpod (`flutter_riverpod`)
- **HTTP Client:** `http` package
- **Local Storage:** `shared_preferences`
- **Navigation:** Flutter Navigator 2.0 (extensible to `go_router`)
- **UI:** Material Design 3

---

## 📁 Project Structure

```
starmotor/
├── lib/
│   ├── main.dart                    # App entry point, MaterialApp setup
│   ├── config/
│   │   ├── app_config.dart          # App-wide config & feature flags
│   │   ├── api_config.dart          # API endpoints
│   │   └── theme_config.dart        # Theme, colors, text styles
│   ├── models/
│   │   ├── user_model.dart          # User profile model
│   │   ├── post_model.dart          # Social post & comment models
│   │   ├── car_model.dart           # Car, specs, variant, color models
│   │   ├── product_model.dart       # Product, category, cart models
│   │   ├── order_model.dart         # Order, shipping address models
│   │   └── service_model.dart       # Service, booking, center models
│   ├── services/
│   │   ├── api_service.dart         # HTTP client with auth headers
│   │   ├── auth_service.dart        # Login, signup, logout logic
│   │   ├── storage_service.dart     # SharedPreferences wrapper
│   │   └── notification_service.dart # Push notification setup
│   ├── providers/
│   │   ├── auth_provider.dart       # Auth state management
│   │   ├── social_provider.dart     # Social feed state
│   │   ├── purchase_provider.dart   # Car list & configurator state
│   │   ├── mall_provider.dart       # Products, categories, cart state
│   │   └── user_provider.dart       # User profile & orders state
│   ├── screens/
│   │   ├── auth/
│   │   │   ├── login_screen.dart    # Phone/email login
│   │   │   └── signup_screen.dart   # Registration
│   │   ├── social/
│   │   │   ├── social_feed_screen.dart   # Community feed
│   │   │   ├── post_detail_screen.dart   # Post detail & comments
│   │   │   └── create_post_screen.dart   # New post creation
│   │   ├── publication/
│   │   │   └── publication_feed_screen.dart  # Official news/events
│   │   ├── purchase/
│   │   │   ├── car_list_screen.dart       # Car catalog
│   │   │   ├── car_detail_screen.dart     # Car specs & variants
│   │   │   └── configurator_screen.dart   # Car configurator
│   │   ├── explore/
│   │   │   └── brand_story_screen.dart    # Brand story/events/showrooms
│   │   ├── mall/
│   │   │   ├── mall_home_screen.dart      # Mall homepage
│   │   │   └── product_detail_screen.dart # Product detail & purchase
│   │   ├── service/
│   │   │   └── service_home_screen.dart   # Service hub & booking
│   │   ├── profile/
│   │   │   ├── profile_screen.dart        # User profile
│   │   │   └── settings_screen.dart       # App settings
│   │   └── home/
│   │       └── main_navigation.dart       # Bottom nav with 7 tabs
│   ├── widgets/
│   │   ├── post_card.dart           # Social post card
│   │   ├── car_card.dart            # Car listing card
│   │   ├── product_card.dart        # Product card with add-to-cart
│   │   ├── custom_app_bar.dart      # Reusable app bar
│   │   └── bottom_nav_bar.dart      # (included in main_navigation)
│   └── utils/
│       ├── constants.dart           # App-wide constants & strings
│       └── validators.dart          # Form validation functions
├── assets/
│   ├── images/                      # App images
│   ├── icons/                       # Custom icons
│   └── fonts/                       # Custom fonts (PingFang)
├── test/
│   └── widget_test.dart             # Basic widget smoke test
├── pubspec.yaml
├── .gitignore
└── README.md
```

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK `>=3.0.0`
- Dart SDK `>=3.0.0`
- Android Studio / VS Code with Flutter extension
- Xcode (for iOS builds, macOS only)

### Installation

```bash
# Clone the repository
git clone https://github.com/ngcaryn/starmotor.git
cd starmotor

# Install dependencies
flutter pub get

# Run on device/emulator
flutter run
```

### Build

```bash
# Android APK
flutter build apk --release

# iOS (requires Mac + Xcode)
flutter build ios --release

# Android App Bundle (recommended for Play Store)
flutter build appbundle --release
```

---

## 🗺️ Development Roadmap

### Phase 1 (Current) — Foundation ✅
- [x] Project structure & architecture
- [x] Authentication (phone OTP + email)
- [x] Bottom navigation with 7 tabs
- [x] Social Space: feed, post detail, create post
- [x] Official Publication: news feed, detail view
- [x] Purchase: car catalog, detail, configurator
- [x] Explore Brand: story, events, showrooms, gallery
- [x] Mall: product catalog, cart, product detail
- [x] Service: booking workflow, FAQ, warranty
- [x] Profile: user settings, order history
- [x] Theme system & design tokens
- [x] Data models with JSON serialization
- [x] Riverpod state management

### Phase 2 — Backend Integration
- [ ] Connect to real REST API
- [ ] Real authentication (SMS OTP via SMS gateway)
- [ ] Push notifications (Firebase Cloud Messaging)
- [ ] Map integration (Amap/Gaode Maps)
- [ ] Payment integration (Alipay / WeChat Pay)
- [ ] Image upload to CDN

### Phase 3 — Car Control (Phase 2 per spec)
- [ ] Vehicle status dashboard
- [ ] Remote lock/unlock, AC control
- [ ] Charging status & station finder
- [ ] Trip analytics

---

## 🎨 Design System

### Brand Colors
| Token | Color | Usage |
|-------|-------|-------|
| `AppColors.primary` | `#1A1A2E` (Navy) | Primary brand, app bars |
| `AppColors.accent` | `#E94560` (Red) | Prices, CTAs, promotions |
| `AppColors.success` | `#4CAF50` | EV badges, confirmations |
| `AppColors.info` | `#2196F3` | Hybrid badges, links |

---

## 🔌 API Integration

All API endpoints are defined in `lib/config/api_config.dart`. The `ApiService` singleton handles:

- Automatic `Bearer` token injection from `StorageService`
- JSON encoding/decoding
- Error handling via `ApiException`
- Configurable timeouts

Replace the mock data in providers with actual `ApiService` calls when your backend is ready.

---

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage
```

---

## 📦 Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| `flutter_riverpod` | ^2.4.9 | State management |
| `http` | ^1.2.0 | HTTP client |
| `shared_preferences` | ^2.2.2 | Local storage |
| `cached_network_image` | ^3.3.1 | Image caching |
| `go_router` | ^13.2.0 | Declarative routing |
| `intl` | ^0.19.0 | Internationalization |
| `url_launcher` | ^6.2.4 | Open URLs |

---

## 📄 License

© 2024 Starmotor Technologies. All rights reserved.
