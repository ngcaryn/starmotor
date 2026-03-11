import React, { useEffect } from 'react';
import {
  View,
  Text,
  StyleSheet,
  ScrollView,
  TouchableOpacity,
  Dimensions,
  FlatList,
} from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { useSelector, useDispatch } from 'react-redux';
import { RootState } from '../store/store';
import { setVehicles, setProducts, setEvents } from '../store/appSlice';
import Card from '../components/Card';
import VehicleCard from '../components/VehicleCard';

const { width } = Dimensions.get('window');

// Mock data for demonstration when API is unavailable
const MOCK_VEHICLES = [
  {
    id: '1',
    name: 'StarX Pro',
    model: 'StarX',
    year: 2025,
    price: 89900,
    imageUrl: '',
    specs: { range: '520 mi', acceleration: '2.9s', horsepower: '670 hp' },
    colors: ['#ffffff', '#1a1a2e', '#c0392b'],
    category: 'Sedan',
    isNew: true,
  },
  {
    id: '2',
    name: 'StarSUV Ultra',
    model: 'StarSUV',
    year: 2025,
    price: 119900,
    imageUrl: '',
    specs: { range: '480 mi', acceleration: '3.5s', horsepower: '800 hp' },
    colors: ['#2c3e50', '#e8e8e8', '#1a8c4e'],
    category: 'SUV',
    isNew: true,
  },
  {
    id: '3',
    name: 'StarGT Elite',
    model: 'StarGT',
    year: 2024,
    price: 149900,
    imageUrl: '',
    specs: { range: '400 mi', acceleration: '2.1s', horsepower: '1020 hp' },
    colors: ['#f39c12', '#1a1a2e', '#e74c3c'],
    category: 'Sports',
    isNew: false,
  },
];

const QUICK_ACTIONS = [
  { id: 'vehicles', icon: 'car-sport', label: 'Vehicles', screen: 'Vehicles' },
  { id: 'store', icon: 'bag-handle', label: 'Store', screen: 'Store' },
  { id: 'events', icon: 'calendar', label: 'Events', screen: 'Events' },
  { id: 'rewards', icon: 'star', label: 'Rewards', screen: 'Rewards' },
  { id: 'community', icon: 'people', label: 'Community', screen: 'Community' },
  { id: 'support', icon: 'headset', label: 'Support', screen: 'CustomerService' },
];

