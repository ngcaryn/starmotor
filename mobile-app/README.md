# StarMotor Automotive Mobile App

A production-ready cross-platform automotive mobile application built with React Native (Expo) and TypeScript. The app represents a high-tech automotive brand digital ecosystem supporting the full customer lifecycle from awareness through advocacy.

## 🚗 Features

### 1. Vehicle Management
- **Showroom** – Browse and explore vehicle models with detailed specs
- **Vehicle Catalog** – Filterable catalog by category
- **Specification Viewer** – Full technical specification display
- **Vehicle Inquiry** – Request test drives and inquiries

### 2. Automotive Commerce Platform
- **Product Catalog** – Browse accessories and merchandise
- **Shopping Cart** – Add/remove items, manage quantities
- **Checkout Flow** – Third-party payment integration ready

### 3. Events & Marketing
- **Event Listing** – Browse upcoming brand events
- **Event Registration** – Register/cancel event registrations
- **Campaign Display** – Marketing banners and promotions

### 4. Customer Service
- **AI Chatbot** – Intelligent virtual assistant (STAR AI)
- **FAQ Knowledge Base** – Expandable FAQ database
- **Support Tickets** – Create and track support requests

### 5. User Account Management
- **Authentication** – Email/password login with JWT
- **Profile Management** – Edit profile information
- **Persistent Sessions** – AsyncStorage token management
- **Account Deletion** – GDPR-compliant account removal

### 6. Rewards & Loyalty
- **Daily Check-in** – Earn points with daily streaks
- **Points Balance** – Real-time balance display
- **Rewards Catalog** – Redeem points for benefits
- **Achievement Tracking** – Streak and history display

### 7. Community Platform
- **Forum** – Browse and create community posts
- **Post Interaction** – Like, comment, and share posts
- **Category Filtering** – Filter by topic categories

---

## 🛠️ Technology Stack

| Layer | Technology |
|-------|-----------|
| Framework | React Native (Expo ~51) |
| Language | TypeScript |
| Navigation | React Navigation 6 |
| State Management | Redux Toolkit |
| API Client | Axios |
| Local Storage | AsyncStorage |
| UI Components | React Native Paper + Custom |

---

## 📁 Project Structure

```
/mobile-app
├── App.tsx                          # Application entry point
├── app.json                         # Expo configuration
├── package.json                     # Dependencies
├── tsconfig.json                    # TypeScript configuration
├── babel.config.js                  # Babel configuration
├── app/
│   ├── navigation/
│   │   └── AppNavigator.tsx         # Navigation structure
│   ├── screens/
│   │   ├── LoginScreen.tsx          # Authentication screen
│   │   ├── DashboardScreen.tsx      # Main dashboard
│   │   ├── VehicleScreen.tsx        # Vehicle showroom
│   │   ├── ProductStoreScreen.tsx   # E-commerce store
│   │   ├── EventsScreen.tsx         # Events & marketing
│   │   ├── CommunityScreen.tsx      # Community forum
│   │   ├── RewardsScreen.tsx        # Loyalty & rewards
│   │   ├── CustomerServiceScreen.tsx # AI chat & support
│   │   ├── ProfileScreen.tsx        # User profile
│   │   └── SettingsScreen.tsx       # App settings
│   ├── components/
│   │   ├── Header.tsx               # Navigation header
│   │   ├── Card.tsx                 # Card container
│   │   ├── Button.tsx               # Button component
│   │   ├── VehicleCard.tsx          # Vehicle display card
│   │   └── ProductCard.tsx          # Product display card
│   ├── services/
│   │   ├── api.ts                   # Axios API client
│   │   ├── authService.ts           # Authentication API
│   │   ├── vehicleService.ts        # Vehicle catalog API
│   │   └── commerceService.ts       # E-commerce API
│   ├── store/
│   │   ├── store.ts                 # Redux store config
│   │   ├── authSlice.ts             # Auth state slice
│   │   └── appSlice.ts              # App state slice
│   ├── hooks/
│   │   ├── useAppSelector.ts        # Typed Redux selector
│   │   └── useAppDispatch.ts        # Typed Redux dispatch
│   └── utils/
│       ├── formatters.ts            # Formatting utilities
│       └── validators.ts            # Input validation
└── assets/                          # Static assets
```

---

## 🚀 Installation & Setup

