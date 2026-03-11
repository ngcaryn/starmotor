import React, { useState, useEffect } from 'react';
import {
  View,
  Text,
  StyleSheet,
  ScrollView,
  FlatList,
  TouchableOpacity,
  Modal,
  TextInput,
  Alert,
} from 'react-native';
import { useSelector, useDispatch } from 'react-redux';
import { RootState } from '../store/store';
import { setVehicles } from '../store/appSlice';
import { Vehicle } from '../store/appSlice';
import VehicleCard from '../components/VehicleCard';
import Card from '../components/Card';
import Button from '../components/Button';
import Header from '../components/Header';
import Colors from '../theme/colors';

const MOCK_VEHICLES: Vehicle[] = [
  {
    id: '1', name: 'StarX Pro', model: 'StarX', year: 2025, price: 89900, imageUrl: '',
    specs: { range: '520 mi', acceleration: '2.9s 0-60', topSpeed: '162 mph', horsepower: '670 hp', torque: '713 lb-ft', battery: '100 kWh' },
    colors: ['#ffffff', '#1a1a2e', '#c0392b'], category: 'Sedan', isNew: true,
  },
  {
    id: '2', name: 'StarSUV Ultra', model: 'StarSUV', year: 2025, price: 119900, imageUrl: '',
    specs: { range: '480 mi', acceleration: '3.5s 0-60', topSpeed: '155 mph', horsepower: '800 hp', torque: '930 lb-ft', battery: '120 kWh' },
    colors: ['#2c3e50', '#e8e8e8', '#1a8c4e'], category: 'SUV', isNew: true,
  },
  {
    id: '3', name: 'StarGT Elite', model: 'StarGT', year: 2024, price: 149900, imageUrl: '',
    specs: { range: '400 mi', acceleration: '2.1s 0-60', topSpeed: '200 mph', horsepower: '1020 hp', torque: '1050 lb-ft', battery: '100 kWh' },
    colors: ['#f39c12', '#1a1a2e', '#e74c3c'], category: 'Sports', isNew: false,
  },
  {
    id: '4', name: 'StarCity EV', model: 'StarCity', year: 2025, price: 44900, imageUrl: '',
    specs: { range: '320 mi', acceleration: '5.2s 0-60', topSpeed: '125 mph', horsepower: '270 hp', torque: '317 lb-ft', battery: '75 kWh' },
    colors: ['#3498db', '#f1c40f', '#2ecc71'], category: 'Compact', isNew: true,
  },
];

const CATEGORIES = ['All', 'Sedan', 'SUV', 'Sports', 'Compact'];

interface InquiryForm { name: string; email: string; phone: string; message: string; }

