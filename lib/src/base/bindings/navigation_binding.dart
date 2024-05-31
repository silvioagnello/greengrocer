import 'package:get/get.dart';
import 'package:greengrocer/src/base/controllers/navigator_controller.dart';

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NavigatorController());
  }
}
