import { createSlice, PayloadAction } from '@reduxjs/toolkit';

// Vehicle types
export interface Vehicle {
  id: string;
  name: string;
  model: string;
  year: number;
  price: number;
  imageUrl: string;
  specs: {
    range?: string;
    acceleration?: string;
    topSpeed?: string;
    horsepower?: string;
    torque?: string;
    battery?: string;
  };
  colors: string[];
  category: string;
  isNew?: boolean;
}

// Product types
export interface Product {
  id: string;
  name: string;
  description: string;
  price: number;
  imageUrl: string;
  category: string;
  stock: number;
}

export interface CartItem {
  product: Product;
  quantity: number;
}

// Event types
export interface AppEvent {
  id: string;
  title: string;
  description: string;
  date: string;
  location: string;
  imageUrl: string;
  isRegistered: boolean;
}

// Rewards types
export interface RewardPoints {
  balance: number;
  totalEarned: number;
  lastCheckIn: string | null;
  streak: number;
}

// Settings types
export interface AppSettings {
  darkMode: boolean;
  notifications: boolean;
  language: string;
  currency: string;
}

interface AppState {
  vehicles: Vehicle[];
  products: Product[];
  cart: CartItem[];
  events: AppEvent[];
  rewards: RewardPoints;
  settings: AppSettings;
  loading: boolean;
  error: string | null;
}

const initialState: AppState = {
  vehicles: [],
  products: [],
  cart: [],
  events: [],
  rewards: {
    balance: 0,
    totalEarned: 0,
    lastCheckIn: null,
    streak: 0,
  },
  settings: {
    darkMode: true,
    notifications: true,
    language: 'en',
    currency: 'USD',
  },
  loading: false,
  error: null,
};

const appSlice = createSlice({
  name: 'app',
  initialState,
  reducers: {
    setVehicles(state, action: PayloadAction<Vehicle[]>) {
      state.vehicles = action.payload;
    },
    setProducts(state, action: PayloadAction<Product[]>) {
      state.products = action.payload;
    },
    setEvents(state, action: PayloadAction<AppEvent[]>) {
      state.events = action.payload;
    },
    addToCart(state, action: PayloadAction<Product>) {
      const existingItem = state.cart.find(
        (item) => item.product.id === action.payload.id
      );
      if (existingItem) {
        existingItem.quantity += 1;
      } else {
        state.cart.push({ product: action.payload, quantity: 1 });
      }
    },
    removeFromCart(state, action: PayloadAction<string>) {
      state.cart = state.cart.filter(
        (item) => item.product.id !== action.payload
      );
    },
    updateCartQuantity(
      state,
      action: PayloadAction<{ productId: string; quantity: number }>
    ) {
      const item = state.cart.find(
        (i) => i.product.id === action.payload.productId
      );
      if (item) {
        item.quantity = action.payload.quantity;
      }
    },
    clearCart(state) {
      state.cart = [];
    },
    performCheckIn(state) {
      const today = new Date().toISOString().split('T')[0];
      const lastDate = state.rewards.lastCheckIn;
      const yesterday = new Date(Date.now() - 86400000)
        .toISOString()
        .split('T')[0];

      if (lastDate !== today) {
        const pointsEarned = 50;
        state.rewards.balance += pointsEarned;
        state.rewards.totalEarned += pointsEarned;
        state.rewards.streak = lastDate === yesterday ? state.rewards.streak + 1 : 1;
        state.rewards.lastCheckIn = today;
      }
    },
    redeemPoints(state, action: PayloadAction<number>) {
      if (state.rewards.balance >= action.payload) {
        state.rewards.balance -= action.payload;
      }
    },
    updateSettings(state, action: PayloadAction<Partial<AppSettings>>) {
      state.settings = { ...state.settings, ...action.payload };
    },
    setLoading(state, action: PayloadAction<boolean>) {
      state.loading = action.payload;
    },
    setError(state, action: PayloadAction<string | null>) {
      state.error = action.payload;
    },
    toggleEventRegistration(state, action: PayloadAction<string>) {
      const event = state.events.find((e) => e.id === action.payload);
      if (event) {
        event.isRegistered = !event.isRegistered;
      }
    },
  },
});

export const {
  setVehicles,
  setProducts,
  setEvents,
  addToCart,
  removeFromCart,
  updateCartQuantity,
  clearCart,
  performCheckIn,
  redeemPoints,
  updateSettings,
  setLoading,
  setError,
  toggleEventRegistration,
} = appSlice.actions;

export default appSlice.reducer;
