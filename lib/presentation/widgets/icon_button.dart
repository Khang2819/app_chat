import 'package:flutter/material.dart';

class CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const CircleIconButton({super.key, required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: const BoxDecoration(
        color: Color(0xFF101D37),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: Color(0xFF1E5EFF)),
      ),
    );
  }
}
