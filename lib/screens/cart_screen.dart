import 'package:e_commerce_app/providers/card_provider.dart';
import 'package:e_commerce_app/providers/order_provider.dart';
import 'package:e_commerce_app/widgets/cart_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Sizning savatchangiz"),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Umumiy: ",
                    // ignore: deprecated_member_use
                    style: TextStyle(fontSize: 16),
                  ),
                  const Spacer(),
                  Chip(
                    label: Text(
                      "\$${cartData.totalPrice}",
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  TextButton(
                      onPressed: () {
                        Provider.of<OrderProvider>(context, listen: false)
                            .addNewOrder(
                          cartData.items.values.toList(),
                          cartData.totalPrice,
                        );
                        cartData.clearItems();
                      },
                      child: const Text("Buyurtma berish"))
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cartData.items.length,
              itemBuilder: (c, i) {
                final cartItem = cartData.items.values.toList()[i];
                return CartListItem(
                  proId: cartData.items.keys.toList()[i],
                  imgUrl: cartItem.imgUrl,
                  title: cartItem.title,
                  price: cartItem.price,
                  quantity: cartItem.quantity,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
