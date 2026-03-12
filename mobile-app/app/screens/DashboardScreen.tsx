import React, { useEffect } from 'react';
import {
  View,
  Text,
  StyleSheet,
  ScrollView,
  TouchableOpacity,
  Dimensions,
  FlatList,
  Linking,
  Alert,
} from 'react-native';
import { useSelector, useDispatch } from 'react-redux';
import { RootState } from '../store/store';
import { setVehicles } from '../store/appSlice';
import Card from '../components/Card';
import VehicleCard from '../components/VehicleCard';
import Colors from '../theme/colors';

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
  { id: 'vehicles', label: 'Vehicles', screen: 'Vehicles' },
  { id: 'store', label: 'Store', screen: 'Store' },
  { id: 'events', label: 'Events', screen: 'Events' },
  { id: 'rewards', label: 'Rewards', screen: 'Rewards' },
  { id: 'community', label: 'Community', screen: 'Community' },
  { id: 'support', label: 'Support', screen: 'CustomerService' },
];

// News items with external URLs — tap to open in browser
const NEWS_ITEMS = [
  {
    id: 'n1',
    label: 'PRESS RELEASE',
    title: 'StarMotor Unveils 1,000-HP StarGT Elite at Shanghai Motor Show',
    date: 'Jun 2025',
    url: 'https://insideevs.com',
  },
  {
    id: 'n2',
    label: 'TECHNOLOGY',
    title: "StarMotor's 250 kW Solid-State Battery — Full Technical Breakdown",
    date: 'May 2025',
    url: 'https://electrek.co',
  },
  {
    id: 'n3',
    label: 'INDUSTRY',
    title: 'StarMotor Named Top EV Brand in J.D. Power 2025 Quality Study',
    date: 'Apr 2025',
    url: 'https://www.motortrend.com',
  },
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

  const openNewsLink = (url: string) => {
    Linking.openURL(url).catch(() => {
      Alert.alert('Unable to Open', 'Could not open the link. Please try again later.');
    });
  };

  return (
    <ScrollView
      style={styles.container}
      showsVerticalScrollIndicator={false}
      contentContainerStyle={styles.content}
    >
      {/* Header greeting */}
      <View style={styles.header}>
        <View>
          <Text style={styles.greeting}>Welcome back</Text>
          <Text style={styles.userName}>{user?.name ?? 'Driver'}</Text>
        </View>
        <TouchableOpacity
          style={styles.settingsButton}
          onPress={() => navigation.navigate('Settings')}
          accessibilityLabel="Settings"
        >
          <Text style={styles.settingsLabel}>Settings</Text>
        </TouchableOpacity>
      </View>

      {/* Points summary card */}
      <Card style={styles.pointsCard} active>
        <View style={styles.pointsContent}>
          <View>
            <Text style={styles.pointsLabel}>STAR POINTS</Text>
            <Text style={styles.pointsValue}>{rewards.balance.toLocaleString()}</Text>
            <Text style={styles.pointsSubtext}>
              {rewards.streak > 0
                ? `${rewards.streak}-day streak`
                : 'Start your streak today'}
            </Text>
          </View>
          <TouchableOpacity
            style={styles.checkInButton}
            onPress={() => navigation.navigate('Rewards')}
          >
            <Text style={styles.checkInText}>Check In</Text>
          </TouchableOpacity>
        </View>
      </Card>

      {/* Quick access grid */}
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
            <Text style={styles.quickActionLabel}>{action.label}</Text>
          </TouchableOpacity>
        ))}
      </View>

      {/* Featured vehicles */}
      <View style={styles.sectionHeader}>
        <Text style={styles.sectionTitle}>Featured Models</Text>
        <TouchableOpacity onPress={() => navigation.navigate('Vehicles')}>
          <Text style={styles.seeAll}>View All</Text>
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

      {/* Latest News section */}
      <View style={styles.sectionHeader}>
        <Text style={styles.sectionTitle}>Latest News</Text>
      </View>

      {NEWS_ITEMS.map((item) => (
        <TouchableOpacity
          key={item.id}
          style={styles.newsItem}
          onPress={() => openNewsLink(item.url)}
          accessibilityRole="link"
          accessibilityLabel={item.title}
        >
          <View style={styles.newsItemInner}>
            <View style={styles.newsTextBlock}>
              <Text style={styles.newsLabel}>{item.label}</Text>
              <Text style={styles.newsTitle}>{item.title}</Text>
              <Text style={styles.newsDate}>{item.date}</Text>
            </View>
            <Text style={styles.newsArrow}>›</Text>
          </View>
        </TouchableOpacity>
      ))}
    </ScrollView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: Colors.bgPrimary,
  },
  content: {
    paddingBottom: 32,
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
    color: Colors.textSecondary,
    fontSize: 13,
    fontWeight: '400',
  },
  userName: {
    color: Colors.textPrimary,
    fontSize: 20,
    fontWeight: '600',
    letterSpacing: 0.3,
  },
  settingsButton: {
    paddingHorizontal: 12,
    paddingVertical: 7,
    backgroundColor: Colors.bgCard,
    borderRadius: 6,
    borderWidth: 1,
    borderColor: Colors.border,
  },
  settingsLabel: {
    color: Colors.textSecondary,
    fontSize: 12,
    fontWeight: '500',
    letterSpacing: 0.3,
  },
  pointsCard: {
    marginHorizontal: 20,
    marginTop: 16,
  },
  pointsContent: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  pointsLabel: {
    color: Colors.accentDim,
    fontSize: 10,
    fontWeight: '600',
    letterSpacing: 2,
    marginBottom: 4,
  },
  pointsValue: {
    color: Colors.textPrimary,
    fontSize: 30,
    fontWeight: '600',
    marginBottom: 2,
  },
  pointsSubtext: {
    color: Colors.textSecondary,
    fontSize: 12,
  },
  checkInButton: {
    backgroundColor: Colors.accent,
    paddingHorizontal: 18,
    paddingVertical: 10,
    borderRadius: 6,
  },
  checkInText: {
    color: Colors.bgPrimary,
    fontWeight: '600',
    fontSize: 13,
    letterSpacing: 0.4,
  },
  sectionHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingHorizontal: 20,
    marginTop: 28,
    marginBottom: 12,
  },
  sectionTitle: {
    color: Colors.textPrimary,
    fontSize: 16,
    fontWeight: '600',
    letterSpacing: 0.3,
  },
  seeAll: {
    color: Colors.accentDim,
    fontSize: 12,
    fontWeight: '500',
    letterSpacing: 0.3,
  },
  quickActionsGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    paddingHorizontal: 14,
    gap: 8,
  },
  quickAction: {
    width: (width - 60) / 3,
    backgroundColor: Colors.bgCard,
    borderRadius: 8,
    paddingVertical: 14,
    paddingHorizontal: 8,
    alignItems: 'center',
    borderWidth: 1,
    borderColor: Colors.border,
  },
  quickActionLabel: {
    color: Colors.textSecondary,
    fontSize: 12,
    fontWeight: '500',
    letterSpacing: 0.3,
  },
  vehicleList: {
    paddingLeft: 16,
    paddingRight: 8,
  },
  // News section
  newsItem: {
    marginHorizontal: 20,
    marginBottom: 8,
    backgroundColor: Colors.bgCard,
    borderRadius: 8,
    borderWidth: 1,
    borderColor: Colors.border,
  },
  newsItemInner: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: 14,
    gap: 8,
  },
  newsTextBlock: {
    flex: 1,
  },
  newsLabel: {
    color: Colors.accentDim,
    fontSize: 9,
    fontWeight: '600',
    letterSpacing: 1.5,
    marginBottom: 4,
  },
  newsTitle: {
    color: Colors.textPrimary,
    fontSize: 14,
    fontWeight: '500',
    lineHeight: 20,
    marginBottom: 4,
  },
  newsDate: {
    color: Colors.textDim,
    fontSize: 11,
  },
  newsArrow: {
    color: Colors.accentDim,
    fontSize: 22,
    fontWeight: '300',
  },
});

export default DashboardScreen;
