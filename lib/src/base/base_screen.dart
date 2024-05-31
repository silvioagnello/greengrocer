import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/base/controllers/navigator_controller.dart';
import 'package:greengrocer/src/config/custom_colors.dart';

import '../cart/views/cart_tab.dart';
import '../order/order_tab.dart';
import '../profile/profile_tab.dart';
import 'home/views/home_tab.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  // int currentIndex = 0;
  // final pageController = PageController();
  final navigatorController = Get.find<NavigatorController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: navigatorController.pageController,
        children: const [
          HomeTab(),
          CartTab(),
          OrderTab(),
          ProfileTab(),
        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
            onTap: (index) {
              navigatorController.navigatePageView(index);
              // currentIndex = index;
              // // pageController.jumpToPage(index);
              // pageController.animateToPage(index,
              //     duration: const Duration(milliseconds: 600),
              //     curve: Curves.ease);
            },
            currentIndex: navigatorController.currentIndex,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white.withAlpha(140),
            backgroundColor: CustomColors.customSwatchColor,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart_outlined), label: 'Carrinho'),
              BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Pedidos'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline), label: 'Perfil'),
            ]),
      ),
    );
  }
}
