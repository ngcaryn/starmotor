import React, { useState, useEffect } from 'react';
import {
  View, Text, StyleSheet, FlatList, TouchableOpacity, Alert, ScrollView,
} from 'react-native';
import { useSelector, useDispatch } from 'react-redux';
import { RootState } from '../store/store';
import { setProducts, addToCart } from '../store/appSlice';
import { Product } from '../store/appSlice';
import ProductCard from '../components/ProductCard';
import Header from '../components/Header';
import Card from '../components/Card';
import Colors from '../theme/colors';

const MOCK_PRODUCTS: Product[] = [
  { id: '1', name: 'StarMotor Performance Jacket', category: 'Apparel', price: 249, description: 'Premium motorsport jacket with titanium inlays.', imageUrl: '', stock: 15 },
  { id: '2', name: 'Carbon Fiber Phone Mount', category: 'Accessories', price: 89, description: 'Aerospace-grade carbon fiber dash mount.', imageUrl: '', stock: 42 },
  { id: '3', name: 'StarX Pro Scale Model (1:18)', category: 'Collectibles', price: 199, description: 'Die-cast precision scale replica.', imageUrl: '', stock: 8 },
  { id: '4', name: 'Wireless Charging Pad', category: 'Accessories', price: 59, description: '15W fast wireless charging, vehicle logo finish.', imageUrl: '', stock: 0 },
  { id: '5', name: 'StarMotor Titanium Key Chain', category: 'Accessories', price: 35, description: 'Solid titanium CNC-machined key fob.', imageUrl: '', stock: 100 },
  { id: '6', name: 'StarGT Poster Set', category: 'Collectibles', price: 79, description: 'Limited-edition art print set.', imageUrl: '', stock: 25 },
];

const CATEGORIES = ['All', 'Apparel', 'Accessories', 'Collectibles'];

const ProductStoreScreen: React.FC<{ navigation: any }> = ({ navigation }) => {
  const dispatch = useDispatch();
  const { products, cart } = useSelector((state: RootState) => state.app);
  const [selectedCategory, setSelectedCategory] = useState('All');
  const [showCart, setShowCart] = useState(false);

  useEffect(() => {
    if (products.length === 0) dispatch(setProducts(MOCK_PRODUCTS));
  }, [dispatch, products.length]);

  const displayProducts = products.length > 0 ? products : MOCK_PRODUCTS;
  const filtered = selectedCategory === 'All' ? displayProducts : displayProducts.filter((p) => p.category === selectedCategory);
  const cartTotal = cart.reduce((sum, item) => sum + item.product.price * item.quantity, 0);
  const cartCount = cart.reduce((sum, item) => sum + item.quantity, 0);

  const handleAddToCart = (product: Product) => {
    dispatch(addToCart(product));
    Alert.alert('Added', `${product.name} added to cart.`);
  };

  if (showCart) {
    return (
      <View style={styles.container}>
        <Header title="Cart" showBack onBack={() => setShowCart(false)} />
        <ScrollView contentContainerStyle={styles.cartContent}>
          {cart.length === 0 ? (
            <View style={styles.emptyCart}>
              <Text style={styles.emptyCartText}>Your cart is empty</Text>
            </View>
          ) : (
            <>
              {cart.map((item) => (
                <Card key={item.product.id} style={styles.cartItem}>
                  <View style={styles.cartItemRow}>
                    <View style={{ flex: 1 }}>
                      <Text style={styles.cartItemName}>{item.product.name}</Text>
                      <Text style={styles.cartItemPrice}>${item.product.price.toLocaleString()} × {item.quantity}</Text>
                    </View>
                    <Text style={styles.cartItemTotal}>${(item.product.price * item.quantity).toLocaleString()}</Text>
                  </View>
                </Card>
              ))}
              <Card style={styles.orderSummary}>
                <View style={styles.summaryRow}>
                  <Text style={styles.summaryLabel}>Order Total</Text>
                  <Text style={styles.summaryValue}>${cartTotal.toLocaleString()}</Text>
                </View>
              </Card>
              <TouchableOpacity style={styles.checkoutButton} onPress={() => Alert.alert('Checkout', 'Redirecting to payment...')}>
                <Text style={styles.checkoutText}>Proceed to Checkout</Text>
              </TouchableOpacity>
            </>
          )}
        </ScrollView>
      </View>
    );
  }

  return (
    <View style={styles.container}>
      <Header title="Store" subtitle="Gear & Accessories" rightLabel={cartCount > 0 ? `Cart (${cartCount})` : 'Cart'} onRightPress={() => setShowCart(true)} />
      <ScrollView horizontal showsHorizontalScrollIndicator={false} style={styles.categoryScroll} contentContainerStyle={styles.categoryContent}>
        {CATEGORIES.map((cat) => (
          <TouchableOpacity key={cat} style={[styles.chip, selectedCategory === cat && styles.chipActive]} onPress={() => setSelectedCategory(cat)}>
            <Text style={[styles.chipText, selectedCategory === cat && styles.chipTextActive]}>{cat}</Text>
          </TouchableOpacity>
        ))}
      </ScrollView>
      <FlatList
        data={filtered} keyExtractor={(item) => item.id} numColumns={2}
        renderItem={({ item }) => <ProductCard product={item} onPress={() => {}} onAddToCart={handleAddToCart} />}
        contentContainerStyle={styles.listContent} showsVerticalScrollIndicator={false}
      />
    </View>
  );
};

const styles = StyleSheet.create({
  container: { flex: 1, backgroundColor: Colors.bgPrimary },
  categoryScroll: { maxHeight: 52 },
  categoryContent: { paddingHorizontal: 16, paddingVertical: 10, gap: 8 },
  chip: { paddingHorizontal: 16, paddingVertical: 6, borderRadius: 4, borderWidth: 1, borderColor: Colors.border, backgroundColor: Colors.bgCard },
  chipActive: { borderColor: Colors.borderActive, backgroundColor: Colors.bgElevated },
  chipText: { color: Colors.textSecondary, fontSize: 12, fontWeight: '500' },
  chipTextActive: { color: Colors.accent },
  listContent: { padding: 10 },
  cartContent: { padding: 16 },
  cartItem: { marginBottom: 4 },
  cartItemRow: { flexDirection: 'row', justifyContent: 'space-between', alignItems: 'center' },
  cartItemName: { color: Colors.textPrimary, fontSize: 14, fontWeight: '500', marginBottom: 4 },
  cartItemPrice: { color: Colors.textSecondary, fontSize: 12 },
  cartItemTotal: { color: Colors.textPrimary, fontSize: 16, fontWeight: '600' },
  orderSummary: { marginTop: 8 },
  summaryRow: { flexDirection: 'row', justifyContent: 'space-between' },
  summaryLabel: { color: Colors.textSecondary, fontSize: 14 },
  summaryValue: { color: Colors.textPrimary, fontSize: 18, fontWeight: '700' },
  checkoutButton: { backgroundColor: Colors.accent, borderRadius: 6, padding: 16, alignItems: 'center', marginTop: 16 },
  checkoutText: { color: Colors.bgPrimary, fontSize: 15, fontWeight: '600', letterSpacing: 0.5 },
  emptyCart: { flex: 1, alignItems: 'center', justifyContent: 'center', paddingTop: 80 },
  emptyCartText: { color: Colors.textDim, fontSize: 15, fontWeight: '400' },
});

export default ProductStoreScreen;
