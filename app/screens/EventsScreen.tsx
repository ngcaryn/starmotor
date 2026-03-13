import React, { useState } from 'react';
import { View, Text, StyleSheet, FlatList, TouchableOpacity, Alert, ScrollView } from 'react-native';
import Card from '../components/Card';
import Header from '../components/Header';
import Button from '../components/Button';
import Colors from '../theme/colors';

interface Event {
  id: string; title: string; date: string; location: string; type: string;
  description: string; registered: boolean; capacity: number; registered_count: number;
}

const MOCK_EVENTS: Event[] = [
  { id: '1', title: 'StarMotor Launch Summit 2025', date: 'Jun 15, 2025', location: 'Shanghai Expo Center', type: 'LAUNCH', description: 'Global launch of the new StarGT Elite and StarSUV Ultra. Exclusive test drives, technical presentations, and brand experiences.', registered: false, capacity: 500, registered_count: 312 },
  { id: '2', title: 'Test Drive Weekend', date: 'Jul 4–6, 2025', location: 'Multiple Locations', type: 'TEST DRIVE', description: 'Three-day nationwide test drive event. Book your slot and experience the full StarMotor lineup.', registered: true, capacity: 200, registered_count: 200 },
  { id: '3', title: 'StarMotor Owners Rally', date: 'Aug 10, 2025', location: 'Beijing Ring Road', type: 'COMMUNITY', description: 'Annual owners rally with driving challenges, social events, and exclusive merchandise giveaways.', registered: false, capacity: 150, registered_count: 89 },
  { id: '4', title: 'EV Technology Forum', date: 'Sep 20, 2025', location: 'Online', type: 'FORUM', description: 'Live-streamed technical forum covering battery innovation, software updates, and future roadmap.', registered: false, capacity: 5000, registered_count: 1420 },
];

const EventsScreen: React.FC<{ navigation: any }> = ({ navigation }) => {
  const [events, setEvents] = useState(MOCK_EVENTS);
  const [selectedEvent, setSelectedEvent] = useState<Event | null>(null);

  const handleRegister = (eventId: string) => {
    setEvents((prev) => prev.map((e) => e.id === eventId ? { ...e, registered: true, registered_count: e.registered_count + 1 } : e));
    Alert.alert('Registered', 'You have been registered for this event. A confirmation email will be sent.');
    if (selectedEvent?.id === eventId) setSelectedEvent((prev) => prev ? { ...prev, registered: true } : prev);
  };

  if (selectedEvent) {
    return (
      <View style={styles.container}>
        <Header title="Event Details" showBack onBack={() => setSelectedEvent(null)} />
        <ScrollView contentContainerStyle={styles.detailContent}>
          <View style={styles.eventTypeTag}><Text style={styles.eventTypeText}>{selectedEvent.type}</Text></View>
          <Text style={styles.detailTitle}>{selectedEvent.title}</Text>
          <Text style={styles.detailDate}>{selectedEvent.date}</Text>
          <Text style={styles.detailLocation}>{selectedEvent.location}</Text>
          <Text style={styles.detailDescription}>{selectedEvent.description}</Text>
          <Card style={styles.capacityCard}>
            <Text style={styles.capacityLabel}>REGISTRATION</Text>
            <Text style={styles.capacityValue}>{selectedEvent.registered_count} / {selectedEvent.capacity}</Text>
          </Card>
          {selectedEvent.registered ? (
            <View style={styles.registeredBanner}>
              <Text style={styles.registeredText}>You are registered for this event</Text>
            </View>
          ) : selectedEvent.registered_count >= selectedEvent.capacity ? (
            <View style={styles.fullBanner}><Text style={styles.fullText}>Event is at full capacity</Text></View>
          ) : (
            <Button title="Register Now" onPress={() => handleRegister(selectedEvent.id)} fullWidth size="large" />
          )}
        </ScrollView>
      </View>
    );
  }

  return (
    <View style={styles.container}>
      <Header title="Events" subtitle="Upcoming activities" />
      <FlatList
        data={events} keyExtractor={(item) => item.id}
        renderItem={({ item }) => (
          <TouchableOpacity style={styles.eventCard} onPress={() => setSelectedEvent(item)}>
            <View style={styles.eventCardInner}>
              <View style={styles.eventTypeTag}><Text style={styles.eventTypeText}>{item.type}</Text></View>
              <Text style={styles.eventTitle}>{item.title}</Text>
              <Text style={styles.eventMeta}>{item.date}  ·  {item.location}</Text>
              {item.registered && <Text style={styles.registeredBadge}>Registered</Text>}
            </View>
            <Text style={styles.arrowText}>›</Text>
          </TouchableOpacity>
        )}
        contentContainerStyle={styles.listContent} showsVerticalScrollIndicator={false}
      />
    </View>
  );
};

const styles = StyleSheet.create({
  container: { flex: 1, backgroundColor: Colors.bgPrimary },
  listContent: { padding: 16 },
  eventCard: { flexDirection: 'row', alignItems: 'center', backgroundColor: Colors.bgCard, borderRadius: 8, borderWidth: 1, borderColor: Colors.border, padding: 14, marginBottom: 8 },
  eventCardInner: { flex: 1 },
  eventTypeTag: { alignSelf: 'flex-start', backgroundColor: Colors.bgInset, borderRadius: 3, paddingHorizontal: 8, paddingVertical: 3, marginBottom: 6, borderWidth: 1, borderColor: Colors.borderDark },
  eventTypeText: { color: Colors.accentDim, fontSize: 9, fontWeight: '600', letterSpacing: 1.5 },
  eventTitle: { color: Colors.textPrimary, fontSize: 15, fontWeight: '600', marginBottom: 4 },
  eventMeta: { color: Colors.textSecondary, fontSize: 12 },
  registeredBadge: { color: Colors.success, fontSize: 11, fontWeight: '600', marginTop: 6 },
  arrowText: { color: Colors.accentDim, fontSize: 22, fontWeight: '300', paddingLeft: 8 },
  detailContent: { padding: 20 },
  detailTitle: { color: Colors.textPrimary, fontSize: 22, fontWeight: '600', marginBottom: 8, marginTop: 8 },
  detailDate: { color: Colors.accent, fontSize: 14, fontWeight: '500', marginBottom: 4 },
  detailLocation: { color: Colors.textSecondary, fontSize: 13, marginBottom: 16 },
  detailDescription: { color: Colors.textSecondary, fontSize: 14, lineHeight: 22, marginBottom: 20 },
  capacityCard: { marginBottom: 20 },
  capacityLabel: { color: Colors.textDim, fontSize: 10, fontWeight: '600', letterSpacing: 1.5, marginBottom: 6 },
  capacityValue: { color: Colors.textPrimary, fontSize: 22, fontWeight: '600' },
  registeredBanner: { backgroundColor: 'rgba(74,124,94,0.12)', borderRadius: 6, padding: 14, borderWidth: 1, borderColor: Colors.success },
  registeredText: { color: Colors.success, fontSize: 14, fontWeight: '500', textAlign: 'center' },
  fullBanner: { backgroundColor: Colors.bgElevated, borderRadius: 6, padding: 14, borderWidth: 1, borderColor: Colors.border },
  fullText: { color: Colors.textSecondary, fontSize: 14, textAlign: 'center' },
});

export default EventsScreen;
