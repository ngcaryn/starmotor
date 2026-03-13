import React from 'react';
import {
  View,
  Text,
  StyleSheet,
  TouchableOpacity,
  Image,
  Dimensions,
} from 'react-native';
import Colors from '../theme/colors';
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
            <Text style={styles.placeholderInitials}>
              {vehicle.model.substring(0, 2).toUpperCase()}
            </Text>
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

        {/* Key specs — label prefix replaces icons */}
        <View style={styles.specsRow}>
          {vehicle.specs.range && (
            <View style={styles.specItem}>
              <Text style={styles.specText}>Range  {vehicle.specs.range}</Text>
            </View>
          )}
          {vehicle.specs.acceleration && (
            <View style={styles.specItem}>
              <Text style={styles.specText}>0–60  {vehicle.specs.acceleration}</Text>
            </View>
          )}
          {vehicle.specs.horsepower && (
            <View style={styles.specItem}>
              <Text style={styles.specText}>HP  {vehicle.specs.horsepower}</Text>
            </View>
          )}
        </View>

        <View style={styles.footer}>
          <Text style={styles.price}>{formattedPrice}</Text>
          <TouchableOpacity style={styles.exploreButton} onPress={() => onPress(vehicle)}>
            <Text style={styles.exploreText}>Explore  ›</Text>
          </TouchableOpacity>
        </View>
      </View>
    </TouchableOpacity>
  );
};

const styles = StyleSheet.create({
  container: {
    backgroundColor: Colors.bgCard,
    borderRadius: 10,
    marginVertical: 6,
    marginHorizontal: 4,
    borderWidth: 1,
    borderColor: Colors.border,
    overflow: 'hidden',
    width: width * 0.72,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.18,
    shadowRadius: 6,
    elevation: 4,
  },
  horizontalContainer: {
    flexDirection: 'row',
    width: '100%',
  },
  imageContainer: {
    height: 180,
    backgroundColor: Colors.bgInset,
    position: 'relative',
  },
  horizontalImage: {
    width: 140,
    height: 'auto' as any,
  },
  image: {
    width: '100%',
    height: '100%',
  },
  imagePlaceholder: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: Colors.bgInset,
  },
  placeholderInitials: {
    color: Colors.accentDim,
    fontSize: 36,
    fontWeight: '200',
    letterSpacing: 4,
  },
  newBadge: {
    position: 'absolute',
    top: 10,
    left: 10,
    backgroundColor: Colors.bgCard,
    borderRadius: 3,
    paddingHorizontal: 8,
    paddingVertical: 3,
    borderWidth: 1,
    borderColor: Colors.borderActive,
  },
  newBadgeText: {
    color: Colors.accent,
    fontSize: 9,
    fontWeight: '700',
    letterSpacing: 1.5,
  },
  infoContainer: {
    padding: 14,
  },
  model: {
    color: Colors.accentDim,
    fontSize: 10,
    fontWeight: '500',
    letterSpacing: 2,
    textTransform: 'uppercase',
    marginBottom: 2,
  },
  name: {
    color: Colors.textPrimary,
    fontSize: 17,
    fontWeight: '600',
    marginBottom: 10,
  },
  specsRow: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: 6,
    marginBottom: 12,
  },
  specItem: {
    backgroundColor: Colors.bgInset,
    paddingHorizontal: 8,
    paddingVertical: 4,
    borderRadius: 4,
    borderWidth: 1,
    borderColor: Colors.borderDark,
  },
  specText: {
    color: Colors.textSecondary,
    fontSize: 11,
    fontWeight: '400',
  },
  footer: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  price: {
    color: Colors.textPrimary,
    fontSize: 19,
    fontWeight: '700',
  },
  exploreButton: {
    paddingVertical: 4,
  },
  exploreText: {
    color: Colors.accent,
    fontSize: 13,
    fontWeight: '500',
    letterSpacing: 0.3,
  },
});

export default VehicleCard;
