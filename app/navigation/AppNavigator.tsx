import React from 'react';
import { StyleSheet, Platform } from 'react-native';
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import { useSelector } from 'react-redux';
import { RootState } from '../store/store';
import Colors from '../theme/colors';

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

// Bottom tab navigator — icon-free, label-only, metallic styling
const MainTabs: React.FC = () => (
  <Tab.Navigator
    screenOptions={{
      headerShown: false,
      tabBarStyle: styles.tabBar,
      tabBarActiveTintColor: Colors.accent,
      tabBarInactiveTintColor: Colors.textDim,
      tabBarLabelStyle: styles.tabLabel,
    }}
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
    backgroundColor: Colors.bgCard,
    borderTopColor: Colors.borderDark,
    borderTopWidth: 1,
    paddingBottom: Platform.OS === 'ios' ? 24 : 8,
    paddingTop: 10,
    height: Platform.OS === 'ios' ? 80 : 60,
  },
  tabLabel: {
    fontSize: 11,
    fontWeight: '500',
    letterSpacing: 0.4,
    textTransform: 'uppercase',
  },
});

export default AppNavigator;
