import 'package:e_commerce_app/providers/card_provider.dart';
import 'package:e_commerce_app/screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

class ProductDetals extends StatelessWidget {
  static const routeName = "product-detals";

  const ProductDetals({super.key});

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments;
    final product = Provider.of<Products>(context, listen: false)
        .findById(productId as String);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(product.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 300,
              child: Image.network(
                product.imgUrl,
                fit: BoxFit.cover,
              ),
            ),
            Padding(padding: const EdgeInsets.all(16), child: Text(product.des))
          ],
        ),
      ),
      bottomSheet: BottomAppBar(
        child: Container(
          padding: const EdgeInsets.all(16),
          height: 90,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Narxi:",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    "\$${product.price}",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Consumer<CartProvider>(
                builder: (ctx, cartP, child) {
                  final isAdded = cartP.items.containsKey(productId);
                  if (isAdded) {
                    return ElevatedButton.icon(
                      onPressed: () =>
                          Navigator.of(context).pushNamed(CartScreen.routeName),
                      icon: const Icon(
                        Icons.shopping_bag_outlined,
                        color: Colors.black,
                      ),
                      label: const Text(
                        "SAVATCHAGA BORISH",
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade300, elevation: 0),
                    );
                  } else {
                    return ElevatedButton(
                      onPressed: () {
                        cartP.addNewCartItem(
                          product.id,
                          product.title,
                          product.imgUrl,
                          product.price,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text("SAVATCHAGA QO'SHISH"),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
