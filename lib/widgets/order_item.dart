import 'package:e_commerce_app/models/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderItem extends StatefulWidget {
  const OrderItem(this.totalPrice, this.date, this.products, {super.key});

  final double totalPrice;
  final DateTime date;
  final List<CartItem> products;

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _expandItems = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          ListTile(
            title: Text("\$${widget.totalPrice}"),
            subtitle: Text(DateFormat('dd/MM/yyyy hh:mm').format(widget.date)),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  _expandItems = !_expandItems;
                });
              },
              icon: _expandItems
                  ? const Icon(Icons.expand_less_outlined)
                  : const Icon(Icons.expand_more_outlined),
            ),
          ),
          if (_expandItems)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
              height: widget.products.length * 25,
              child: ListView.builder(
                  itemExtent: 23,
                  itemCount: widget.products.length,
                  itemBuilder: (ctx, index) {
                    final product = widget.products[index];
                    return ListTile(
                      title: Text(product.title,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      trailing: Text(
                        "x${product.quantity} \$${product.price}",
                        style: const TextStyle(color: Colors.grey),
                      ),
                    );
                  }),
            )
        ],
      ),
    );
  }
}
