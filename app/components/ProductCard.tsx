import React from 'react';
import {
  View,
  Text,
  StyleSheet,
  TouchableOpacity,
  Image,
} from 'react-native';
import Colors from '../theme/colors';
import { Product } from '../store/appSlice';

interface ProductCardProps {
  product: Product;
  onPress: (product: Product) => void;
  onAddToCart: (product: Product) => void;
}

// Card component for displaying automotive merchandise and accessories
const ProductCard: React.FC<ProductCardProps> = ({
  product,
  onPress,
  onAddToCart,
}) => {
  const formattedPrice = new Intl.NumberFormat('en-US', {
    style: 'currency',
    currency: 'USD',
  }).format(product.price);

  return (
    <TouchableOpacity
      style={styles.container}
      onPress={() => onPress(product)}
      activeOpacity={0.85}
      accessibilityRole="button"
      accessibilityLabel={`View ${product.name} product`}
    >
      {/* Product image */}
      <View style={styles.imageContainer}>
        {product.imageUrl ? (
          <Image
            source={{ uri: product.imageUrl }}
            style={styles.image}
            resizeMode="cover"
          />
        ) : (
          <View style={styles.imagePlaceholder}>
            <Text style={styles.placeholderText}>
              {product.category.substring(0, 3).toUpperCase()}
            </Text>
          </View>
        )}
        {product.stock === 0 && (
          <View style={styles.outOfStockOverlay}>
            <Text style={styles.outOfStockText}>Out of Stock</Text>
          </View>
        )}
      </View>

      {/* Product info */}
      <View style={styles.infoContainer}>
        <Text style={styles.category}>{product.category}</Text>
        <Text style={styles.name} numberOfLines={2}>
          {product.name}
        </Text>
        <Text style={styles.description} numberOfLines={2}>
          {product.description}
        </Text>

        <View style={styles.footer}>
          <Text style={styles.price}>{formattedPrice}</Text>
          <TouchableOpacity
            style={[
              styles.addButton,
              product.stock === 0 && styles.addButtonDisabled,
            ]}
            onPress={() => onAddToCart(product)}
            disabled={product.stock === 0}
            accessibilityLabel={`Add ${product.name} to cart`}
          >
            <Text
              style={[
                styles.addButtonText,
                product.stock === 0 && styles.addButtonTextDisabled,
              ]}
            >
              +
            </Text>
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
    borderWidth: 1,
    borderColor: Colors.border,
    overflow: 'hidden',
    flex: 1,
    margin: 6,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.18,
    shadowRadius: 4,
    elevation: 3,
  },
  imageContainer: {
    height: 130,
    backgroundColor: Colors.bgInset,
    position: 'relative',
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
  placeholderText: {
    color: Colors.accentDim,
    fontSize: 20,
    fontWeight: '200',
    letterSpacing: 3,
  },
  outOfStockOverlay: {
    ...StyleSheet.absoluteFillObject,
    backgroundColor: 'rgba(14,14,15,0.7)',
    alignItems: 'center',
    justifyContent: 'center',
  },
  outOfStockText: {
    color: Colors.danger,
    fontWeight: '600',
    fontSize: 12,
    letterSpacing: 0.5,
  },
  infoContainer: {
    padding: 12,
  },
  category: {
    color: Colors.accentDim,
    fontSize: 9,
    fontWeight: '600',
    letterSpacing: 1.5,
    textTransform: 'uppercase',
    marginBottom: 4,
  },
  name: {
    color: Colors.textPrimary,
    fontSize: 14,
    fontWeight: '600',
    marginBottom: 4,
    lineHeight: 19,
  },
  description: {
    color: Colors.textDim,
    fontSize: 11,
    lineHeight: 15,
    marginBottom: 10,
  },
  footer: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  price: {
    color: Colors.textPrimary,
    fontSize: 15,
    fontWeight: '700',
  },
  addButton: {
    backgroundColor: Colors.accent,
    borderRadius: 6,
    width: 30,
    height: 30,
    alignItems: 'center',
    justifyContent: 'center',
  },
  addButtonDisabled: {
    backgroundColor: Colors.bgElevated,
  },
  addButtonText: {
    color: Colors.bgPrimary,
    fontSize: 20,
    lineHeight: 22,
    fontWeight: '300',
  },
  addButtonTextDisabled: {
    color: Colors.textDim,
  },
});

export default ProductCard;
