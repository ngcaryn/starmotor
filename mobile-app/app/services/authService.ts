import apiClient, { saveToken, clearToken } from './api';

export interface LoginCredentials {
  email: string;
  password: string;
}

export interface RegisterData {
  name: string;
  email: string;
  password: string;
  phone?: string;
}

export interface AuthResponse {
  user: {
    id: string;
    name: string;
    email: string;
    avatar?: string;
    phone?: string;
  };
  token: string;
}

// Authenticate user with email and password
export const login = async (
  credentials: LoginCredentials
): Promise<AuthResponse> => {
  const response = await apiClient.post<AuthResponse>(
    '/auth/login',
    credentials
  );
  await saveToken(response.data.token);
  return response.data;
};

// Register a new user account
export const register = async (data: RegisterData): Promise<AuthResponse> => {
  const response = await apiClient.post<AuthResponse>('/auth/register', data);
  await saveToken(response.data.token);
  return response.data;
};

// Logout: clear stored token
export const logout = async (): Promise<void> => {
  try {
    await apiClient.post('/auth/logout');
  } catch {
    // Continue even if the server call fails
  } finally {
    await clearToken();
  }
};

// Fetch the current user profile
export const fetchUserProfile = async () => {
  const response = await apiClient.get('/user/profile');
  return response.data;
};

// Update user profile information
export const updateUserProfile = async (profileData: Record<string, string>) => {
  const response = await apiClient.put('/user/profile', profileData);
  return response.data;
};

// Request password reset email
export const requestPasswordReset = async (email: string): Promise<void> => {
  await apiClient.post('/auth/forgot-password', { email });
};
