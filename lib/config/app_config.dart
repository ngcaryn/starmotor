class AppConfig {
  AppConfig._();

  static const String appName = 'Starmotor';
  static const String appNameChinese = '星驰汽车';
  static const String appVersion = '1.0.0';
  static const int appBuildNumber = 1;

  // Feature flags
  static const bool enableCarControl = false; // Phase 2
  static const bool enablePayment = false; // Phase 2
  static const bool enableLiveChat = false; // Phase 2
  static const bool enablePushNotifications = true;

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // Cache durations (in minutes)
  static const int shortCacheDuration = 5;
  static const int mediumCacheDuration = 30;
  static const int longCacheDuration = 60 * 24; // 24 hours

  // Image quality
  static const int imageQuality = 85;
  static const double maxImageSizeMB = 10.0;
}
