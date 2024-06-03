import 'package:get/get.dart';
import 'package:greengrocer/src/auth/controllers/auth_controller.dart';
import 'package:greengrocer/src/cart/models/cart_item_model.dart';
import 'package:greengrocer/src/order/repositories/order_repository.dart';
import 'package:greengrocer/src/order/result/orders_result.dart';
import 'package:greengrocer/src/services/utils_service.dart';

import '../models/order_model.dart';

class OrderController extends GetxController {
  OrderModel order;

  OrderController(this.order);

  final orderRepository = OrderRepository();
  final authController = Get.find<AuthController>();
  final utilsServices = UtilsService();

  bool isLoading = false;
  void setLoading(bool value) {
    isLoading = value;
    update();
  }

  Future<void> getOrderItems() async {
    setLoading(true);

    final OrdersResult<List<CartItemModel>> result = await orderRepository
        .getOrderItems(orderId: order.id, token: authController.user.token!);

    setLoading(false);

    result.when(sucess: (items) {
      order.items = items;
      update();
    }, error: (msgError) {
      utilsServices.myToast(msg: msgError, isError: true);
    });
  }
}
