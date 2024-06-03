import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/base/controllers/navigator_controller.dart';
import 'package:greengrocer/src/cart/controllers/cart_controller.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/services/utils_service.dart';

import '../common/widgets/quantity_widget.dart';
import 'models/item_model.dart';

class ProductScreen extends StatefulWidget {
  ProductScreen({super.key});

  final ItemModel item = Get.arguments;
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final UtilsService utilsService = UtilsService();

  int cartItemQuantity = 1;

  final navigatorController = Get.find<NavigatorController>();
  final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withAlpha(220),
      body: Stack(
        children: [
          // CONTEÚDO
          Column(
            children: [
              // IMAGEM
              Expanded(
                child: Hero(
                  tag: widget.item.imgUrl,
                  child: Image.network(widget.item.imgUrl),
                ),
              ),
              Expanded(
                // CAIXA BRANCA
                child: Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(50)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade600,
                            offset: const Offset(0, 2)),
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // NOME + QUANTIDADE
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.item.itemName,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 27, fontWeight: FontWeight.bold),
                              maxLines: 2,
                            ),
                          ),
                          QuantityWidget(
                            suffix: widget.item.unit,
                            value: cartItemQuantity,
                            result: (quantity) {
                              setState(() {
                                cartItemQuantity = quantity;
                              });
                            },
                          ),
                        ],
                      ),
                      // PREÇO
                      Text(
                        utilsService.priceToCurrency(widget.item.price),
                        style: TextStyle(
                            color: CustomColors.customSwatchColor,
                            fontSize: 23,
                            fontWeight: FontWeight.bold),
                      ),
                      // DESCRIÇÃO
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: SingleChildScrollView(
                            child: Text(
                              widget.item.description,
                              style: const TextStyle(height: 1.5),
                            ),
                          ),
                        ),
                      ),
                      // BOTÃO Adicionar ao carrinho
                      SizedBox(
                        height: 45,
                        child: ElevatedButton.icon(
                          icon: const Icon(
                            Icons.shopping_cart_outlined,
                            // color: Colors.white,
                          ),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          )),
                          onPressed: () {
                            Get.back();
                            cartController.addItemToCart(
                                item: widget.item, quantity: cartItemQuantity);
                            navigatorController
                                .navigatePageView(NavigationTabs.cart);
                          },
                          label: const Text(
                            'Adicionar ao carrinho',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          // BOTÃO VOLTAR
          Positioned(
            left: 10,
            top: 0,
            child: SafeArea(
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(
                  Icons.arrow_back_ios,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
