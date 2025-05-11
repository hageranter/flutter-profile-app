import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/profile/user.dart';

class userModel extends ChangeNotifier {
  final ImagePicker imagePicker = ImagePicker();
  User? _user;

  User? get user => _user;

  Future<void> imageSelector(ImageSource source) async {
    final XFile? image = await imagePicker.pickImage(source: source);
    if (image != null) {
      final bytes = await image.readAsBytes();
      if (_user != null) {
        _user!.image = bytes;
      } else {
        _user = User(
          name: "Nour Ahmed",
          bio: "Code. Sleep. Eat. Repeat",
          image: bytes,
        );
      }
      notifyListeners();
    }
  }

  void removeImage() {
    _user?.image = null;
    notifyListeners();
  }
}
