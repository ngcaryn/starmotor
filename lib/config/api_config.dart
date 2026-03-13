/// API endpoint configuration for the Starmotor backend.
class ApiConfig {
  ApiConfig._();

  static const String baseUrl = 'https://api.starmotor.com/v1';

  // Auth
  static const String login = '/auth/login';
  static const String loginWithPhone = '/auth/login/phone';
  static const String sendOtp = '/auth/otp/send';
  static const String verifyOtp = '/auth/otp/verify';
  static const String signup = '/auth/signup';
  static const String refreshToken = '/auth/refresh';
  static const String logout = '/auth/logout';

  // Social
  static const String socialFeed = '/social/feed';
  static const String createPost = '/social/posts';
  static const String postDetail = '/social/posts/{id}';
  static const String postComments = '/social/posts/{id}/comments';
  static const String likePost = '/social/posts/{id}/like';

  // Cars / Purchase
  static const String carList = '/cars';
  static const String carDetail = '/cars/{id}';
  static const String carVariants = '/cars/{id}/variants';
  static const String createOrder = '/orders';

  // Mall
  static const String products = '/mall/products';
  static const String productDetail = '/mall/products/{id}';
  static const String cart = '/mall/cart';
  static const String cartAdd = '/mall/cart/items';
  static const String cartRemove = '/mall/cart/items/{id}';

  // Service
  static const String services = '/service/types';
  static const String serviceCenters = '/service/centers';
  static const String bookService = '/service/bookings';
  static const String userBookings = '/service/bookings/mine';

  // Profile
  static const String userProfile = '/user/profile';
  static const String updateProfile = '/user/profile';
  static const String userOrders = '/user/orders';
}
