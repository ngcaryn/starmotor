/**
 * Input validation utility functions for the StarMotor app
 */

// Validate an email address format
export const isValidEmail = (email: string): boolean => {
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return emailRegex.test(email.trim());
};

// Validate a phone number (E.164 or common formats)
export const isValidPhone = (phone: string): boolean => {
  const phoneRegex = /^\+?[1-9]\d{7,14}$/;
  return phoneRegex.test(phone.replace(/[\s\-().]/g, ''));
};

// Validate password strength
export const validatePassword = (
  password: string
): { isValid: boolean; message: string } => {
  if (password.length < 8) {
    return { isValid: false, message: 'Password must be at least 8 characters.' };
  }
  if (!/[A-Z]/.test(password)) {
    return { isValid: false, message: 'Password must include an uppercase letter.' };
  }
  if (!/[0-9]/.test(password)) {
    return { isValid: false, message: 'Password must include a number.' };
  }
  return { isValid: true, message: '' };
};

// Check if a string is non-empty
export const isNonEmpty = (value: string): boolean => {
  return value.trim().length > 0;
};

// Validate that required fields are filled
export const validateRequired = (
  fields: Record<string, string>
): string | null => {
  for (const [key, value] of Object.entries(fields)) {
    if (!isNonEmpty(value)) {
      return `${key.charAt(0).toUpperCase() + key.slice(1)} is required.`;
    }
  }
  return null;
};
