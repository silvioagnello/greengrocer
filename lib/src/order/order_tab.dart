import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/app_data.dart' as data;

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
      body: ListView.separated(
          padding: const EdgeInsets.all(16),
          physics: const BouncingScrollPhysics(),
          itemBuilder: (_, index) => OrderTile(
                order: data.orders[index],
              ),
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemCount: data.orders.length),
    );
  }
}
