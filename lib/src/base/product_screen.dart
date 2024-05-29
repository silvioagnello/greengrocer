import 'package:flutter/material.dart';
import 'package:greengrocer/src/base/models/item_model.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/services/utils_service.dart';

import '../common/widgets/quantity_widget.dart';

class ProductScreen extends StatefulWidget {
  final ItemModel item;

  const ProductScreen({super.key, required this.item});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final UtilsService utilsService = UtilsService();

  int cartItemQuantity = 1;

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
                  child: Image.asset(widget.item.imgUrl),
                ),
              ),
              Expanded(
                // CAIXA
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
                      // BOTÃO
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
                          onPressed: () {},
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
