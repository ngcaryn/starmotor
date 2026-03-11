import React, { useEffect, useState } from 'react';
import {
  View,
  Text,
  StyleSheet,
  FlatList,
  TouchableOpacity,
  Alert,
} from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { useDispatch, useSelector } from 'react-redux';
import { RootState } from '../store/store';
import { setEvents, toggleEventRegistration } from '../store/appSlice';
import { AppEvent } from '../store/appSlice';
import Card from '../components/Card';
import Header from '../components/Header';
import Button from '../components/Button';

const MOCK_EVENTS: AppEvent[] = [
  {
    id: 'e1',
    title: 'StarMotor Launch Summit 2025',
    description:
      'Exclusive unveiling of our next-generation electric vehicle lineup. Join us for an immersive brand experience featuring test drives, technology showcases, and networking.',
    date: '2025-06-15',
    location: 'Shanghai International Auto Show, China',
    imageUrl: '',
    isRegistered: false,
  },
  {
    id: 'e2',
    title: 'Owner Track Day Experience',
    description:
      'An exclusive track day event for StarMotor owners. Push your vehicle to the limit on a professional circuit with coaching from our performance team.',
    date: '2025-07-20',
    location: 'Shanghai International Circuit',
    imageUrl: '',
    isRegistered: false,
  },
  {
    id: 'e3',
    title: 'EV Technology Symposium',
    description:
      'Deep dive into the future of electric mobility. Featuring keynotes from our engineering team, product demos, and interactive sessions.',
    date: '2025-08-05',
    location: 'StarMotor HQ, Beijing',
    imageUrl: '',
    isRegistered: true,
  },
  {
    id: 'e4',
    title: 'Community Drive Weekend',
    description:
      "Join hundreds of StarMotor enthusiasts for a scenic coastal drive along China's most beautiful coastline.",
    date: '2025-09-12',
    location: 'Coastal Route, Hangzhou',
    imageUrl: '',
    isRegistered: false,
  },
];

