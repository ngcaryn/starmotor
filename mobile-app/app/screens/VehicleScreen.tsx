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
import { Ionicons } from '@expo/vector-icons';
import { useSelector, useDispatch } from 'react-redux';
import { RootState } from '../store/store';
import { setVehicles } from '../store/appSlice';
import { Vehicle } from '../store/appSlice';
import VehicleCard from '../components/VehicleCard';
import Card from '../components/Card';
import Button from '../components/Button';
import Header from '../components/Header';

// Comprehensive mock vehicle data for the showroom
const MOCK_VEHICLES: Vehicle[] = [
  {
    id: '1',
    name: 'StarX Pro',
    model: 'StarX',
    year: 2025,
    price: 89900,
    imageUrl: '',
    specs: {
      range: '520 mi',
      acceleration: '2.9s 0-60',
      topSpeed: '162 mph',
      horsepower: '670 hp',
      torque: '713 lb-ft',
      battery: '100 kWh',
    },
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
    specs: {
      range: '480 mi',
      acceleration: '3.5s 0-60',
      topSpeed: '155 mph',
      horsepower: '800 hp',
      torque: '930 lb-ft',
      battery: '120 kWh',
    },
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
    specs: {
      range: '400 mi',
      acceleration: '2.1s 0-60',
      topSpeed: '200 mph',
      horsepower: '1020 hp',
      torque: '1050 lb-ft',
      battery: '100 kWh',
    },
    colors: ['#f39c12', '#1a1a2e', '#e74c3c'],
    category: 'Sports',
    isNew: false,
  },
  {
    id: '4',
    name: 'StarCity EV',
    model: 'StarCity',
    year: 2025,
    price: 44900,
    imageUrl: '',
    specs: {
      range: '320 mi',
      acceleration: '5.2s 0-60',
      topSpeed: '125 mph',
      horsepower: '270 hp',
      torque: '317 lb-ft',
      battery: '75 kWh',
    },
    colors: ['#3498db', '#f1c40f', '#2ecc71'],
    category: 'Compact',
    isNew: true,
  },
];

const CATEGORIES = ['All', 'Sedan', 'SUV', 'Sports', 'Compact'];

interface InquiryForm {
  name: string;
  email: string;
  phone: string;
  message: string;
}

