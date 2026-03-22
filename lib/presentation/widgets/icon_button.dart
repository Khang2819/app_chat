import 'package:flutter/material.dart';

class CircleIconButton extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final VoidCallback? onPressed;

  const CircleIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: const BoxDecoration(
        color: Color(0xFF101D37),
        shape: BoxShape.circle,
      ),
      child: IconButton(onPressed: onPressed, icon: Icon(icon, color: color)),
    );
  }
}
