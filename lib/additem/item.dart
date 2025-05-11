import 'dart:typed_data';
import 'package:flutter/foundation.dart';

class Item {
  List<Uint8List> images;
  String title;
  String body;
  bool favourite;

  Item({
    required this.images,
    required this.title,
    required this.body,
    required this.favourite,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Item &&
        listEquals(other.images, images) && // compares list content
        other.title == title &&
        other.body == body;
        // Note: We intentionally ignore `favourite` here for identity.
  }

  @override
  int get hashCode =>
      Object.hashAll([
        ...images.map((e) => e.hashCode),
        title,
        body,
      ]);
}
