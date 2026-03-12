# ★ Starmotor

> A comprehensive automotive lifestyle mobile app built with React Native (Expo) and TypeScript.

---

## View the App (Browser Preview)

Open the self-contained interactive preview in your browser — **no toolchain required**:

| Platform | Command |
|----------|---------|
| **macOS** | `open preview/index.html` |
| **Windows** | `start preview\index.html` |
| **Linux** | `xdg-open preview/index.html` |

Or simply double-click `preview/index.html` in your file manager / IDE.

The preview includes all **8 screens** rendered inside a phone-chrome frame with a working bottom navigation bar:

- **Login** — email / password sign-in with JWT authentication
- **Dashboard** — personalised home feed and quick-access tiles
- **Vehicles** — showroom, filterable catalogue, full spec viewer, inquiry form
- **Store** — accessories & merchandise with cart and checkout flow
- **Events** — upcoming brand events with registration
- **Community** — forum feed with likes, comments, and category filters
- **Rewards** — daily check-in, points balance, and redemption catalogue
- **Service** — AI chatbot (STAR AI), FAQ, and support tickets
- **Profile** — user stats, linked vehicles, order history, settings

---

## 📱 Run on Expo Go (VS Code Terminal)

The full React Native source lives in `mobile-app/`. The quickest way to run the app on a **physical device** is via [Expo Go](https://expo.dev/go).

### Prerequisites
- [Node.js 18+](https://nodejs.org/)
- [Expo Go](https://expo.dev/go) installed on your iOS or Android device

### Steps

1. **Open the project in VS Code** and launch the integrated terminal:
   - **Windows / Linux:** `Ctrl` + `` ` `` (backtick key)
   - **macOS:** `Cmd` + `` ` `` (backtick key)

2. **Navigate to the mobile app directory:**
   ```bash
   cd mobile-app
   ```

3. **Install dependencies** (first time only):
   ```bash
   npm install
   ```

4. **Start the Expo development server:**
   ```bash
   npx expo start
   ```
   A QR code will appear directly in the VS Code terminal.

5. **Open in Expo Go:**
   - **Android:** Open the Expo Go app and tap **"Scan QR Code"**, then point your camera at the QR code in the terminal.
   - **iOS:** Open the default **Camera** app and scan the QR code — tap the Expo Go banner that appears.

> **Tip – on a different Wi-Fi network?** If your computer and phone are on separate networks, start with tunnel mode instead:
> ```bash
> npx expo start --tunnel
> ```

### Other launch options

| Target | Command |
|--------|---------|
| Expo Go (default) | `npx expo start` |
| Expo Go via tunnel | `npx expo start --tunnel` |
| Android emulator | `npx expo start --android` |
| iOS simulator (macOS) | `npx expo start --ios` |
| Web browser | `npx expo start --web` |

---

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Framework | React Native (Expo ~51) |
| Language | TypeScript |
| Navigation | React Navigation 6 |
| State management | Redux Toolkit |
| API client | Axios |
| Local storage | AsyncStorage |
| UI components | React Native Paper + Custom |