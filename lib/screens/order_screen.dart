import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/order_provider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/order_item.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/orders';

  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<OrderProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Buyurtmalar"),
      ),
      body: ListView.builder(
        itemCount: orders.items.length,
        itemBuilder: (ctx, i) {
          final order = orders.items[i];
          return OrderItem(order.totalPrice, order.date, order.products);
        },
      ),
      drawer: const AppDrawer(),
    );
  }
}
