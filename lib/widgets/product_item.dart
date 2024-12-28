import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/card_provider.dart';
import '../screens/product_detals.dart';
import '../models/product.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cardItem = Provider.of<CartProvider>(context, listen: false);
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(ProductDetals.routeName, arguments: product.id);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: GridTile(
          footer: GridTileBar(
            leading: Consumer<Product>(
              builder: (ctx, pro, child) {
                return IconButton(
                  onPressed: () {
                    pro.changeFavorite();
                  },
                  icon: Icon(
                    pro.isFavorite
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    color: Theme.of(context).primaryColor,
                  ),
                );
              },
            ),
            backgroundColor: Colors.black87,
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              onPressed: () {
                cardItem.addNewCartItem(
                  product.id,
                  product.title,
                  product.imgUrl,
                  product.price,
                );
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text("Successful"),
                    action: SnackBarAction(
                      label: "CANCEL",
                      onPressed: () {
                        cardItem.removeSingleItem(product.id,
                            isCartButton: true);
                      },
                    ),
                  ),
                );
              },
              icon: Icon(
                Icons.shopping_cart_rounded,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          child: Image.network(
            product.imgUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
