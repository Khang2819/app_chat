import 'package:flutter/material.dart';

class Textfield extends StatefulWidget {
  final String hint;
  final IconData icon;
  final TextEditingController controller;
  final bool isPassword;
  const Textfield({
    super.key,
    required this.hint,
    required this.icon,
    required this.controller,
    this.isPassword = false,
  });

  @override
  State<Textfield> createState() => _TextfieldState();
}

class _TextfieldState extends State<Textfield> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.isPassword ? _obscureText : false,
      style: TextStyle(color: Colors.white),
      focusNode: _focusNode,
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: TextStyle(color: Colors.white54),
        filled: true,
        fillColor: const Color(0xFF1A2233),
        prefixIcon: Icon(
          widget.icon,
          color: _isFocused ? const Color(0xFF135BEC) : Colors.white54,
          size: 25,
        ),
        suffixIcon:
            widget.isPassword
                ? IconButton(
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  icon: Icon(
                    _obscureText
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: Colors.grey.shade600,
                    size: 22,
                  ),
                )
                : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: Colors.white54),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: Colors.white54, width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: Color(0xFF135BEC), width: 2),
        ),
      ),
    );
  }
}
