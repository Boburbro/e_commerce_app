import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/products.dart';
import 'product_item.dart';



class GridViewItem extends StatelessWidget {
  const GridViewItem({
    super.key,
    required this.showFavoriteItems,
  });

  final bool showFavoriteItems;

  @override
  Widget build(BuildContext context) {
    
    final productsData = Provider.of<Products>(context, listen: false);
    final list = showFavoriteItems ? productsData.favorite :  productsData.items;
    return GridView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: list.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 3 / 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        itemBuilder: (ctx, i) {
          return ChangeNotifierProvider<Product>.value(
            value:list[i],
            child: const ProductItem(),
          );
        });
  }
}