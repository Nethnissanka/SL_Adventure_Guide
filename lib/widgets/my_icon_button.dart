import 'package:flutter/material.dart';

class MyIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback pressed;
  const MyIconButton({super.key, required this.icon, required this.pressed, required Color color});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: IconButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: const Color.fromARGB(255, 204, 220, 216),
          fixedSize: const Size(40, 40)),
      onPressed: pressed,
      icon: Icon(icon),
    );
  }
}
