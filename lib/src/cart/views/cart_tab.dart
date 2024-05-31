import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:greengrocer/src/cart/controllers/cart_controller.dart';
import 'package:greengrocer/src/config/app_data.dart' as data;
import 'package:greengrocer/src/config/custom_colors.dart';

import '../../common/widgets/payment_dialog.dart';
import '../../services/utils_service.dart';
import 'components/cart_tile.dart';

class CartTab extends StatefulWidget {
  const CartTab({super.key});

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  final utilsService = UtilsService();

  // void removeItemfromCart(CartItemModel cartItem) {
  //   setState(() {
  //     data.cartItems.remove(cartItem);
  //     utilsService.myToast(
  //         context: context, msg: 'Item: ${cartItem.item.itemName} removido');
  //   });
  // }

  double cartTotalPrice() {
    double total = 0;
    for (var item in data.cartItems) {
      total += item.totalPrice();
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withAlpha(50),
      appBar: AppBar(
        backgroundColor: CustomColors.customSwatchColor,
        title: const Text('Carrinho'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GetBuilder<CartController>(builder: (controller) {
              return ListView.builder(
                  itemBuilder: (_, index) {
                    return CartTile(
                        cartItem: controller
                            .cartItems[index], //data.cartItems[index],
                        updatedQuantity: (qtd) {
                          if (qtd == 0) {
                            //removeItemfromCart(data.cartItems[index]);
                          } else {
                            setState(
                                () => data.cartItems[index].quantity = qtd);
                          }
                        });
                  },
                  itemCount:
                      controller.cartItems.length //data.cartItems.length,
                  );
            }),
          ),
          const SizedBox(height: 20),
          // DADOS FINAIS
          Container(
            padding: const EdgeInsets.all(16),
            //height: 140,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                    blurRadius: 3, spreadRadius: 2, color: Colors.grey.shade300)
              ],
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //TOTAL GERAL
                const Text('Total geral', style: TextStyle(fontSize: 12)),
                // VALOR TOTAL EM REAIS
                Text(utilsService.priceToCurrency(cartTotalPrice()),
                    style: TextStyle(
                        fontSize: 26,
                        color: CustomColors.customSwatchColor,
                        fontWeight: FontWeight.bold)),
                // BOTÃO CONCLUIR PEDIDO
                SizedBox(
                  height: 45,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.customSwatchColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      onPressed: () async {
                        bool? result = await showOrderConfirmation();
                        if (result ?? false) {
                          if (!context.mounted) return;
                          showDialog(
                              context: context,
                              builder: (_) =>
                                  PaymentDialog(order: data.orders.first));
                        } else {
                          if (!context.mounted) return;
                          utilsService.myToast(
                              isError: true,
                              msg: 'Pedido não confirmado',
                              context: context);
                        }
                      },
                      child: const Text(
                        'Concluir pedido',
                        style: TextStyle(fontSize: 18),
                      )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<bool?> showOrderConfirmation() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Confirmação'),
          content: const Text('Deseja realmente concluir'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('Não')),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
              child: const Text('Sim'),
            )
          ],
        );
      },
    );
  }
}
