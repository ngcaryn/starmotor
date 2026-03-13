import apiClient from './api';
import { Vehicle } from '../store/appSlice';

export interface VehicleFilters {
  category?: string;
  minPrice?: number;
  maxPrice?: number;
  year?: number;
}

export interface VehicleInquiry {
  vehicleId: string;
  name: string;
  email: string;
  phone: string;
  message: string;
  preferredContactMethod: 'email' | 'phone';
}

// Fetch the complete vehicle catalog with optional filters
export const fetchVehicles = async (
  filters?: VehicleFilters
): Promise<Vehicle[]> => {
  const response = await apiClient.get<Vehicle[]>('/vehicles', {
    params: filters,
  });
  return response.data;
};

// Fetch detailed information for a single vehicle
export const fetchVehicleById = async (id: string): Promise<Vehicle> => {
  const response = await apiClient.get<Vehicle>(`/vehicles/${id}`);
  return response.data;
};

// Submit a vehicle inquiry/test drive request
export const submitVehicleInquiry = async (
  inquiry: VehicleInquiry
): Promise<{ inquiryId: string; message: string }> => {
  const response = await apiClient.post('/vehicles/inquiry', inquiry);
  return response.data;
};

// Fetch vehicle comparison data for multiple vehicles
export const compareVehicles = async (vehicleIds: string[]) => {
  const response = await apiClient.post('/vehicles/compare', { vehicleIds });
  return response.data;
};

// Fetch available vehicle categories
export const fetchVehicleCategories = async (): Promise<string[]> => {
  const response = await apiClient.get<string[]>('/vehicles/categories');
  return response.data;
};
