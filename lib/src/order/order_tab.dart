import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:greengrocer/src/order/controllers/all_orders_controller.dart';

import 'components/order_tile.dart';

class OrderTab extends StatelessWidget {
  const OrderTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        title: const Text('Pedidos'),
      ),
      body: GetBuilder<AllOrdersController>(builder: (controller) {
        return ListView.separated(
            padding: const EdgeInsets.all(16),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (_, index) => OrderTile(
                  order: controller.allOrders[index],
                ),
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemCount: controller.allOrders.length);
      }),
    );
  }
}
