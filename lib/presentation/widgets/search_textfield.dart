import 'package:flutter/material.dart';

class SearchTextfield extends StatelessWidget {
  final IconData icon;
  final String text;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final bool readOnly;
  final bool autofocus;
  final bool canRequestFocus;
  const SearchTextfield({
    super.key,
    required this.icon,
    required this.text,
    this.controller,
    this.readOnly = false,
    this.autofocus = false,
    this.canRequestFocus = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: TextStyle(color: Colors.white),
      readOnly: readOnly,
      autofocus: autofocus,
      canRequestFocus: canRequestFocus,
      onTap: onTap,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFF1A2233),
        hintText: text,
        hintStyle: TextStyle(color: Colors.white54),
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.white54),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.white54, width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Color(0xFF135BEC), width: 2),
        ),
      ),
    );
  }
}
