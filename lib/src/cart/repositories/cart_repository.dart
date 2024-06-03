import 'package:greengrocer/src/cart/models/cart_item_model.dart';
import 'package:greengrocer/src/cart/repositories/cart_result.dart';
import 'package:greengrocer/src/common/constants/endpoints.dart';
import 'package:greengrocer/src/order/models/order_model.dart';
import 'package:greengrocer/src/services/http_manager.dart';

class CartRepository {
  //
  final _httpManager = HttpManager();

  Future<CartResult<List<CartItemModel>>> getCartItems({
    required String token,
    required String userId,
  }) async {
    final result = await _httpManager.restRequest(
        url: Endpoints.getCartItems,
        method: HttpMethods.post,
        headers: {'X-Parse-Session-Token': token},
        body: {'user': userId});

    if (result['result'] != null) {
      List<CartItemModel> data =
          List<Map<String, dynamic>>.from(result['result'])
              .map(CartItemModel.fromJson)
              .toList();
      return CartResult<List<CartItemModel>>.success(data);
    } else {
      return CartResult.error('Ocorreu um erro ao buscar o carrinho');
    }
  }

  Future<CartResult<String>> addItemToCart({
    required String userId,
    required String token,
    required String productId,
    required int quantity,
  }) async {
    final result = await _httpManager.restRequest(
        url: Endpoints.addItemToCart,
        method: HttpMethods.post,
        body: {"user": userId, "quantity": quantity, "productId": productId},
        headers: {'X-Parse-Session-Token': token});

    if (result['result'] != null) {
      return CartResult<String>.success(result['result']['id']);
    } else {
      return CartResult.error('Erro ao adicionar item');
    }
  }

  Future<CartResult<OrderModel>> checkoutCart({
    required String token,
    required double total,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.checkout,
      method: HttpMethods.post,
      body: {'total': total},
      headers: {'X-Parse-Session-Token': token},
    );

    if (result['result'] != null) {
      final order = OrderModel.fromJson(result['result']);
      return CartResult<OrderModel>.success(order);
    } else {
      return CartResult.error('Erro ao tentar finalizar compra');
    }
  }

  Future<bool> changeItemQuantity(
      {required String token,
      required String cartItemId,
      required int quantity}) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.changeItemQuantity,
      method: HttpMethods.post,
      body: {
        "cartItemId": cartItemId,
        "quantity": quantity,
      },
      headers: {'X-Parse-Session-Token': token},
    );

    return result.isEmpty;
  }
}
