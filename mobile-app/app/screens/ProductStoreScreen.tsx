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
import { useSelector, useDispatch } from 'react-redux';
import { RootState } from '../store/store';
import {
  setProducts,
  addToCart,
  removeFromCart,
  updateCartQuantity,
} from '../store/appSlice';
import { Product } from '../store/appSlice';
import ProductCard from '../components/ProductCard';
import Header from '../components/Header';
import Button from '../components/Button';

const MOCK_PRODUCTS: Product[] = [
  {
    id: 'p1',
    name: 'StarMotor Carbon Fiber Hood Badge',
    description: 'Premium carbon fiber hood badge with UV-resistant coating.',
    price: 129.99,
    imageUrl: '',
    category: 'Accessories',
    stock: 50,
  },
  {
    id: 'p2',
    name: 'Performance Brake Upgrade Kit',
    description: 'Track-ready brake kit for enhanced stopping performance.',
    price: 1299.00,
    imageUrl: '',
    category: 'Performance',
    stock: 12,
  },
  {
    id: 'p3',
    name: 'StarMotor Branded Apparel Set',
    description: 'Premium polo shirt and cap set with embroidered logo.',
    price: 89.99,
    imageUrl: '',
    category: 'Apparel',
    stock: 100,
  },
  {
    id: 'p4',
    name: 'Custom Floor Mat Set',
    description: 'Laser-cut floor mats with anti-slip backing.',
    price: 249.00,
    imageUrl: '',
    category: 'Interior',
    stock: 35,
  },
  {
    id: 'p5',
    name: 'Smart Dashcam Pro 4K',
    description: '4K dashcam with night vision and parking mode.',
    price: 349.00,
    imageUrl: '',
    category: 'Electronics',
    stock: 0,
  },
  {
    id: 'p6',
    name: 'Alloy Wheel Set (20")',
    description: 'Forged alloy wheels in gloss black finish.',
    price: 2499.00,
    imageUrl: '',
    category: 'Wheels',
    stock: 8,
  },
];

const CATEGORIES = ['All', 'Accessories', 'Performance', 'Apparel', 'Interior', 'Electronics', 'Wheels'];

