import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:greengrocer/src/cart/models/cart_item_model.dart';
import 'package:greengrocer/src/order/controllers/order_controller.dart';
import 'package:greengrocer/src/order/models/order_model.dart';
import 'package:greengrocer/src/services/utils_service.dart';

import '../../common/widgets/payment_dialog.dart';
import 'order_status.dart';

class OrderTile extends StatelessWidget {
  final OrderModel order;
  OrderTile({super.key, required this.order});

  final UtilsService utilsService = UtilsService();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: GetBuilder<OrderController>(
            init: OrderController(order),
            global: false,
            builder: (controller) {
              return ExpansionTile(
                onExpansionChanged: (v) {
                  if (v && order.items.isEmpty) {
                    controller.getOrderItems();
                  }
                },
                initiallyExpanded: false, //order.status == 'pending_payment',
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Pedido ${order.id}'),
                    Text(
                      utilsService.formatDateTime(order.createdDateTime!),
                      style: const TextStyle(fontSize: 12, color: Colors.black),
                    )
                  ],
                ),
                childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
                children: controller.isLoading
                    ? [
                        Container(
                          height: 80,
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(),
                        )
                      ]
                    : [
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: SizedBox(
                                  height: 150,
                                  child: ListView(
                                    children: order.items.map((orderItem) {
                                      return OrderItem(
                                          orderItem: orderItem,
                                          utilsService: utilsService);
                                    }).toList(),
                                  ),
                                ),
                              ),
                              VerticalDivider(
                                  color: Colors.grey.shade300,
                                  thickness: 2,
                                  width: 18),
                              Expanded(
                                  flex: 3,
                                  child: OrderStatus(
                                    status: order.status,
                                    isOverDue: order.overdueDateTime
                                        .isBefore(DateTime.now()),
                                  ))
                            ],
                          ),
                        ),
                        //TOTAL
                        Text.rich(
                          TextSpan(
                            style: const TextStyle(fontSize: 20),
                            children: [
                              const TextSpan(
                                  text: 'Total ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: utilsService
                                      .priceToCurrency(order.total)),
                            ],
                          ),
                        ),
                        // BOTÃO Ver QR Code PIX
                        Visibility(
                          visible: order.status == 'pending_payment' &&
                              !order.isOverDue,
                          child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                              ),
                              icon: const Icon(Icons.pix),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) =>
                                        PaymentDialog(order: order));
                              },
                              label: const Text('Ver QR Code PIX')),
                        )
                      ],
              );
            }),
      ),
    );
  }
}

class OrderItem extends StatelessWidget {
  const OrderItem(
      {super.key, required this.utilsService, required this.orderItem});

  final UtilsService utilsService;
  final CartItemModel orderItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            '${orderItem.quantity} ${orderItem.item.unit} ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(orderItem.item.itemName),
          ),
          Text(utilsService.priceToCurrency(orderItem.item.price)),
        ],
      ),
    );
  }
}
