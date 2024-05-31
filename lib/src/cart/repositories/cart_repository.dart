import 'package:greengrocer/src/cart/models/cart_item_model.dart';
import 'package:greengrocer/src/cart/repositories/cart_result.dart';
import 'package:greengrocer/src/common/constants/endpoints.dart';
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
}
