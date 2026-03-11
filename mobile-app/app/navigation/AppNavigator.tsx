import React from 'react';
import { View, StyleSheet, Platform } from 'react-native';
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import { Ionicons } from '@expo/vector-icons';
import { useSelector } from 'react-redux';
import { RootState } from '../store/store';

// Screens
import LoginScreen from '../screens/LoginScreen';
import DashboardScreen from '../screens/DashboardScreen';
import VehicleScreen from '../screens/VehicleScreen';
import ProductStoreScreen from '../screens/ProductStoreScreen';
import EventsScreen from '../screens/EventsScreen';
import CommunityScreen from '../screens/CommunityScreen';
import RewardsScreen from '../screens/RewardsScreen';
import CustomerServiceScreen from '../screens/CustomerServiceScreen';
import ProfileScreen from '../screens/ProfileScreen';
import SettingsScreen from '../screens/SettingsScreen';

// Stack param lists
export type RootStackParamList = {
  Auth: undefined;
  Main: undefined;
};

export type AuthStackParamList = {
  Login: undefined;
};

export type MainTabParamList = {
  Dashboard: undefined;
  Vehicles: { vehicleId?: string } | undefined;
  Store: undefined;
  Community: undefined;
  Profile: undefined;
};

export type MainStackParamList = {
  HomeTabs: undefined;
  Events: undefined;
  Rewards: undefined;
  CustomerService: undefined;
  Settings: undefined;
};

const RootStack = createNativeStackNavigator<RootStackParamList>();
const AuthStack = createNativeStackNavigator<AuthStackParamList>();
const Tab = createBottomTabNavigator<MainTabParamList>();
const MainStack = createNativeStackNavigator<MainStackParamList>();

// Tab icon config for the bottom navigation
const TAB_ICONS: Record<string, { active: string; inactive: string }> = {
  Dashboard: { active: 'grid', inactive: 'grid-outline' },
  Vehicles: { active: 'car-sport', inactive: 'car-sport-outline' },
  Store: { active: 'bag-handle', inactive: 'bag-handle-outline' },
  Community: { active: 'people', inactive: 'people-outline' },
  Profile: { active: 'person', inactive: 'person-outline' },
};

// Bottom tab navigator with dark theme
const MainTabs: React.FC = () => (
  <Tab.Navigator
    screenOptions={({ route }) => ({
      headerShown: false,
      tabBarStyle: styles.tabBar,
      tabBarActiveTintColor: '#00d4ff',
      tabBarInactiveTintColor: '#4a4a5a',
      tabBarLabelStyle: styles.tabLabel,
      tabBarIcon: ({ focused, color, size }) => {
        const icons = TAB_ICONS[route.name] ?? { active: 'apps', inactive: 'apps-outline' };
        return (
          <Ionicons
            name={(focused ? icons.active : icons.inactive) as any}
            size={size}
            color={color}
          />
        );
      },
    })}
  >
    <Tab.Screen name="Dashboard" component={DashboardScreen} />
    <Tab.Screen name="Vehicles" component={VehicleScreen} />
    <Tab.Screen name="Store" component={ProductStoreScreen} />
    <Tab.Screen name="Community" component={CommunityScreen} />
    <Tab.Screen name="Profile" component={ProfileScreen} />
  </Tab.Navigator>
);

// Main stack navigator for deeper screens accessible from the bottom tabs
const MainNavigator: React.FC = () => (
  <MainStack.Navigator screenOptions={{ headerShown: false }}>
    <MainStack.Screen name="HomeTabs" component={MainTabs} />
    <MainStack.Screen name="Events" component={EventsScreen} />
    <MainStack.Screen name="Rewards" component={RewardsScreen} />
    <MainStack.Screen name="CustomerService" component={CustomerServiceScreen} />
    <MainStack.Screen name="Settings" component={SettingsScreen} />
  </MainStack.Navigator>
);

// Auth stack for unauthenticated users
const AuthNavigator: React.FC = () => (
  <AuthStack.Navigator screenOptions={{ headerShown: false }}>
    <AuthStack.Screen name="Login" component={LoginScreen} />
  </AuthStack.Navigator>
);

// Root app navigator: switches between Auth and Main based on auth state
const AppNavigator: React.FC = () => {
  const { isAuthenticated } = useSelector((state: RootState) => state.auth);

  return (
    <NavigationContainer>
      <RootStack.Navigator screenOptions={{ headerShown: false }}>
        {isAuthenticated ? (
          <RootStack.Screen name="Main" component={MainNavigator} />
        ) : (
          <RootStack.Screen name="Auth" component={AuthNavigator} />
        )}
      </RootStack.Navigator>
    </NavigationContainer>
  );
};

const styles = StyleSheet.create({
  tabBar: {
    backgroundColor: '#0d0d1a',
    borderTopColor: '#1a1a2e',
    borderTopWidth: 1,
    paddingBottom: Platform.OS === 'ios' ? 24 : 8,
    paddingTop: 8,
    height: Platform.OS === 'ios' ? 84 : 64,
  },
  tabLabel: {
    fontSize: 11,
    fontWeight: '600',
    marginTop: 2,
  },
});

export default AppNavigator;
