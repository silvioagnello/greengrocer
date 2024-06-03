import 'package:get/get.dart';
import 'package:greengrocer/src/auth/controllers/auth_controller.dart';
import 'package:greengrocer/src/order/repositories/order_repository.dart';
import 'package:greengrocer/src/services/utils_service.dart';

import '../models/order_model.dart';
import '../result/orders_result.dart';

class AllOrdersController extends GetxController {
  List<OrderModel> allOrders = [];
  final ordersRepository = OrderRepository();
  final authController = Get.find<AuthController>();
  final utilsServices = UtilsService();

  @override
  void onInit() {
    super.onInit();
    getAllOrders();
  } //

  Future<void> getAllOrders() async {
    OrdersResult<List<OrderModel>> result = await ordersRepository.getAllOrders(
        userId: authController.user.id!, token: authController.user.token!);
    result.when(sucess: (orders) {
      allOrders = orders;
      update();
    }, error: (msgError) {
      utilsServices.myToast(msg: msgError, isError: true);
    });
  }
}
