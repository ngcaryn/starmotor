class ApiConfig {
  ApiConfig._();

  // Base URLs - update with actual API endpoints
  static const String baseUrl = 'https://api.starmotor.com/v1';
  static const String mediaBaseUrl = 'https://media.starmotor.com';

  // Timeouts
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 60);
  static const Duration sendTimeout = Duration(seconds: 60);

  // Auth endpoints
  static const String login = '/auth/login';
  static const String signup = '/auth/signup';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  static const String sendOtp = '/auth/otp/send';
  static const String verifyOtp = '/auth/otp/verify';

  // User endpoints
  static const String userProfile = '/user/profile';
  static const String updateProfile = '/user/profile/update';
  static const String userOrders = '/user/orders';
  static const String userWishlist = '/user/wishlist';
  static const String userAddresses = '/user/addresses';

  // Social endpoints
  static const String socialFeed = '/social/feed';
  static const String posts = '/social/posts';
  static const String postDetail = '/social/posts/{id}';
  static const String postComments = '/social/posts/{id}/comments';
  static const String likePost = '/social/posts/{id}/like';
  static const String followUser = '/social/users/{id}/follow';

  // Publication endpoints
  static const String publicationFeed = '/publication/feed';
  static const String publicationDetail = '/publication/{id}';
  static const String events = '/publication/events';

  // Purchase endpoints
  static const String carModels = '/purchase/cars';
  static const String carDetail = '/purchase/cars/{id}';
  static const String carConfig = '/purchase/cars/{id}/configure';
  static const String placeOrder = '/purchase/orders';
  static const String dealers = '/purchase/dealers';

  // Explore endpoints
  static const String brandStory = '/explore/brand-story';
  static const String showrooms = '/explore/showrooms';
  static const String brandEvents = '/explore/events';
  static const String brandGallery = '/explore/gallery';

  // Mall endpoints
  static const String mallProducts = '/mall/products';
  static const String mallCategories = '/mall/categories';
  static const String productDetail = '/mall/products/{id}';
  static const String cartItems = '/mall/cart';
  static const String addToCart = '/mall/cart/add';
  static const String mallOrders = '/mall/orders';

  // Service endpoints
  static const String serviceOptions = '/service/options';
  static const String bookService = '/service/bookings';
  static const String serviceHistory = '/service/history';
  static const String serviceCenters = '/service/centers';
  static const String warranty = '/service/warranty';
}
