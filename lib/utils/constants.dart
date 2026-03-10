class AppConstants {
  AppConstants._();

  // App info
  static const String appName = 'Starmotor';
  static const String appNameChinese = '星驰汽车';
  static const String companyName = 'Starmotor Technologies';
  static const String supportEmail = 'support@starmotor.com';
  static const String supportPhone = '400-888-0000';
  static const String websiteUrl = 'https://www.starmotor.com';

  // Social
  static const int maxPostLength = 2000;
  static const int maxImageCount = 9;
  static const int maxCommentLength = 500;

  // Mall
  static const double freeShippingThreshold = 299.0;
  static const double standardShippingFee = 15.0;

  // Routes
  static const String routeHome = '/';
  static const String routeLogin = '/login';
  static const String routeSignup = '/signup';
  static const String routeSocial = '/social';
  static const String routePublication = '/publication';
  static const String routePurchase = '/purchase';
  static const String routeExplore = '/explore';
  static const String routeMall = '/mall';
  static const String routeService = '/service';
  static const String routeProfile = '/profile';
  static const String routeSettings = '/settings';
  static const String routeCarDetail = '/car-detail';
  static const String routeProductDetail = '/product-detail';

  // SharedPreferences keys (should not conflict with StorageService)
  static const String prefCartItems = 'cart_items';
  static const String prefWishlist = 'wishlist_items';
  static const String prefSearchHistory = 'search_history';
  static const String prefNotificationEnabled = 'notification_enabled';

  // Error messages
  static const String errorNetwork = '网络连接失败，请检查您的网络设置';
  static const String errorServer = '服务器错误，请稍后重试';
  static const String errorUnauthorized = '请先登录';
  static const String errorUnknown = '发生未知错误，请稍后重试';
  static const String errorTimeout = '请求超时，请稍后重试';

  // Success messages
  static const String successLogin = '登录成功，欢迎回来！';
  static const String successSignup = '注册成功，欢迎加入星驰！';
  static const String successPostCreated = '发布成功！';
  static const String successAddedToCart = '已加入购物车';
  static const String successOrderPlaced = '订单提交成功！';

  // Chinese provinces (for address)
  static const List<String> provinces = [
    '北京市', '上海市', '天津市', '重庆市',
    '河北省', '山西省', '辽宁省', '吉林省', '黑龙江省',
    '江苏省', '浙江省', '安徽省', '福建省', '江西省', '山东省',
    '河南省', '湖北省', '湖南省', '广东省', '海南省',
    '四川省', '贵州省', '云南省', '陕西省', '甘肃省',
    '青海省', '台湾省',
    '内蒙古自治区', '广西壮族自治区', '西藏自治区',
    '宁夏回族自治区', '新疆维吾尔自治区',
    '香港特别行政区', '澳门特别行政区',
  ];
}