const VehicleScreen: React.FC<{ navigation: any }> = ({ navigation }) => {
  const dispatch = useDispatch();
  const { vehicles } = useSelector((state: RootState) => state.app);
  const [selectedCategory, setSelectedCategory] = useState('All');
  const [selectedVehicle, setSelectedVehicle] = useState<Vehicle | null>(null);
  const [showInquiryModal, setShowInquiryModal] = useState(false);
  const [inquiryForm, setInquiryForm] = useState<InquiryForm>({
    name: '',
    email: '',
    phone: '',
    message: '',
  });

  useEffect(() => {
    if (vehicles.length === 0) {
      dispatch(setVehicles(MOCK_VEHICLES));
    }
  }, [dispatch, vehicles.length]);

  const displayVehicles = vehicles.length > 0 ? vehicles : MOCK_VEHICLES;

  const filteredVehicles =
    selectedCategory === 'All'
      ? displayVehicles
      : displayVehicles.filter((v) => v.category === selectedCategory);

  const handleVehiclePress = (vehicle: Vehicle) => {
    setSelectedVehicle(vehicle);
  };

  const handleInquirySubmit = () => {
    if (!inquiryForm.name || !inquiryForm.email || !inquiryForm.phone) {
      Alert.alert('Missing Fields', 'Please fill in all required fields.');
      return;
    }
    Alert.alert(
      'Inquiry Submitted',
      'Thank you! Our team will contact you within 24 hours.',
      [{ text: 'OK', onPress: () => setShowInquiryModal(false) }]
    );
  };

  // Vehicle detail view
  if (selectedVehicle) {
    return (
      <View style={styles.container}>
        <Header
          title={selectedVehicle.name}
          showBack
          onBack={() => setSelectedVehicle(null)}
        />
        <ScrollView showsVerticalScrollIndicator={false}>
          {/* Vehicle image placeholder */}
          <View style={styles.vehicleHero}>
            <Ionicons name="car-sport" size={120} color="#00d4ff" />
            <View style={styles.heroOverlay}>
              <Text style={styles.heroModel}>{selectedVehicle.model}</Text>
              <Text style={styles.heroName}>{selectedVehicle.name}</Text>
            </View>
          </View>

          <View style={styles.detailContent}>
            {/* Price */}
            <View style={styles.priceRow}>
              <Text style={styles.detailPrice}>
                ${selectedVehicle.price.toLocaleString()}
              </Text>
              {selectedVehicle.isNew && (
                <View style={styles.newBadge}>
                  <Text style={styles.newBadgeText}>NEW MODEL</Text>
                </View>
              )}
            </View>

            {/* Specifications grid */}
            <Text style={styles.sectionLabel}>Specifications</Text>
            <View style={styles.specsGrid}>
              {Object.entries(selectedVehicle.specs).map(([key, value]) => (
                <Card key={key} style={styles.specCard}>
                  <Text style={styles.specKey}>
                    {key.replace(/([A-Z])/g, ' $1').toUpperCase()}
                  </Text>
                  <Text style={styles.specValue}>{value}</Text>
                </Card>
              ))}
            </View>

            {/* Color options */}
            <Text style={styles.sectionLabel}>Available Colors</Text>
            <View style={styles.colorRow}>
              {selectedVehicle.colors.map((color, index) => (
                <View
                  key={index}
                  style={[styles.colorSwatch, { backgroundColor: color }]}
                />
              ))}
            </View>

            {/* Action buttons */}
            <Button
              title="Request Test Drive"
              onPress={() => setShowInquiryModal(true)}
              fullWidth
              size="large"
              style={styles.primaryButton}
            />
            <Button
              title="Compare Models"
              onPress={() => {}}
              variant="outline"
              fullWidth
              size="large"
            />
          </View>
        </ScrollView>

        {/* Inquiry Modal */}
        <Modal
          visible={showInquiryModal}
          animationType="slide"
          transparent
          onRequestClose={() => setShowInquiryModal(false)}
        >
          <View style={styles.modalOverlay}>
            <View style={styles.modalContent}>
              <View style={styles.modalHeader}>
                <Text style={styles.modalTitle}>Request Test Drive</Text>
                <TouchableOpacity onPress={() => setShowInquiryModal(false)}>
                  <Ionicons name="close" size={24} color="#8a8a9a" />
                </TouchableOpacity>
              </View>

              {(['name', 'email', 'phone', 'message'] as const).map((field) => (
                <View key={field} style={styles.modalInputGroup}>
                  <Text style={styles.modalLabel}>
                    {field.charAt(0).toUpperCase() + field.slice(1)}
                    {field !== 'message' ? ' *' : ''}
                  </Text>
                  <TextInput
                    style={[
                      styles.modalInput,
                      field === 'message' && styles.modalTextArea,
                    ]}
                    value={inquiryForm[field]}
                    onChangeText={(text) =>
                      setInquiryForm((prev) => ({ ...prev, [field]: text }))
                    }
                    placeholder={`Enter your ${field}`}
                    placeholderTextColor="#4a4a5a"
                    multiline={field === 'message'}
                    numberOfLines={field === 'message' ? 3 : 1}
                    keyboardType={
                      field === 'email'
                        ? 'email-address'
                        : field === 'phone'
                        ? 'phone-pad'
                        : 'default'
                    }
                  />
                </View>
              ))}

              <Button
                title="Submit Inquiry"
                onPress={handleInquirySubmit}
                fullWidth
                size="large"
                style={{ marginTop: 8 }}
              />
            </View>
          </View>
        </Modal>
      </View>
    );
  }

  // Vehicle catalog view
  return (
    <View style={styles.container}>
      <Header title="Vehicle Showroom" subtitle="Explore our lineup" />

      {/* Category filter */}
      <ScrollView
        horizontal
        showsHorizontalScrollIndicator={false}
        style={styles.categoryScroll}
        contentContainerStyle={styles.categoryContent}
      >
        {CATEGORIES.map((cat) => (
          <TouchableOpacity
            key={cat}
            style={[
              styles.categoryChip,
              selectedCategory === cat && styles.categoryChipActive,
            ]}
            onPress={() => setSelectedCategory(cat)}
          >
            <Text
              style={[
                styles.categoryChipText,
                selectedCategory === cat && styles.categoryChipTextActive,
              ]}
            >
              {cat}
            </Text>
          </TouchableOpacity>
        ))}
      </ScrollView>

      <FlatList
        data={filteredVehicles}
        keyExtractor={(item) => item.id}
        renderItem={({ item }) => (
          <View style={styles.horizontalCardWrapper}>
            <VehicleCard
              vehicle={item}
              onPress={handleVehiclePress}
              horizontal
            />
          </View>
        )}
        contentContainerStyle={styles.listContent}
        showsVerticalScrollIndicator={false}
      />
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#0a0a0f',
  },
  categoryScroll: {
    maxHeight: 52,
  },
  categoryContent: {
    paddingHorizontal: 16,
    paddingVertical: 10,
    gap: 8,
  },
  categoryChip: {
    paddingHorizontal: 16,
    paddingVertical: 6,
    borderRadius: 20,
    borderWidth: 1,
    borderColor: '#2a2a3e',
    backgroundColor: '#12121f',
  },
  categoryChipActive: {
    backgroundColor: '#00d4ff',
    borderColor: '#00d4ff',
  },
  categoryChipText: {
    color: '#8a8a9a',
    fontSize: 13,
    fontWeight: '600',
  },
  categoryChipTextActive: {
    color: '#0a0a0f',
  },
  listContent: {
    padding: 16,
  },
  horizontalCardWrapper: {
    marginBottom: 8,
  },
  // Detail view styles
  vehicleHero: {
    height: 260,
    backgroundColor: '#0d0d1a',
    alignItems: 'center',
    justifyContent: 'center',
    position: 'relative',
  },
  heroOverlay: {
    position: 'absolute',
    bottom: 16,
    left: 20,
  },
  heroModel: {
    color: '#00d4ff',
    fontSize: 12,
    fontWeight: '700',
    letterSpacing: 2,
    textTransform: 'uppercase',
  },
  heroName: {
    color: '#ffffff',
    fontSize: 28,
    fontWeight: '800',
  },
  detailContent: {
    padding: 20,
  },
  priceRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 20,
  },
  detailPrice: {
    color: '#ffffff',
    fontSize: 30,
    fontWeight: '800',
  },
  newBadge: {
    backgroundColor: '#00d4ff',
    borderRadius: 6,
    paddingHorizontal: 10,
    paddingVertical: 4,
  },
  newBadgeText: {
    color: '#0a0a0f',
    fontSize: 11,
    fontWeight: '800',
    letterSpacing: 1,
  },
  sectionLabel: {
    color: '#ffffff',
    fontSize: 16,
    fontWeight: '700',
    marginBottom: 12,
    marginTop: 8,
  },
  specsGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: 10,
    marginBottom: 20,
  },
  specCard: {
    padding: 12,
    minWidth: '30%',
    flex: 1,
  },
  specKey: {
    color: '#4a4a5a',
    fontSize: 9,
    fontWeight: '700',
    letterSpacing: 1,
    marginBottom: 4,
  },
  specValue: {
    color: '#00d4ff',
    fontSize: 14,
    fontWeight: '700',
  },
  colorRow: {
    flexDirection: 'row',
    gap: 10,
    marginBottom: 24,
  },
  colorSwatch: {
    width: 32,
    height: 32,
    borderRadius: 16,
    borderWidth: 2,
    borderColor: '#2a2a3e',
  },
  primaryButton: {
    marginBottom: 12,
  },
  // Modal styles
  modalOverlay: {
    flex: 1,
    backgroundColor: 'rgba(0,0,0,0.7)',
    justifyContent: 'flex-end',
  },
  modalContent: {
    backgroundColor: '#12121f',
    borderTopLeftRadius: 24,
    borderTopRightRadius: 24,
    padding: 24,
    borderTopWidth: 1,
    borderColor: '#1e1e35',
  },
  modalHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 20,
  },
  modalTitle: {
    color: '#ffffff',
    fontSize: 20,
    fontWeight: '700',
  },
  modalInputGroup: {
    marginBottom: 14,
  },
  modalLabel: {
    color: '#8a8a9a',
    fontSize: 13,
    fontWeight: '600',
    marginBottom: 6,
  },
  modalInput: {
    backgroundColor: '#0d0d1a',
    borderRadius: 10,
    borderWidth: 1,
    borderColor: '#2a2a3e',
    color: '#ffffff',
    fontSize: 15,
    paddingHorizontal: 14,
    paddingVertical: 12,
  },
  modalTextArea: {
    height: 80,
    textAlignVertical: 'top',
  },
});

export default VehicleScreen;
