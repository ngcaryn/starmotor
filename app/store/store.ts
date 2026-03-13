import { configureStore } from '@reduxjs/toolkit';
import authReducer from './authSlice';
import appReducer from './appSlice';

// Configure the Redux store with auth and app reducers
export const store = configureStore({
  reducer: {
    auth: authReducer,
    app: appReducer,
  },
  middleware: (getDefaultMiddleware) =>
    getDefaultMiddleware({
      serializableCheck: {
        // Ignore non-serializable date fields in rewards state
        ignoredPaths: ['app.rewards.lastCheckIn'],
      },
    }),
});

export type RootState = ReturnType<typeof store.getState>;
export type AppDispatch = typeof store.dispatch;