const VehicleScreen: React.FC<{ navigation: any }> = ({ navigation }) => {
  const dispatch = useDispatch();
  const { vehicles } = useSelector((state: RootState) => state.app);
  const [selectedCategory, setSelectedCategory] = useState('All');
  const [selectedVehicle, setSelectedVehicle] = useState<Vehicle | null>(null);
  const [showInquiryModal, setShowInquiryModal] = useState(false);
  const [inquiryForm, setInquiryForm] = useState<InquiryForm>({ name: '', email: '', phone: '', message: '' });

  useEffect(() => {
    if (vehicles.length === 0) dispatch(setVehicles(MOCK_VEHICLES));
  }, [dispatch, vehicles.length]);

  const displayVehicles = vehicles.length > 0 ? vehicles : MOCK_VEHICLES;
  const filteredVehicles = selectedCategory === 'All'
    ? displayVehicles
    : displayVehicles.filter((v) => v.category === selectedCategory);

  const handleInquirySubmit = () => {
    if (!inquiryForm.name || !inquiryForm.email || !inquiryForm.phone) {
      Alert.alert('Missing Fields', 'Please fill in all required fields.'); return;
    }
    Alert.alert('Inquiry Submitted', 'Thank you! Our team will contact you within 24 hours.', [
      { text: 'OK', onPress: () => setShowInquiryModal(false) },
    ]);
  };

  // Vehicle detail view
  if (selectedVehicle) {
    return (
      <View style={styles.container}>
        <Header title={selectedVehicle.name} showBack onBack={() => setSelectedVehicle(null)} />
        <ScrollView showsVerticalScrollIndicator={false}>
          <View style={styles.vehicleHero}>
            <Text style={styles.heroInitials}>{selectedVehicle.model.substring(0, 2).toUpperCase()}</Text>
            <View style={styles.heroOverlay}>
              <Text style={styles.heroModel}>{selectedVehicle.model}</Text>
              <Text style={styles.heroName}>{selectedVehicle.name}</Text>
            </View>
          </View>
          <View style={styles.detailContent}>
            <View style={styles.priceRow}>
              <Text style={styles.detailPrice}>${selectedVehicle.price.toLocaleString()}</Text>
              {selectedVehicle.isNew && (
                <View style={styles.newBadge}><Text style={styles.newBadgeText}>NEW</Text></View>
              )}
            </View>
            <Text style={styles.sectionLabel}>Specifications</Text>
            <View style={styles.specsGrid}>
              {Object.entries(selectedVehicle.specs).map(([key, value]) => (
                <Card key={key} style={styles.specCard}>
                  <Text style={styles.specKey}>{key.replace(/([A-Z])/g, ' $1').toUpperCase()}</Text>
                  <Text style={styles.specValue}>{value}</Text>
                </Card>
              ))}
            </View>
            <Text style={styles.sectionLabel}>Available Colors</Text>
            <View style={styles.colorRow}>
              {selectedVehicle.colors.map((color, index) => (
                <View key={index} style={[styles.colorSwatch, { backgroundColor: color }]} />
              ))}
            </View>
            <Button title="Request Test Drive" onPress={() => setShowInquiryModal(true)} fullWidth size="large" style={styles.primaryButton} />
            <Button title="Compare Models" onPress={() => {}} variant="outline" fullWidth size="large" />
          </View>
        </ScrollView>

        <Modal visible={showInquiryModal} animationType="slide" transparent onRequestClose={() => setShowInquiryModal(false)}>
          <View style={styles.modalOverlay}>
            <View style={styles.modalContent}>
              <View style={styles.modalHeader}>
                <Text style={styles.modalTitle}>Request Test Drive</Text>
                <TouchableOpacity onPress={() => setShowInquiryModal(false)}>
                  <Text style={styles.modalClose}>×</Text>
                </TouchableOpacity>
              </View>
              {(['name', 'email', 'phone', 'message'] as const).map((field) => (
                <View key={field} style={styles.modalInputGroup}>
                  <Text style={styles.modalLabel}>{field.charAt(0).toUpperCase() + field.slice(1)}{field !== 'message' ? ' *' : ''}</Text>
                  <TextInput
                    style={[styles.modalInput, field === 'message' && styles.modalTextArea]}
                    value={inquiryForm[field]}
                    onChangeText={(text) => setInquiryForm((prev) => ({ ...prev, [field]: text }))}
                    placeholder={`Enter your ${field}`}
                    placeholderTextColor={Colors.textDim}
                    multiline={field === 'message'} numberOfLines={field === 'message' ? 3 : 1}
                    keyboardType={field === 'email' ? 'email-address' : field === 'phone' ? 'phone-pad' : 'default'}
                  />
                </View>
              ))}
              <Button title="Submit Inquiry" onPress={handleInquirySubmit} fullWidth size="large" style={{ marginTop: 8 }} />
            </View>
          </View>
        </Modal>
      </View>
    );
  }

  return (
    <View style={styles.container}>
      <Header title="Vehicles" subtitle="Explore our lineup" />
      <ScrollView horizontal showsHorizontalScrollIndicator={false} style={styles.categoryScroll} contentContainerStyle={styles.categoryContent}>
        {CATEGORIES.map((cat) => (
          <TouchableOpacity key={cat} style={[styles.categoryChip, selectedCategory === cat && styles.categoryChipActive]} onPress={() => setSelectedCategory(cat)}>
            <Text style={[styles.categoryChipText, selectedCategory === cat && styles.categoryChipTextActive]}>{cat}</Text>
          </TouchableOpacity>
        ))}
      </ScrollView>
      <FlatList
        data={filteredVehicles} keyExtractor={(item) => item.id}
        renderItem={({ item }) => (
          <View style={styles.horizontalCardWrapper}>
            <VehicleCard vehicle={item} onPress={setSelectedVehicle} horizontal />
          </View>
        )}
        contentContainerStyle={styles.listContent} showsVerticalScrollIndicator={false}
      />
    </View>
  );
};

