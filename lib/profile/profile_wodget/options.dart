
import 'package:flutter/material.dart';

class Options extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onPressesd;

  const Options({
    Key? key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onPressesd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(icon: Icon(icon, color: color), onPressed: onPressesd),
        Text(title),
      ],
    );
  }
}
