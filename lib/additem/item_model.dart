import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/additem/item.dart';

class ItemModel extends ChangeNotifier {
  final List<Item> _items = [];
  List<Item> get items => _items;

  void addItem(Item item) {
    _items.add(item);
    notifyListeners();
  }

  ImagePicker imagePicker = ImagePicker();
  List<Uint8List> selectedImages = [];

  Future<void> imageSelector() async {
    final List<XFile>? images = await imagePicker.pickMultiImage();
    if (images != null) {
      final bytesList = await Future.wait(
        images.map((file) => file.readAsBytes()),
      );

      selectedImages.addAll(bytesList);
      ;
      notifyListeners();
    }
  }

  void removeImage(Uint8List image) {
    selectedImages.remove(image);
    notifyListeners();
  }

  Item? _selectedItem;
  Item? get selectedItem => _selectedItem;

  selectItem(Item item) {
    _selectedItem = item;
    notifyListeners();
  }
}
