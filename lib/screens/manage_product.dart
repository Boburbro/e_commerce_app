import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/edit_product.dart';
import '../widgets/app_drawer.dart';
import '../widgets/user_product_item.dart';
import '../providers/products.dart';

class ManageProduct extends StatelessWidget {
  static const routeName = "/manage_product";

  const ManageProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final productsModel = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Product"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditProduct.routeName);
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
          padding: const EdgeInsets.all(15),
          itemCount: productsModel.items.length,
          itemBuilder: (ctx, index) {
            final product = productsModel.items[index];
            return ChangeNotifierProvider.value(
              value: product,
              child: const UserProductItem(),
            );
          }),
    );
  }
}
