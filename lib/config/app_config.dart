/// Application-wide feature flags and configuration.
class AppConfig {
  AppConfig._();

  static const String appName = '星驰汽车';
  static const String appVersion = '1.0.0';

  // Feature flags
  static const bool enableSocialFeed = true;
  static const bool enableMall = true;
  static const bool enableServiceBooking = true;
  static const bool enablePushNotifications = true;
  static const bool enableDarkMode = true;

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxCacheAge = 300; // seconds

  // Image limits
  static const int maxPostImages = 9;
  static const int maxImageSizeMb = 10;
}
