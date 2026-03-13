import apiClient from './api';
import { Product } from '../store/appSlice';

export interface Order {
  id: string;
  items: Array<{ productId: string; quantity: number; price: number }>;
  total: number;
  status: 'pending' | 'processing' | 'shipped' | 'delivered' | 'cancelled';
  createdAt: string;
  shippingAddress: Address;
  trackingNumber?: string;
}

export interface Address {
  id?: string;
  name: string;
  street: string;
  city: string;
  state: string;
  zipCode: string;
  country: string;
  phone: string;
  isDefault?: boolean;
}

export interface PlaceOrderPayload {
  items: Array<{ productId: string; quantity: number }>;
  shippingAddressId: string;
  paymentMethod: string;
}

// Fetch product catalog with optional category filter
export const fetchProducts = async (category?: string): Promise<Product[]> => {
  const response = await apiClient.get<Product[]>('/products', {
    params: category ? { category } : undefined,
  });
  return response.data;
};

// Fetch single product details
export const fetchProductById = async (id: string): Promise<Product> => {
  const response = await apiClient.get<Product>(`/products/${id}`);
  return response.data;
};

// Place a new order
export const placeOrder = async (
  payload: PlaceOrderPayload
): Promise<Order> => {
  const response = await apiClient.post<Order>('/orders', payload);
  return response.data;
};

// Retrieve order history for the authenticated user
export const fetchOrders = async (): Promise<Order[]> => {
  const response = await apiClient.get<Order[]>('/orders');
  return response.data;
};

// Fetch a specific order by ID
export const fetchOrderById = async (orderId: string): Promise<Order> => {
  const response = await apiClient.get<Order>(`/orders/${orderId}`);
  return response.data;
};

// Fetch saved shipping addresses
export const fetchAddresses = async (): Promise<Address[]> => {
  const response = await apiClient.get<Address[]>('/user/addresses');
  return response.data;
};

// Add a new shipping address
export const addAddress = async (
  address: Omit<Address, 'id'>
): Promise<Address> => {
  const response = await apiClient.post<Address>('/user/addresses', address);
  return response.data;
};

// Track a shipment by tracking number
export const trackShipment = async (
  trackingNumber: string
): Promise<{ status: string; events: Array<{ date: string; location: string; description: string }> }> => {
  const response = await apiClient.get(`/orders/track/${trackingNumber}`);
  return response.data;
};
