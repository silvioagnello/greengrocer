import 'package:get/get.dart';
import 'package:greengrocer/src/base/home/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}