### Prerequisites
- [Node.js 18+](https://nodejs.org/)
- npm or yarn
- [Expo Go](https://expo.dev/go) app installed on your iOS or Android device (for physical-device testing)
- iOS Simulator (macOS only) or Android Emulator (optional)

### Step 1: Navigate to the app directory
```bash
cd mobile-app
```

### Step 2: Install dependencies
```bash
npm install
```

### Step 3: Start the development server
```bash
npm start
# or equivalently:
npx expo start
```

### Step 4: Run on a device/emulator

**Expo Go (physical device — recommended for quick testing):**
- Install [Expo Go](https://expo.dev/go) on your iOS or Android device
- A QR code appears in the terminal after `npm start`
- **Android:** Open the Expo Go app → tap **Scan QR Code** → scan the QR code
- **iOS:** Open the built-in **Camera** app → scan the QR code → tap the Expo Go banner

**iOS Simulator (macOS only):**
```bash
npm run ios
```

**Android Emulator:**
```bash
npm run android
```

---

## 💻 Running via VS Code Terminal

VS Code's integrated terminal is the fastest way to start the dev server and preview the app on a physical device with Expo Go.

### Steps

1. Open the `starmotor` project folder in VS Code.

2. Open the integrated terminal:
   - **Windows / Linux:** `Ctrl` + `` ` `` (backtick key)
   - **macOS:** `Cmd` + `` ` `` (backtick key)
   - Or go to **Terminal → New Terminal** in the menu bar.

3. Navigate to the mobile app:
   ```bash
   cd mobile-app
   ```

4. Install dependencies (first run only):
   ```bash
   npm install
   ```

5. Start the Expo dev server:
   ```bash
   npx expo start
   ```
   The VS Code terminal will show a QR code and an interactive menu:
   ```
   › Metro waiting on exp://192.168.x.x:8081
   › Scan the QR code above with Expo Go (Android) or the Camera app (iOS)

   › Press a │ open Android
   › Press i │ open iOS simulator
   › Press w │ open web

   › Press r │ reload app
   › Press m │ toggle menu
   › Press ? │ show all commands
   ```

6. **Choose how to open the app — pick one:**

   | What you want | What to do |
   |---|---|
   | Physical Android device | Open **Expo Go** → tap **Scan QR Code** → scan the QR in the terminal |
   | Physical iOS device | Open the **Camera** app → scan the QR code → tap the **Expo Go** banner |
   | Android emulator (running) | Press **`a`** in the terminal |
   | iOS simulator (macOS only) | Press **`i`** in the terminal |
   | Web browser | Press **`w`** in the terminal |

> **Different network?** If your phone and computer are on different Wi-Fi networks, use tunnel mode:
> ```bash
> npx expo start --tunnel
> ```

> **App not updating?** Press **`r`** in the terminal to reload, or shake your device and tap **Reload**.

### Quick-reference commands

| Goal | Command |
|------|---------|
| Start dev server (default) | `npx expo start` |
| Start with tunnel (cross-network) | `npx expo start --tunnel` |
| Open in Android emulator | `npx expo start --android` |
| Open in iOS simulator | `npx expo start --ios` |
| Open in web browser | `npx expo start --web` |

---

## 📱 Running in Production

### Build for iOS
```bash
npx expo build:ios
# or with EAS Build:
npx eas build --platform ios
```

### Build for Android
```bash
npx expo build:android
# or with EAS Build:
npx eas build --platform android
```

---

## ⚙️ Configuration

### API Backend
Update the base URL in `app/services/api.ts`:
```typescript
const BASE_URL = 'https://api.yourbackend.com/v1';
```

### Environment Variables
Create a `.env` file in the `mobile-app` directory:
```env
EXPO_PUBLIC_API_URL=https://api.yourbackend.com/v1
EXPO_PUBLIC_APP_ENV=development
```

---

## 🎨 Design Theme

The app follows a **precision-automotive metallic design language**:
- **Primary Background:** `#111112` (deep charcoal)
- **Card Background:** `#1a1a1c` (gunmetal steel)
- **Accent:** `#a0aab4` (brushed aluminum / cool silver)
- **Text Primary:** `#f0f0f2` (platinum white)
- **Text Secondary:** `#8c8c90` (silver gray)
- **Danger:** `#b84040` (muted red)

All design tokens are centralized in `app/theme/colors.ts`.

---

## 🔮 Future Improvements

1. **Vehicle 360° View** – Integrate 3D vehicle model viewer using Three.js/react-three-fiber
2. **Augmented Reality** – AR feature to visualize vehicle in your driveway
3. **Connected Vehicle** – Real-time vehicle telemetry (battery, range, location)
4. **Push Notifications** – FCM/APNs integration for real-time alerts
5. **Biometric Auth** – Face ID / Fingerprint authentication
6. **Multi-language** – Full i18n support with react-i18next
7. **Offline Mode** – Full offline capability with Redux Persist
8. **Dark/Light Mode** – Complete theme switching support
9. **Advanced Analytics** – User behavior tracking and insights
10. **Social Login** – Google, Apple, WeChat OAuth integration
11. **Vehicle OTA Updates** – Over-the-air software update management
12. **Smart Home Integration** – Connect with smart home platforms

---

## 📄 License

Copyright © 2025 StarMotor Co., Ltd. All rights reserved.
