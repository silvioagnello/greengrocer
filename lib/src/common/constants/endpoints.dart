const baseUrl = 'https://parseapi.back4app.com/functions/';

abstract class Endpoints {
  static const String token = 'keyToken';
  static const String signin = '$baseUrl/login';
  static const String signup = '$baseUrl/signup';
  static const String resetPass = '$baseUrl/reset-password';
  static const String changePassword = '$baseUrl/change-password';
  static const String getCategories = '$baseUrl/get-category-list';
  static const String getProducts = '$baseUrl/get-product-list';
  static const String getCartItems = '$baseUrl/get-cart-items';
  static const String addItemToCart = '$baseUrl/add-item-to-cart';
  static const String changeItemQuantity = '$baseUrl/modify-item-quantity';
  static const String checkout = '$baseUrl/checkout';
  static const String getAllOrders = '$baseUrl/get-orders';
  static const String getOrderItems = '$baseUrl/get-order-items';

  static const String validateToken = '$baseUrl/validate-token';
}
