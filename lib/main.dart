import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/auth/controllers/auth_controller.dart';
import 'package:greengrocer/src/pages_routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GreenGrocer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        scaffoldBackgroundColor: Colors.white.withAlpha(190),
        useMaterial3: true,
      ),
      //home: const SplashScreen(),
      initialRoute: PagesRoute.splashRoute,
      getPages: AppPages.pages,
    ); //SignInScreen()); //BaseScreen()); //
  }
}
