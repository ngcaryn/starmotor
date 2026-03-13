class AppConstants {
  AppConstants._();

  // Routes
  static const String routeLogin = '/login';
  static const String routeSignup = '/signup';
  static const String routeMain = '/main';
  static const String routeSocialFeed = '/social';
  static const String routePostDetail = '/social/post/:id';
  static const String routeCreatePost = '/social/create';
  static const String routeCarList = '/purchase';
  static const String routeCarDetail = '/purchase/car/:id';
  static const String routeConfigurator = '/purchase/configurator';
  static const String routeMall = '/mall';
  static const String routeProfile = '/profile';
  static const String routeSettings = '/settings';

  // Error messages
  static const String errorNetwork = '网络连接失败，请检查网络设置';
  static const String errorServer = '服务器错误，请稍后重试';
  static const String errorUnauthorized = '登录已过期，请重新登录';
  static const String errorGeneric = '出现错误，请稍后重试';

  // Success messages
  static const String successLogin = '登录成功';
  static const String successLogout = '已退出登录';
  static const String successProfileUpdate = '资料更新成功';
  static const String successOrderSubmit = '订单提交成功';

  // Cache keys
  static const String cacheKeyFeed = 'social_feed';
  static const String cacheKeyCars = 'car_list';
  static const String cacheKeyProducts = 'products';

  // Chinese provinces list
  static const List<String> provinces = [
    '北京市', '天津市', '上海市', '重庆市',
    '河北省', '山西省', '辽宁省', '吉林省', '黑龙江省',
    '江苏省', '浙江省', '安徽省', '福建省', '江西省', '山东省',
    '河南省', '湖北省', '湖南省', '广东省', '海南省',
    '四川省', '贵州省', '云南省', '陕西省', '甘肃省',
    '青海省', '台湾省',
    '内蒙古自治区', '广西壮族自治区', '西藏自治区',
    '宁夏回族自治区', '新疆维吾尔自治区',
    '香港特别行政区', '澳门特别行政区',
  ];

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxRetries = 3;
}
