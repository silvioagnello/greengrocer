import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/common/widgets/app_name_widget.dart';
import 'package:greengrocer/src/config/custom_colors.dart';

import '../pages_routes/app_pages.dart';

// @override
// void initState() {
//   super.initState();
//   Future.delayed(
//     const Duration(seconds: 2),
//     () {
//       // Navigator.of(context).pushReplacement(MaterialPageRoute(
//       //   builder: (context) => const SignInScreen(),
//       // ));
//
//       Get.offNamed(PagesRoute.signInRoute);
//     },
//   );
// }
// @override
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      Future.delayed(
        const Duration(seconds: 2),
        () {
          // Navigator.of(context).pushReplacement(MaterialPageRoute(
          //   builder: (context) => const SignInScreen(),
          // ));

          Get.offNamed(PagesRoute.signInRoute);
        },
      );
      //Get.find<AuthController>().validateToken();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              CustomColors.customSwatchColor,
              CustomColors.customSwatchColor.shade700
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppName(textSize: 40),
            SizedBox(height: 20),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
