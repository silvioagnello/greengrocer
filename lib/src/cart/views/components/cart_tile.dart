import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/cart/controllers/cart_controller.dart';
import 'package:greengrocer/src/cart/models/cart_item_model.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/services/utils_service.dart';

import '../../../common/widgets/quantity_widget.dart';

class CartTile extends StatefulWidget {
  final CartItemModel cartItem;
  //final Function(int) updatedQuantity;
  // final Function(CartItemModel) remove;

  const CartTile(
      {super.key, required this.cartItem}); //, required this.updatedQuantity

  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  final UtilsService utilsService = UtilsService();
  final controller = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      color: Colors.white,
      child: ListTile(
          dense: false,
          // IMAGEM
          leading:
              Image.network(widget.cartItem.item.imgUrl, height: 60, width: 60),
          // TITULO
          title: Text(
            widget.cartItem.item.itemName,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          // QUANTIDADE
          trailing: QuantityWidget(
              value: widget.cartItem.quantity,
              suffix: widget.cartItem.item.unit,
              isRemovable: true,
              result: (quantity) {
                controller.changeItemQuantity(
                    item: widget.cartItem, quantity: quantity);
              } //widget.updatedQuantity,
              // {
              //   setState(() {
              //     widget.cartItem.quantity = quantity;
              //     if (quantity == 0) {
              //       widget.remove(widget.cartItem);
              //     }
              //   });
              // }
              ),
          // PREÇO
          subtitle: Text(
              utilsService.priceToCurrency(widget.cartItem.totalPrice()),
              style: TextStyle(
                  color: CustomColors.customSwatchColor,
                  fontWeight: FontWeight.bold))),
    );
  }
}