const EventsScreen: React.FC = () => {
  const dispatch = useDispatch();
  const { events } = useSelector((state: RootState) => state.app);
  const [selectedFilter, setSelectedFilter] = useState<'all' | 'registered'>('all');

  useEffect(() => {
    if (events.length === 0) {
      dispatch(setEvents(MOCK_EVENTS));
    }
  }, [dispatch, events.length]);

  const displayEvents = events.length > 0 ? events : MOCK_EVENTS;
  const filtered =
    selectedFilter === 'registered'
      ? displayEvents.filter((e) => e.isRegistered)
      : displayEvents;

  const handleRegister = (event: AppEvent) => {
    if (event.isRegistered) {
      Alert.alert(
        'Cancel Registration',
        `Cancel registration for "${event.title}"?`,
        [
          { text: 'No', style: 'cancel' },
          {
            text: 'Yes, Cancel',
            style: 'destructive',
            onPress: () => dispatch(toggleEventRegistration(event.id)),
          },
        ]
      );
    } else {
      dispatch(toggleEventRegistration(event.id));
      Alert.alert(
        'Registered!',
        `You are registered for "${event.title}". A confirmation email will be sent to you.`
      );
    }
  };

  const formatDate = (dateString: string) => {
    const date = new Date(dateString);
    return date.toLocaleDateString('en-US', {
      weekday: 'short',
      year: 'numeric',
      month: 'long',
      day: 'numeric',
    });
  };

  const renderEvent = ({ item }: { item: AppEvent }) => (
    <Card style={styles.eventCard}>
      {/* Event banner placeholder */}
      <View style={styles.eventBanner}>
        <Ionicons name="calendar-outline" size={40} color="#00d4ff" />
        {item.isRegistered && (
          <View style={styles.registeredBadge}>
            <Ionicons name="checkmark-circle" size={14} color="#0a0a0f" />
            <Text style={styles.registeredBadgeText}>Registered</Text>
          </View>
        )}
      </View>

      <View style={styles.eventInfo}>
        <Text style={styles.eventTitle}>{item.title}</Text>
        <Text style={styles.eventDescription} numberOfLines={3}>
          {item.description}
        </Text>

        <View style={styles.eventMeta}>
          <View style={styles.metaRow}>
            <Ionicons name="calendar" size={14} color="#00d4ff" />
            <Text style={styles.metaText}>{formatDate(item.date)}</Text>
          </View>
          <View style={styles.metaRow}>
            <Ionicons name="location" size={14} color="#00d4ff" />
            <Text style={styles.metaText}>{item.location}</Text>
          </View>
        </View>

        <Button
          title={item.isRegistered ? 'Cancel Registration' : 'Register Now'}
          onPress={() => handleRegister(item)}
          variant={item.isRegistered ? 'outline' : 'primary'}
          fullWidth
          size="medium"
          style={styles.registerButton}
        />
      </View>
    </Card>
  );

  return (
    <View style={styles.container}>
      <Header title="Events" subtitle="Brand experiences & activities" />

      {/* Filter tabs */}
      <View style={styles.filterRow}>
        <TouchableOpacity
          style={[styles.filterTab, selectedFilter === 'all' && styles.filterTabActive]}
          onPress={() => setSelectedFilter('all')}
        >
          <Text
            style={[
              styles.filterTabText,
              selectedFilter === 'all' && styles.filterTabTextActive,
            ]}
          >
            All Events ({displayEvents.length})
          </Text>
        </TouchableOpacity>
        <TouchableOpacity
          style={[
            styles.filterTab,
            selectedFilter === 'registered' && styles.filterTabActive,
          ]}
          onPress={() => setSelectedFilter('registered')}
        >
          <Text
            style={[
              styles.filterTabText,
              selectedFilter === 'registered' && styles.filterTabTextActive,
            ]}
          >
            My Events ({displayEvents.filter((e) => e.isRegistered).length})
          </Text>
        </TouchableOpacity>
      </View>

      {filtered.length === 0 ? (
        <View style={styles.emptyState}>
          <Ionicons name="calendar-outline" size={64} color="#2a2a3e" />
          <Text style={styles.emptyTitle}>No events found</Text>
          <Text style={styles.emptySubtext}>
            {selectedFilter === 'registered'
              ? 'Register for events to see them here'
              : 'Check back soon for upcoming events'}
          </Text>
        </View>
      ) : (
        <FlatList
          data={filtered}
          keyExtractor={(item) => item.id}
          renderItem={renderEvent}
          contentContainerStyle={styles.listContent}
          showsVerticalScrollIndicator={false}
        />
      )}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#0a0a0f',
  },
  filterRow: {
    flexDirection: 'row',
    paddingHorizontal: 16,
    paddingVertical: 10,
    gap: 10,
  },
  filterTab: {
    flex: 1,
    paddingVertical: 10,
    borderRadius: 10,
    alignItems: 'center',
    backgroundColor: '#12121f',
    borderWidth: 1,
    borderColor: '#1e1e35',
  },
  filterTabActive: {
    backgroundColor: '#001f2e',
    borderColor: '#00d4ff',
  },
  filterTabText: {
    color: '#6a6a7a',
    fontSize: 13,
    fontWeight: '600',
  },
  filterTabTextActive: {
    color: '#00d4ff',
  },
  listContent: {
    padding: 16,
  },
  eventCard: {
    padding: 0,
    overflow: 'hidden',
    marginBottom: 16,
  },
  eventBanner: {
    height: 120,
    backgroundColor: '#0d1a2e',
    alignItems: 'center',
    justifyContent: 'center',
    position: 'relative',
  },
  registeredBadge: {
    position: 'absolute',
    top: 10,
    right: 10,
    flexDirection: 'row',
    alignItems: 'center',
    gap: 4,
    backgroundColor: '#00d4ff',
    borderRadius: 6,
    paddingHorizontal: 8,
    paddingVertical: 4,
  },
  registeredBadgeText: {
    color: '#0a0a0f',
    fontSize: 11,
    fontWeight: '700',
  },
  eventInfo: {
    padding: 16,
  },
  eventTitle: {
    color: '#ffffff',
    fontSize: 18,
    fontWeight: '700',
    marginBottom: 8,
  },
  eventDescription: {
    color: '#6a6a7a',
    fontSize: 13,
    lineHeight: 19,
    marginBottom: 12,
  },
  eventMeta: {
    gap: 6,
    marginBottom: 16,
  },
  metaRow: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 6,
  },
  metaText: {
    color: '#8a8a9a',
    fontSize: 13,
  },
  registerButton: {},
  emptyState: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    padding: 40,
  },
  emptyTitle: {
    color: '#ffffff',
    fontSize: 20,
    fontWeight: '700',
    marginTop: 16,
    marginBottom: 8,
  },
  emptySubtext: {
    color: '#4a4a5a',
    fontSize: 14,
    textAlign: 'center',
  },
});

export default EventsScreen;