const styles = StyleSheet.create({
  container: { flex: 1, backgroundColor: Colors.bgPrimary },
  categoryScroll: { maxHeight: 52 },
  categoryContent: { paddingHorizontal: 16, paddingVertical: 10, gap: 8 },
  categoryChip: { paddingHorizontal: 16, paddingVertical: 6, borderRadius: 4, borderWidth: 1, borderColor: Colors.border, backgroundColor: Colors.bgCard },
  categoryChipActive: { backgroundColor: Colors.bgElevated, borderColor: Colors.borderActive },
  categoryChipText: { color: Colors.textSecondary, fontSize: 12, fontWeight: '500' },
  categoryChipTextActive: { color: Colors.accent },
  listContent: { padding: 16 },
  horizontalCardWrapper: { marginBottom: 8 },
  vehicleHero: { height: 240, backgroundColor: Colors.bgInset, alignItems: 'center', justifyContent: 'center', position: 'relative' },
  heroInitials: { color: Colors.border, fontSize: 80, fontWeight: '200', letterSpacing: 8 },
  heroOverlay: { position: 'absolute', bottom: 16, left: 20 },
  heroModel: { color: Colors.accentDim, fontSize: 11, fontWeight: '600', letterSpacing: 2, textTransform: 'uppercase' },
  heroName: { color: Colors.textPrimary, fontSize: 26, fontWeight: '600' },
  detailContent: { padding: 20 },
  priceRow: { flexDirection: 'row', justifyContent: 'space-between', alignItems: 'center', marginBottom: 20 },
  detailPrice: { color: Colors.textPrimary, fontSize: 28, fontWeight: '700' },
  newBadge: { backgroundColor: Colors.bgElevated, borderRadius: 4, paddingHorizontal: 10, paddingVertical: 4, borderWidth: 1, borderColor: Colors.borderActive },
  newBadgeText: { color: Colors.accent, fontSize: 10, fontWeight: '600', letterSpacing: 1 },
  sectionLabel: { color: Colors.textPrimary, fontSize: 15, fontWeight: '600', marginBottom: 12, marginTop: 8 },
  specsGrid: { flexDirection: 'row', flexWrap: 'wrap', gap: 8, marginBottom: 20 },
  specCard: { padding: 12, minWidth: '30%', flex: 1 },
  specKey: { color: Colors.textDim, fontSize: 9, fontWeight: '600', letterSpacing: 1, marginBottom: 4 },
  specValue: { color: Colors.accent, fontSize: 13, fontWeight: '600' },
  colorRow: { flexDirection: 'row', gap: 10, marginBottom: 24 },
  colorSwatch: { width: 28, height: 28, borderRadius: 14, borderWidth: 1, borderColor: Colors.border },
  primaryButton: { marginBottom: 10 },
  modalOverlay: { flex: 1, backgroundColor: Colors.overlay, justifyContent: 'flex-end' },
  modalContent: { backgroundColor: Colors.bgCard, borderTopLeftRadius: 16, borderTopRightRadius: 16, padding: 24, borderTopWidth: 1, borderColor: Colors.border },
  modalHeader: { flexDirection: 'row', justifyContent: 'space-between', alignItems: 'center', marginBottom: 20 },
  modalTitle: { color: Colors.textPrimary, fontSize: 18, fontWeight: '600' },
  modalClose: { color: Colors.textSecondary, fontSize: 26, lineHeight: 26, fontWeight: '300' },
  modalInputGroup: { marginBottom: 14 },
  modalLabel: { color: Colors.textSecondary, fontSize: 11, fontWeight: '600', marginBottom: 6, letterSpacing: 0.8 },
  modalInput: { backgroundColor: Colors.bgInset, borderRadius: 6, borderWidth: 1, borderColor: Colors.border, color: Colors.textPrimary, fontSize: 14, paddingHorizontal: 12, paddingVertical: 11 },
  modalTextArea: { height: 80, textAlignVertical: 'top' },
});

export default VehicleScreen;
