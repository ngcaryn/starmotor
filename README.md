# ★ Starmotor

> A comprehensive Chinese automotive lifestyle mobile app built with Flutter.

---

## View the App

Open the self-contained interactive preview in your browser — **no Flutter or any other toolchain required**:

| Platform | Command |
|----------|---------|
| **macOS** | `open preview/index.html` |
| **Windows** | `start preview\index.html` |
| **Linux** | `xdg-open preview/index.html` |

Or simply double-click `preview/index.html` in your file manager / IDE.

The preview includes all **8 screens** rendered inside a phone-chrome frame with a working bottom navigation bar:

- **Login** — phone / OTP / WeChat sign-in
- **Social Space** — community feed with posts, likes, comments
- **Publication** — official news, events, and tech articles
- **Purchase** — car catalogue with specs, pricing, and configurator
- **Explore Brand** — company milestones, brand story, showroom locator
- **Mall** — merchandise shop with category filter and cart
- **Service** — appointment booking, service menu, and FAQ
- **Profile** — user stats, linked vehicles, order history, settings

---

## Flutter App

The full Flutter source lives in `lib/`. To run on a device or emulator:

```bash
flutter pub get
flutter run
```

For a release build:

```bash
flutter build apk          # Android
flutter build ios          # iOS (requires Xcode on macOS)
```

---

## Tech Stack

| Layer | Technology |
|-------|-----------|
| UI framework | Flutter (Dart) |
| State management | Riverpod |
| Networking | `http` package |
| Local storage | `shared_preferences` |
| Navigation | `go_router` |
| Image caching | `cached_network_image` |