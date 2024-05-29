import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:flutter/material.dart';
import 'package:greengrocer/src/base/home/components/item_tile.dart';
import 'package:greengrocer/src/common/widgets/custom_shimmer.dart';
import 'package:greengrocer/src/config/custom_colors.dart';

import '../../common/widgets/app_name_widget.dart';
import '../../config/app_data.dart' as data;
import 'components/category_tile.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String selectedCategory = 'Frutas';
  GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCardAnimation;
  bool isLoading = true;

  void itemSelectedCartAnimations(GlobalKey gkImage) {
    runAddToCardAnimation(gkImage);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        setState(() {
          isLoading = false;
        });
      },
    );
  }

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
              child: AddToCartIcon(
                badgeOptions: const BadgeOptions(
                  active: true,
                  backgroundColor: Colors.red,
                ),
                key: cartKey,
                icon: const Icon(
                  size: 35,
                  Icons.shopping_cart,
                  color: Colors.white60,
                ),
              ),
            )
          ],
          elevation: 0,
          //backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const AppName(),
        ),
        body: Column(
          children: [
            // CAMPO DE PESQUISA
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: TextFormField(
                decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 21,
                    ),
                    hintText: 'Pesquise aqui...',
                    hintStyle:
                        TextStyle(color: Colors.grey.shade700, fontSize: 14),
                    isDense: true,
                    filled: true,
                    fillColor: Colors.grey.withAlpha(50),
                    border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 0, style: BorderStyle.none),
                        borderRadius: BorderRadius.circular(50))),
              ),
            ),
            // LISTA DE CATEGORIAS
            Container(
              height: 40,
              padding: const EdgeInsets.only(left: 25),
              child: !isLoading
                  ? ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index) {
                        return CategoryTile(
                          onPressed: () {
                            setState(() {
                              selectedCategory = data.categories[index];
                            });
                          },
                          category: data.categories[index],
                          isSelected:
                              data.categories[index] == selectedCategory,
                        );
                      },
                      separatorBuilder: (_, index) => const SizedBox(width: 10),
                      itemCount: data.categories.length)
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
            ),
            // GRIDVIEW ITEMS
            Expanded(
              child: !isLoading
                  ? GridView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 9 / 11.5),
                      itemCount: data.items.length,
                      itemBuilder: (context, index) {
                        return ItemTile(
                            item: data.items[index],
                            cartAnimationMethod: itemSelectedCartAnimations);
                      },
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
            )
          ],
        ),
      ),
    );
  }
}