const ProductStoreScreen: React.FC<{ navigation: any }> = ({ navigation }) => {
  const dispatch = useDispatch();
  const { products, cart } = useSelector((state: RootState) => state.app);
  const [selectedCategory, setSelectedCategory] = useState('All');
  const [showCart, setShowCart] = useState(false);

  useEffect(() => {
    if (products.length === 0) {
      dispatch(setProducts(MOCK_PRODUCTS));
    }
  }, [dispatch, products.length]);

  const displayProducts = products.length > 0 ? products : MOCK_PRODUCTS;
  const filtered =
    selectedCategory === 'All'
      ? displayProducts
      : displayProducts.filter((p) => p.category === selectedCategory);

  const cartTotal = cart.reduce(
    (sum, item) => sum + item.product.price * item.quantity,
    0
  );
  const cartCount = cart.reduce((sum, item) => sum + item.quantity, 0);

  const handleAddToCart = (product: Product) => {
    dispatch(addToCart(product));
    Alert.alert('Added to Cart', `${product.name} has been added to your cart.`);
  };

  const handleCheckout = () => {
    if (cart.length === 0) {
      Alert.alert('Empty Cart', 'Please add items to your cart first.');
      return;
    }
    Alert.alert(
      'Checkout',
      `Total: $${cartTotal.toFixed(2)}\n\nProceed to payment?`,
      [
        { text: 'Cancel', style: 'cancel' },
        {
          text: 'Checkout',
          onPress: () => Alert.alert('Payment', 'Payment integration coming soon.'),
        },
      ]
    );
  };

  // Cart view
  if (showCart) {
    return (
      <View style={styles.container}>
        <Header
          title="My Cart"
          showBack
          onBack={() => setShowCart(false)}
          subtitle={`${cartCount} item${cartCount !== 1 ? 's' : ''}`}
        />
        {cart.length === 0 ? (
          <View style={styles.emptyState}>
            <Ionicons name="cart-outline" size={64} color="#2a2a3e" />
            <Text style={styles.emptyTitle}>Your cart is empty</Text>
            <Text style={styles.emptySubtext}>Add items from the store</Text>
            <Button
              title="Browse Store"
              onPress={() => setShowCart(false)}
              style={{ marginTop: 24 }}
            />
          </View>
        ) : (
          <View style={styles.cartContainer}>
            <FlatList
              data={cart}
              keyExtractor={(item) => item.product.id}
              renderItem={({ item }) => (
                <View style={styles.cartItem}>
                  <View style={styles.cartItemInfo}>
                    <Text style={styles.cartItemName} numberOfLines={2}>
                      {item.product.name}
                    </Text>
                    <Text style={styles.cartItemPrice}>
                      ${item.product.price.toFixed(2)}
                    </Text>
                  </View>
                  <View style={styles.cartItemActions}>
                    <TouchableOpacity
                      onPress={() =>
                        item.quantity > 1
                          ? dispatch(
                              updateCartQuantity({
                                productId: item.product.id,
                                quantity: item.quantity - 1,
                              })
                            )
                          : dispatch(removeFromCart(item.product.id))
                      }
                      style={styles.quantityButton}
                    >
                      <Ionicons name="remove" size={16} color="#00d4ff" />
                    </TouchableOpacity>
                    <Text style={styles.quantityText}>{item.quantity}</Text>
                    <TouchableOpacity
                      onPress={() =>
                        dispatch(
                          updateCartQuantity({
                            productId: item.product.id,
                            quantity: item.quantity + 1,
                          })
                        )
                      }
                      style={styles.quantityButton}
                    >
                      <Ionicons name="add" size={16} color="#00d4ff" />
                    </TouchableOpacity>
                    <TouchableOpacity
                      onPress={() => dispatch(removeFromCart(item.product.id))}
                      style={styles.removeButton}
                    >
                      <Ionicons name="trash-outline" size={16} color="#ff4d6d" />
                    </TouchableOpacity>
                  </View>
                </View>
              )}
              contentContainerStyle={styles.cartList}
            />
            <View style={styles.cartFooter}>
              <View style={styles.totalRow}>
                <Text style={styles.totalLabel}>Total</Text>
                <Text style={styles.totalAmount}>
                  ${cartTotal.toFixed(2)}
                </Text>
              </View>
              <Button
                title="Proceed to Checkout"
                onPress={handleCheckout}
                fullWidth
                size="large"
              />
            </View>
          </View>
        )}
      </View>
    );
  }

  // Store catalog view
  return (
    <View style={styles.container}>
      <Header
        title="Product Store"
        subtitle="Accessories & Merchandise"
        rightIcon="cart-outline"
        onRightPress={() => setShowCart(true)}
      />

      {cartCount > 0 && (
        <TouchableOpacity
          style={styles.cartBadge}
          onPress={() => setShowCart(true)}
        >
          <Ionicons name="cart" size={16} color="#0a0a0f" />
          <Text style={styles.cartBadgeText}>{cartCount} items · ${cartTotal.toFixed(2)}</Text>
        </TouchableOpacity>
      )}

      {/* Category filter */}
      <FlatList
        horizontal
        data={CATEGORIES}
        keyExtractor={(item) => item}
        renderItem={({ item }) => (
          <TouchableOpacity
            style={[
              styles.categoryChip,
              selectedCategory === item && styles.categoryChipActive,
            ]}
            onPress={() => setSelectedCategory(item)}
          >
            <Text
              style={[
                styles.categoryChipText,
                selectedCategory === item && styles.categoryChipTextActive,
              ]}
            >
              {item}
            </Text>
          </TouchableOpacity>
        )}
        contentContainerStyle={styles.categoryContent}
        showsHorizontalScrollIndicator={false}
        style={styles.categoryScroll}
      />

      <FlatList
        data={filtered}
        keyExtractor={(item) => item.id}
        numColumns={2}
        renderItem={({ item }) => (
          <ProductCard
            product={item}
            onPress={() => {}}
            onAddToCart={handleAddToCart}
          />
        )}
        contentContainerStyle={styles.productList}
        showsVerticalScrollIndicator={false}
        columnWrapperStyle={styles.columnWrapper}
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
    paddingHorizontal: 14,
    paddingVertical: 6,
    borderRadius: 20,
    borderWidth: 1,
    borderColor: '#2a2a3e',
    backgroundColor: '#12121f',
    marginRight: 8,
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
  productList: {
    padding: 10,
  },
  columnWrapper: {
    justifyContent: 'space-between',
  },
  cartBadge: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 6,
    backgroundColor: '#00d4ff',
    marginHorizontal: 16,
    marginBottom: 4,
    marginTop: 4,
    borderRadius: 8,
    padding: 10,
  },
  cartBadgeText: {
    color: '#0a0a0f',
    fontWeight: '700',
    fontSize: 13,
  },
  // Cart view styles
  cartContainer: {
    flex: 1,
  },
  cartList: {
    padding: 16,
  },
  cartItem: {
    backgroundColor: '#12121f',
    borderRadius: 12,
    padding: 14,
    marginBottom: 10,
    borderWidth: 1,
    borderColor: '#1e1e35',
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  cartItemInfo: {
    flex: 1,
    marginRight: 12,
  },
  cartItemName: {
    color: '#ffffff',
    fontSize: 14,
    fontWeight: '600',
    marginBottom: 4,
  },
  cartItemPrice: {
    color: '#00d4ff',
    fontSize: 15,
    fontWeight: '700',
  },
  cartItemActions: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 8,
  },
  quantityButton: {
    width: 28,
    height: 28,
    borderRadius: 6,
    borderWidth: 1,
    borderColor: '#2a2a3e',
    alignItems: 'center',
    justifyContent: 'center',
  },
  quantityText: {
    color: '#ffffff',
    fontSize: 14,
    fontWeight: '700',
    minWidth: 20,
    textAlign: 'center',
  },
  removeButton: {
    width: 28,
    height: 28,
    borderRadius: 6,
    borderWidth: 1,
    borderColor: '#ff4d6d33',
    alignItems: 'center',
    justifyContent: 'center',
    marginLeft: 4,
  },
  cartFooter: {
    padding: 20,
    borderTopWidth: 1,
    borderTopColor: '#1e1e35',
    backgroundColor: '#12121f',
  },
  totalRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 16,
  },
  totalLabel: {
    color: '#8a8a9a',
    fontSize: 16,
  },
  totalAmount: {
    color: '#ffffff',
    fontSize: 24,
    fontWeight: '800',
  },
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
  },
});

export default ProductStoreScreen;
