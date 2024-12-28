// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../providers/card_provider.dart';

class CartListItem extends StatelessWidget {
  const CartListItem({
    required this.proId,
    required this.imgUrl,
    required this.title,
    required this.price,
    required this.quantity,
    super.key,
  });
  final String proId;
  final String imgUrl;
  final String title;
  final double price;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final _cart = Provider.of<CartProvider>(context);
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: .4,
        motion: const ScrollMotion(),
        children: [
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
            
              // primary: Theme.of(context).colorScheme.error,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            ),
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
                          _cart.removeItem(proId);
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
            icon: const Icon(Icons.delete_forever_rounded),
            label: const Text("Delete"),
          )
        ],
      ),
      key: ValueKey(proId),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(imgUrl),
          ),
          title: Text(title),
          subtitle: Text(
            "Umumiy: \$ ${price * quantity}",
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: () => _cart.removeSingleItem(proId),
                  icon: const Icon(Icons.remove, color: Colors.black)),
              Chip(label: Text(quantity.toString())),
              IconButton(
                  onPressed: () =>
                      _cart.addNewCartItem(proId, title, imgUrl, price),
                  icon: const Icon(Icons.add, color: Colors.black)),
            ],
          ),
        ),
      ),
    );
  }
}
