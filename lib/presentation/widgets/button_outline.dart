import 'package:flutter/material.dart';

class ButtonOutline extends StatelessWidget {
  final String text;
  final IconData icon;
  const ButtonOutline({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 0.5, color: Colors.white54),
        color: Color(0xFF1A2233),
      ),
      child: TextButton.icon(
        onPressed: () {},
        icon: Icon(icon, color: Colors.white54),
        label: Text(
          text,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
