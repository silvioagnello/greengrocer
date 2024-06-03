import 'package:get/get.dart';
import 'package:greengrocer/src/auth/views/sign_in_screen.dart';
import 'package:greengrocer/src/auth/views/sign_up_screen.dart';
import 'package:greengrocer/src/base/home/bindings/home_binding.dart';
import 'package:greengrocer/src/base/product_screen.dart';
import 'package:greengrocer/src/cart/bindings/cart_binding.dart';
import 'package:greengrocer/src/order/bindings/orders_binding.dart';
import 'package:greengrocer/src/splash/splash_screen.dart';

import '../base/base_screen.dart';
import '../base/bindings/navigation_binding.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(name: PagesRoute.splashRoute, page: () => const SplashScreen()),
    GetPage(name: PagesRoute.productRoute, page: () => ProductScreen()),
    GetPage(name: PagesRoute.signInRoute, page: () => SignInScreen()),
    GetPage(name: PagesRoute.signUpRoute, page: () => SignUpScreen()),
    GetPage(
        name: PagesRoute.baseRoute,
        page: () => const BaseScreen(),
        bindings: [
          NavigationBinding(),
          HomeBinding(),
          CartBinding(),
          OrdersBinding(),
        ]),
  ];
}

abstract class PagesRoute {
  static const String productRoute = '/product';
  static const String signInRoute = '/signin';
  static const String signUpRoute = '/signup';
  static const String splashRoute = '/splash';
  static const String baseRoute = '/';
}
