import 'dart:typed_data';

class User {
  String bio;
  Uint8List? image;
  String name;

  User({required this.name, required this.bio, required this.image});
}
