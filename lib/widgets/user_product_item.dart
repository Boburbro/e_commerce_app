// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/products.dart';
import '../screens/edit_product.dart';

class UserProductItem extends StatelessWidget {
  const UserProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    return Card(
      child: ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(product.imgUrl)),
        title: Text(product.title),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(EditProduct.routeName, arguments: product.id);
                },
                icon: Icon(
                  Icons.mode_edit_outline_rounded,
                  color: Theme.of(context).primaryColor,
                )),
            IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text("Bekor qilish"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Provider.of<Products>(context, listen: false)
                                  .deleteById(product.id);
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              // primary: Theme.of(context).errorColor,
                            ),
                            child: const Text("Ha!"),
                          )
                        ],
                        title: const Text("Ishonchingiz komilmi?"),
                        content: const Text("Bu element o'chmoqda"),
                      );
                    },
                  );
                },
                icon: Icon(
                  Icons.delete_forever_rounded,
                  // color: Theme.of(context).errorColor,
                )),
          ],
        ),
      ),
    );
  }
}
