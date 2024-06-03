import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/base/models/item_model.dart';
import 'package:greengrocer/src/cart/controllers/cart_controller.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/pages_routes/app_pages.dart';
import 'package:greengrocer/src/services/utils_service.dart';

class ItemTile extends StatefulWidget {
  final ItemModel item;
  final void Function(GlobalKey) cartAnimationMethod;

  const ItemTile(
      {super.key, required this.item, required this.cartAnimationMethod});

  @override
  State<ItemTile> createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  final GlobalKey imageGk = GlobalKey();

  final UtilsService utilsService = UtilsService();
  final cartController = Get.find<CartController>();

  IconData tileIcon = Icons.shopping_bag_outlined;

  Future<void> switchIcon() async {
    setState(() {
      tileIcon = Icons.check;
    });
    await Future.delayed(const Duration(milliseconds: 1500));
    setState(() {
      tileIcon = Icons.shopping_bag_outlined;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // CARD DO PRODUTO
        GestureDetector(
          onTap: () {
            // Navigator.of(context).push(MaterialPageRoute(
            //   builder: (context) => ProductScreen(
            //     item: widget.item,
            //   ),
            // ));
            Get.toNamed(PagesRoute.productRoute, arguments: widget.item);
          },
          child: Card(
            elevation: 3,
            shadowColor: Colors.grey.shade300,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // IMAGEM
                  Expanded(
                      child: Hero(
                          tag: widget.item.imgUrl,
                          child: Container(
                            key: imageGk,
                            child: Image.network(
                              //asset(
                              widget.item.imgUrl,
                            ),
                          ))),
                  // NOME
                  Text(
                    widget.item.itemName,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  // PREÇO / UNIDADE
                  Row(
                    children: [
                      Text(
                        utilsService.priceToCurrency(widget.item.price),
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: CustomColors.customSwatchColor),
                      ),
                      Text(
                        ' /${widget.item.unit}',
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        // ICONE ADICIONAR CARRINHO
        Positioned(
          top: 4,
          right: 4,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(15),
              topRight: Radius.circular(20),
            ),
            child: Container(
              height: 40,
              width: 32,
              decoration: BoxDecoration(
                color: CustomColors.customSwatchColor,
              ),
              child: GestureDetector(
                onTap: () {
                  switchIcon();
                  cartController.addItemToCart(item: widget.item);
                  widget.cartAnimationMethod(imageGk);
                },
                child: Icon(
                  tileIcon,
                  color: Colors.black45,
                  size: 30,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
