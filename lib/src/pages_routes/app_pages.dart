import 'package:get/get.dart';
import 'package:greengrocer/src/auth/views/sign_in_screen.dart';
import 'package:greengrocer/src/auth/views/sign_up_screen.dart';
import 'package:greengrocer/src/splash/splash_screen.dart';

import '../base/base_screen.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(name: PagesRoute.splashRoute, page: () => const SplashScreen()),
    GetPage(name: PagesRoute.signInRoute, page: () => SignInScreen()),
    GetPage(name: PagesRoute.signUpRoute, page: () => SignUpScreen()),
    GetPage(name: PagesRoute.baseRoute, page: () => const BaseScreen()),
  ];
}

abstract class PagesRoute {
  static const String signInRoute = '/signin';
  static const String signUpRoute = '/signup';
  static const String splashRoute = '/splash';
  static const String baseRoute = '/';
}
