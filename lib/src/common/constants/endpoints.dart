const baseUrl = 'https://parseapi.back4app.com/functions/';

abstract class Endpoints {
  static const String token = 'keyToken';
  static const String signin = '$baseUrl/login';
  static const String signup = '$baseUrl/signup';
  static const String resetPass = '$baseUrl/reset-password';
  static const String getCategories = '$baseUrl/get-category-list';
  static const String getProducts = '$baseUrl/get-product-list';
  static const String getCartItems = '$baseUrl/get-cart-items';

  static const String validateToken = '$baseUrl/validate-token';
}
