import React from 'react';
import {
  View,
  Text,
  StyleSheet,
  TouchableOpacity,
  Image,
  Dimensions,
} from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { Vehicle } from '../store/appSlice';

interface VehicleCardProps {
  vehicle: Vehicle;
  onPress: (vehicle: Vehicle) => void;
  horizontal?: boolean;
}

const { width } = Dimensions.get('window');

// Card component for displaying vehicle information in the showroom
const VehicleCard: React.FC<VehicleCardProps> = ({
  vehicle,
  onPress,
  horizontal = false,
}) => {
  const formattedPrice = new Intl.NumberFormat('en-US', {
    style: 'currency',
    currency: 'USD',
    minimumFractionDigits: 0,
  }).format(vehicle.price);

  return (
    <TouchableOpacity
      style={[styles.container, horizontal && styles.horizontalContainer]}
      onPress={() => onPress(vehicle)}
      activeOpacity={0.85}
      accessibilityRole="button"
      accessibilityLabel={`View ${vehicle.name} details`}
    >
      {/* Vehicle image area */}
      <View style={[styles.imageContainer, horizontal && styles.horizontalImage]}>
        {vehicle.imageUrl ? (
          <Image
            source={{ uri: vehicle.imageUrl }}
            style={styles.image}
            resizeMode="cover"
          />
        ) : (
          <View style={styles.imagePlaceholder}>
            <Ionicons name="car-sport" size={48} color="#00d4ff" />
          </View>
        )}
        {vehicle.isNew && (
          <View style={styles.newBadge}>
            <Text style={styles.newBadgeText}>NEW</Text>
          </View>
        )}
      </View>

      {/* Vehicle info */}
      <View style={styles.infoContainer}>
        <Text style={styles.model}>{vehicle.model}</Text>
        <Text style={styles.name}>{vehicle.name}</Text>

        {/* Key specs */}
        <View style={styles.specsRow}>
          {vehicle.specs.range && (
            <View style={styles.specItem}>
              <Ionicons name="battery-charging" size={14} color="#00d4ff" />
              <Text style={styles.specText}>{vehicle.specs.range}</Text>
            </View>
          )}
          {vehicle.specs.acceleration && (
            <View style={styles.specItem}>
              <Ionicons name="speedometer" size={14} color="#00d4ff" />
              <Text style={styles.specText}>{vehicle.specs.acceleration}</Text>
            </View>
          )}
          {vehicle.specs.horsepower && (
            <View style={styles.specItem}>
              <Ionicons name="flash" size={14} color="#00d4ff" />
              <Text style={styles.specText}>{vehicle.specs.horsepower}</Text>
            </View>
          )}
        </View>

        <View style={styles.footer}>
          <Text style={styles.price}>{formattedPrice}</Text>
          <TouchableOpacity style={styles.inquireButton} onPress={() => onPress(vehicle)}>
            <Text style={styles.inquireText}>Explore</Text>
            <Ionicons name="arrow-forward" size={14} color="#00d4ff" />
          </TouchableOpacity>
        </View>
      </View>
    </TouchableOpacity>
  );
};

const styles = StyleSheet.create({
  container: {
    backgroundColor: '#12121f',
    borderRadius: 16,
    marginVertical: 8,
    marginHorizontal: 4,
    borderWidth: 1,
    borderColor: '#1e1e35',
    overflow: 'hidden',
    width: width * 0.72,
    shadowColor: '#00d4ff',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 8,
    elevation: 5,
  },
  horizontalContainer: {
    flexDirection: 'row',
    width: '100%',
  },
  imageContainer: {
    height: 180,
    backgroundColor: '#0d0d1a',
    position: 'relative',
  },
  horizontalImage: {
    width: 140,
    height: 'auto',
  },
  image: {
    width: '100%',
    height: '100%',
  },
  imagePlaceholder: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: '#0d0d1a',
  },
  newBadge: {
    position: 'absolute',
    top: 10,
    left: 10,
    backgroundColor: '#00d4ff',
    borderRadius: 4,
    paddingHorizontal: 8,
    paddingVertical: 3,
  },
  newBadgeText: {
    color: '#0a0a0f',
    fontSize: 10,
    fontWeight: '800',
    letterSpacing: 1,
  },
  infoContainer: {
    padding: 14,
  },
  model: {
    color: '#00d4ff',
    fontSize: 11,
    fontWeight: '600',
    letterSpacing: 1.5,
    textTransform: 'uppercase',
    marginBottom: 2,
  },
  name: {
    color: '#ffffff',
    fontSize: 18,
    fontWeight: '700',
    marginBottom: 10,
  },
  specsRow: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: 8,
    marginBottom: 12,
  },
  specItem: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 4,
    backgroundColor: '#0d0d1a',
    paddingHorizontal: 8,
    paddingVertical: 4,
    borderRadius: 6,
  },
  specText: {
    color: '#8a8a9a',
    fontSize: 12,
  },
  footer: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  price: {
    color: '#ffffff',
    fontSize: 20,
    fontWeight: '800',
  },
  inquireButton: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 4,
  },
  inquireText: {
    color: '#00d4ff',
    fontSize: 13,
    fontWeight: '600',
  },
});

export default VehicleCard;
