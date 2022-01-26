import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final Color color;
  final String text;
  const CustomIconButton({Key? key, required this.text, required this.onPressed, required this.icon, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(text),
      style: ElevatedButton.styleFrom(
          primary: color,minimumSize: const Size(100, 45)),
    );
  }
}
