import React from 'react';
import { StatusBar } from 'expo-status-bar';
import { SafeAreaProvider } from 'react-native-safe-area-context';
import { Provider } from 'react-redux';
import { store } from './app/store/store';
import AppNavigator from './app/navigation/AppNavigator';

/**
 * StarMotor App - Root Entry Point
 *
 * Architecture:
 * - Redux Provider wraps the entire app for global state management
 * - SafeAreaProvider handles safe area insets for notch/punch-hole displays
 * - AppNavigator controls authentication flow and screen routing
 */
export default function App() {
  return (
    <Provider store={store}>
      <SafeAreaProvider>
        <StatusBar style="light" backgroundColor="#0a0a0f" />
        <AppNavigator />
      </SafeAreaProvider>
    </Provider>
  );
}
