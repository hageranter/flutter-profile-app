import 'package:flutter/material.dart';
import 'package:myapp/additem/item_model.dart';
import 'package:myapp/favourite/favourite_model.dart';
import 'package:provider/provider.dart';

class FavWidgit extends StatelessWidget {
  final int index;

  const FavWidgit({required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ItemModel, FavoriteModel>(
      builder: (context, itemModel, favModel, child) {
        final currentItem = itemModel.items[index];
        final isFav = favModel.isFavorite(currentItem);

        return IconButton(
          onPressed: () {
            if (isFav) {
              favModel.removeItem(currentItem);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Removed from favourites")),
              );
            } else {
              favModel.addItem(currentItem);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Added to favourites")),
              );
            }
          },
          icon: Icon(
            isFav ? Icons.favorite : Icons.favorite_border,
            color: isFav ? Colors.red : Colors.grey,
          ),
        );
      },
    );
  }
}
