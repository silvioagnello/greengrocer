import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/base/controllers/navigator_controller.dart';
import 'package:greengrocer/src/base/home/controllers/home_controller.dart';
import 'package:greengrocer/src/cart/controllers/cart_controller.dart';
import 'package:greengrocer/src/common/widgets/custom_shimmer.dart';
import 'package:greengrocer/src/config/custom_colors.dart';

import '../../../common/widgets/app_name_widget.dart';
import 'components/category_tile.dart';
import 'components/item_tile.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  // String selectedCategory = 'Frutas';
  GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCardAnimation;
  // bool isLoading = true;
  final searchController = TextEditingController();
  final navigatorController = Get.find<NavigatorController>();

  void itemSelectedCartAnimations(GlobalKey gkImage) {
    runAddToCardAnimation(gkImage);
  }

  //final controller = Get.find<HomeController>();
  // @override
  // void initState() {
  //   super.initState();
  //   // Future.delayed(
  //   //   const Duration(seconds: 3),
  //   //   () {
  //   //     setState(() {
  //   //       isLoading = false;
  //   //     });
  //   //   },
  //   // );
  // }

  @override
  Widget build(BuildContext context) {
    return AddToCartAnimation(
      cartKey: cartKey,
      height: 30,
      width: 30,
      opacity: 0.85,
      dragAnimation: const DragToCartAnimationOptions(
        rotation: false,
      ),
      jumpAnimation: const JumpAnimationOptions(),
      createAddToCartAnimation: (runAddToCartAnimation) {
        runAddToCardAnimation = runAddToCartAnimation;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: CustomColors.customSwatchColor,
          actions: [
            // ICON CARRINHO + BADGE
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: GetBuilder<CartController>(builder: (controller) {
                return Badge(
                  smallSize: 40,
                  label: Text(controller.cartItems.length.toString()),
                  child: AddToCartIcon(
                    badgeOptions: const BadgeOptions(
                      active: false,
                      backgroundColor: Colors.red,
                    ),
                    key: cartKey,
                    icon: GestureDetector(
                      onTap: () {
                        navigatorController
                            .navigatePageView(NavigationTabs.cart);
                      },
                      child: const Icon(
                        size: 35,
                        Icons.shopping_cart,
                        color: Colors.white60,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
          elevation: 0,
          //backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const AppName(),
        ),
        body: Column(
          children: [
            // CAMPO DE PESQUISA
            GetBuilder<HomeController>(builder: (controller) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 4),
                child: TextFormField(
                  controller: searchController,
                  onChanged: (v) {
                    controller.searchTitle.value = v;
                  },
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 21,
                      ),
                      suffixIcon: controller.searchTitle.value.isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                searchController.clear();
                                controller.searchTitle.value = '';
                                FocusScope.of(context).unfocus();
                              },
                              icon: Icon(
                                Icons.close,
                                size: 21,
                                color: CustomColors.customContrastColor,
                              ),
                            )
                          : null,
                      hintText: 'Pesquise aqui...',
                      hintStyle:
                          TextStyle(color: Colors.grey.shade700, fontSize: 14),
                      isDense: true,
                      filled: true,
                      fillColor: Colors.grey.withAlpha(50),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.none),
                          borderRadius: BorderRadius.circular(50))),
                ),
              );
            }),
            // LISTA DE CATEGORIAS
            GetBuilder<HomeController>(builder: (controller) {
              return Container(
                height: 40,
                padding: const EdgeInsets.only(left: 25),
                child: !controller.isCategoryLoading
                    ? ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) {
                          return CategoryTile(
                              onPressed: () {
                                // setState(() {
                                // selectedCategory = data.categories[index];
                                // });
                                controller.selectCategory(
                                    controller.allCategories[index]);
                                // controller.selectCategory(category)
                              },
                              category: controller.allCategories[index]
                                  .title, //data.categories[index],
                              isSelected:
                                  // data.categories[index] == selectedCategory,
                                  controller.allCategories[index] ==
                                      controller.currentCategory);
                        },
                        separatorBuilder: (_, index) =>
                            const SizedBox(width: 10),
                        itemCount: controller
                            .allCategories.length) //data.categories.length)
                    : ListView(
                        scrollDirection: Axis.horizontal,
                        children: List.generate(
                            10,
                            (index) => Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(right: 12),
                                  child: CustomShimmer(
                                    height: 20,
                                    width: 80,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                )),
                      ),
              );
            }),
            // GRIDVIEW ITEMS
            GetBuilder<HomeController>(builder: (controller) {
              return Expanded(
                child: !controller.isProductsLoading
                    ? Visibility(
                        visible: (controller.currentCategory?.items ?? [])
                            .isNotEmpty,
                        replacement: Column(
                          children: [
                            Icon(Icons.search_off,
                                size: 40,
                                color: CustomColors.customSwatchColor),
                            const Text('Nenhum item encontrado')
                          ],
                        ),
                        child: GridView.builder(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 9 / 11.5),
                          itemCount: controller
                              .allProducts.length, //data.items.length,
                          itemBuilder: (_, index) {
                            if (((index + 1) ==
                                    controller.allProducts.length) &&
                                !controller.isLastPage) {
                              controller.loadMoreProducts();
                            }
                            return ItemTile(
                                item: controller
                                    .allProducts[index], //data.items[index],
                                cartAnimationMethod:
                                    itemSelectedCartAnimations);
                          },
                        ),
                      )
                    : GridView.count(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        physics: const BouncingScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 9 / 11.5,
                        children: List.generate(
                          10,
                          (index) => CustomShimmer(
                            height: double.infinity,
                            width: double.infinity,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        )),
              );
            })
          ],
        ),
      ),
    );
  }
}
