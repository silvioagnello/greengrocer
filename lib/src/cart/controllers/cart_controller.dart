import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/auth/controllers/auth_controller.dart';
import 'package:greengrocer/src/cart/models/cart_item_model.dart';
import 'package:greengrocer/src/cart/repositories/cart_repository.dart';
import 'package:greengrocer/src/cart/repositories/cart_result.dart';
import 'package:greengrocer/src/order/models/order_model.dart';
import 'package:greengrocer/src/services/utils_service.dart';

import '../../base/models/item_model.dart';
import '../../common/widgets/payment_dialog.dart';

class CartController extends GetxController {
  final cartRepository = CartRepository();
  final authController = Get.find<AuthController>();
  final utilsServices = UtilsService();
  List<CartItemModel> cartItems = [];
  bool isCheckoutLoading = false;

  @override
  void onInit() {
    super.onInit();
    getCartItems();
  }

  double cartTotalPrice() {
    double total = 0;
    for (final item in cartItems) {
      total += item.totalPrice();
    }
    return total;
  }

  Future checkoutCart() async {
    setCheckoutLoading(true);

    CartResult<OrderModel> result = await cartRepository.checkoutCart(
      token: authController.user.token!,
      total: cartTotalPrice(),
    );

    setCheckoutLoading(false);

    result.when(success: (order) {
      cartItems.clear();
      update();
      showDialog(
        context: Get.context!,
        builder: (_) => PaymentDialog(order: order),
      );
    }, error: (msgError) {
      utilsServices.myToast(isError: false, msg: msgError);
    });
  }

  Future<bool> changeItemQuantity({
    required CartItemModel item,
    required int quantity,
  }) async {
    final result = await cartRepository.changeItemQuantity(
        token: authController.user.token!,
        cartItemId: item.id,
        quantity: quantity);
    if (result) {
      //
      if (quantity == 0) {
        cartItems.removeWhere((cartItem) => cartItem.id == item.id);
      } else {
        cartItems.firstWhere((cartItem) => cartItem.id == item.id).quantity =
            quantity;
      }
      update();
    } else {
      utilsServices.myToast(msg: 'Ocorreu um erro', isError: true);
    }
    return result;
  }

  Future<void> getCartItems() async {
    final CartResult<List<CartItemModel>> result =
        await cartRepository.getCartItems(
      token: authController.user.token!,
      userId: authController.user.id!,
    );

    result.when(success: (data) {
      cartItems = data;
      update();
    }, error: (msgError) {
      utilsServices.myToast(msg: msgError, isError: true);
    });
  }

  int getItemIndex(ItemModel item) {
    return cartItems.indexWhere((itemInList) => itemInList.item.id == item.id);
  }

  Future<void> addItemToCart(
      {required ItemModel item, int quantity = 1}) async {
    int itemIndex = getItemIndex(item);
    if (itemIndex >= 0) {
      final product = cartItems[itemIndex];
      //final result =
      await changeItemQuantity(
        item: product,
        quantity: (product.quantity + quantity),
      );
      // if (result) {
      //   cartItems[itemIndex].quantity += quantity;
      // }
    } else {
      final CartResult<String> result = await cartRepository.addItemToCart(
        userId: authController.user.id!,
        token: authController.user.token!,
        productId: item.id,
        quantity: quantity,
      );
      result.when(
        success: (dataId) {
          cartItems.add(
            CartItemModel(
              item: item,
              id: dataId,
              quantity: quantity,
            ),
          );
        },
        error: (msgError) {
          utilsServices.myToast(msg: msgError, isError: true);
        },
      );
    }
    update();
  }

  void setCheckoutLoading(bool value) {
    isCheckoutLoading = value;
    update();
  }
}