const DashboardScreen: React.FC<{ navigation: any }> = ({ navigation }) => {
  const dispatch = useDispatch();
  const { user } = useSelector((state: RootState) => state.auth);
  const { vehicles, rewards } = useSelector((state: RootState) => state.app);

  useEffect(() => {
    // Load mock data on mount (replace with real API calls in production)
    dispatch(setVehicles(MOCK_VEHICLES));
  }, [dispatch]);

  const displayVehicles = vehicles.length > 0 ? vehicles : MOCK_VEHICLES;

  return (
    <ScrollView
      style={styles.container}
      showsVerticalScrollIndicator={false}
      contentContainerStyle={styles.content}
    >
      {/* Header greeting */}
      <View style={styles.header}>
        <View>
          <Text style={styles.greeting}>
            Welcome back,
          </Text>
          <Text style={styles.userName}>{user?.name ?? 'Driver'}</Text>
        </View>
        <TouchableOpacity
          style={styles.notificationButton}
          onPress={() => navigation.navigate('Settings')}
          accessibilityLabel="Settings"
        >
          <Ionicons name="notifications-outline" size={24} color="#00d4ff" />
          <View style={styles.notificationDot} />
        </TouchableOpacity>
      </View>

      {/* Points summary card */}
      <Card style={styles.pointsCard} glowAccent>
        <View style={styles.pointsContent}>
          <View>
            <Text style={styles.pointsLabel}>STAR POINTS</Text>
            <Text style={styles.pointsValue}>{rewards.balance.toLocaleString()}</Text>
            <Text style={styles.pointsSubtext}>Streak: {rewards.streak} days 🔥</Text>
          </View>
          <TouchableOpacity
            style={styles.checkInButton}
            onPress={() => navigation.navigate('Rewards')}
          >
            <Ionicons name="checkmark-circle" size={20} color="#0a0a0f" />
            <Text style={styles.checkInText}>Check In</Text>
          </TouchableOpacity>
        </View>
      </Card>

      {/* Quick actions grid */}
      <View style={styles.sectionHeader}>
        <Text style={styles.sectionTitle}>Quick Access</Text>
      </View>

      <View style={styles.quickActionsGrid}>
        {QUICK_ACTIONS.map((action) => (
          <TouchableOpacity
            key={action.id}
            style={styles.quickAction}
            onPress={() => navigation.navigate(action.screen)}
            accessibilityRole="button"
            accessibilityLabel={action.label}
          >
            <View style={styles.quickActionIcon}>
              <Ionicons name={action.icon as any} size={24} color="#00d4ff" />
            </View>
            <Text style={styles.quickActionLabel}>{action.label}</Text>
          </TouchableOpacity>
        ))}
      </View>

      {/* Featured vehicles */}
      <View style={styles.sectionHeader}>
        <Text style={styles.sectionTitle}>Featured Models</Text>
        <TouchableOpacity onPress={() => navigation.navigate('Vehicles')}>
          <Text style={styles.seeAll}>See All</Text>
        </TouchableOpacity>
      </View>

      <FlatList
        horizontal
        data={displayVehicles}
        keyExtractor={(item) => item.id}
        renderItem={({ item }) => (
          <VehicleCard
            vehicle={item}
            onPress={() => navigation.navigate('Vehicles', { vehicleId: item.id })}
          />
        )}
        showsHorizontalScrollIndicator={false}
        contentContainerStyle={styles.vehicleList}
      />

      {/* Brand news banner */}
      <TouchableOpacity
        style={styles.newsBanner}
        onPress={() => navigation.navigate('Events')}
      >
        <View style={styles.newsBannerContent}>
          <View>
            <Text style={styles.newsBannerLabel}>UPCOMING EVENT</Text>
            <Text style={styles.newsBannerTitle}>StarMotor Launch Summit 2025</Text>
            <Text style={styles.newsBannerSubtext}>June 15, 2025 • Shanghai</Text>
          </View>
          <Ionicons name="arrow-forward-circle" size={32} color="#00d4ff" />
        </View>
      </TouchableOpacity>
    </ScrollView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#0a0a0f',
  },
  content: {
    paddingBottom: 24,
  },
  header: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingHorizontal: 20,
    paddingTop: 20,
    paddingBottom: 8,
  },
  greeting: {
    color: '#6a6a7a',
    fontSize: 14,
  },
  userName: {
    color: '#ffffff',
    fontSize: 22,
    fontWeight: '700',
  },
  notificationButton: {
    position: 'relative',
    padding: 8,
    backgroundColor: '#12121f',
    borderRadius: 12,
    borderWidth: 1,
    borderColor: '#1e1e35',
  },
  notificationDot: {
    position: 'absolute',
    top: 8,
    right: 8,
    width: 8,
    height: 8,
    borderRadius: 4,
    backgroundColor: '#00d4ff',
  },
  pointsCard: {
    marginHorizontal: 20,
    marginTop: 16,
    backgroundColor: '#0d1a2e',
  },
  pointsContent: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  pointsLabel: {
    color: '#00d4ff',
    fontSize: 11,
    fontWeight: '700',
    letterSpacing: 2,
    marginBottom: 4,
  },
  pointsValue: {
    color: '#ffffff',
    fontSize: 32,
    fontWeight: '800',
    marginBottom: 2,
  },
  pointsSubtext: {
    color: '#8a8a9a',
    fontSize: 13,
  },
  checkInButton: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 6,
    backgroundColor: '#00d4ff',
    paddingHorizontal: 16,
    paddingVertical: 10,
    borderRadius: 10,
  },
  checkInText: {
    color: '#0a0a0f',
    fontWeight: '700',
    fontSize: 14,
  },
  sectionHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingHorizontal: 20,
    marginTop: 24,
    marginBottom: 12,
  },
  sectionTitle: {
    color: '#ffffff',
    fontSize: 18,
    fontWeight: '700',
  },
  seeAll: {
    color: '#00d4ff',
    fontSize: 13,
    fontWeight: '600',
  },
  quickActionsGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    paddingHorizontal: 14,
    gap: 8,
  },
  quickAction: {
    width: (width - 60) / 3,
    backgroundColor: '#12121f',
    borderRadius: 12,
    padding: 14,
    alignItems: 'center',
    borderWidth: 1,
    borderColor: '#1e1e35',
  },
  quickActionIcon: {
    width: 44,
    height: 44,
    borderRadius: 22,
    backgroundColor: '#0d1a2e',
    alignItems: 'center',
    justifyContent: 'center',
    marginBottom: 8,
  },
  quickActionLabel: {
    color: '#8a8a9a',
    fontSize: 11,
    fontWeight: '600',
  },
  vehicleList: {
    paddingLeft: 16,
    paddingRight: 8,
  },
  newsBanner: {
    marginHorizontal: 20,
    marginTop: 24,
    backgroundColor: '#0d1a2e',
    borderRadius: 14,
    padding: 18,
    borderWidth: 1,
    borderColor: '#00d4ff',
  },
  newsBannerContent: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  newsBannerLabel: {
    color: '#00d4ff',
    fontSize: 10,
    fontWeight: '700',
    letterSpacing: 1.5,
    marginBottom: 4,
  },
  newsBannerTitle: {
    color: '#ffffff',
    fontSize: 16,
    fontWeight: '700',
    marginBottom: 4,
  },
  newsBannerSubtext: {
    color: '#8a8a9a',
    fontSize: 12,
  },
});

export default DashboardScreen;
