/**
 * Formatting utility functions for the StarMotor app
 */

// Format a number as currency
export const formatCurrency = (
  amount: number,
  currency = 'USD',
  locale = 'en-US'
): string => {
  return new Intl.NumberFormat(locale, {
    style: 'currency',
    currency,
    minimumFractionDigits: 0,
    maximumFractionDigits: 2,
  }).format(amount);
};

// Format a number with thousands separators
export const formatNumber = (value: number): string => {
  return new Intl.NumberFormat('en-US').format(value);
};

// Format an ISO date string to a readable format
export const formatDate = (
  dateString: string,
  options: Intl.DateTimeFormatOptions = {
    year: 'numeric',
    month: 'long',
    day: 'numeric',
  }
): string => {
  const date = new Date(dateString);
  return date.toLocaleDateString('en-US', options);
};

// Format a relative time string (e.g., "2 hours ago")
export const formatRelativeTime = (dateString: string): string => {
  const now = Date.now();
  const date = new Date(dateString).getTime();
  const diff = now - date;

  const seconds = Math.floor(diff / 1000);
  const minutes = Math.floor(seconds / 60);
  const hours = Math.floor(minutes / 60);
  const days = Math.floor(hours / 24);

  if (days > 0) return `${days}d ago`;
  if (hours > 0) return `${hours}h ago`;
  if (minutes > 0) return `${minutes}m ago`;
  return 'Just now';
};

// Truncate a string to a maximum length with ellipsis
export const truncateText = (text: string, maxLength: number): string => {
  if (text.length <= maxLength) return text;
  return text.substring(0, maxLength - 3) + '...';
};
