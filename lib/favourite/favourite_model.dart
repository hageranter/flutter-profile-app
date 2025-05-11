import 'package:flutter/material.dart';
import 'package:myapp/additem/item.dart'; // Update with your actual item model path

class FavoriteModel extends ChangeNotifier {
  final List<Item> _fav = [];

  List<Item> get fav => _fav;

  void addItem(Item item) {
    if (!_fav.contains(item)) {
      _fav.add(item);
      notifyListeners();
    }
  }

  void removeItem(Item item) {
    _fav.remove(item);
    notifyListeners();
  }

  bool isFavorite(Item item) {
    return _fav.contains(item);
  }
}
