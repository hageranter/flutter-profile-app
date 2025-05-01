
import 'package:flutter/material.dart';
class FavWidgit extends StatefulWidget {
  const FavWidgit({super.key});

  @override
  State<FavWidgit> createState() => _FavWidgitState();
}

class _FavWidgitState extends State<FavWidgit> {
  // Suggested code may be subject to a license. Learn more: ~LicenseLog:1131497166.
  bool click = false;
  @override
  Widget build(BuildContext context) {

    return IconButton(
      onPressed: () {
        setState(() {
          click = !click;
        });
      },
      icon: Icon(Icons.favorite, color: click ? Colors.red : Colors.grey),
    );
  }
}