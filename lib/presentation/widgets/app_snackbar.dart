import 'package:flutter/material.dart';

enum SnackbarType { success, error, info }

class AppSnackbar {
  static void show(
    BuildContext context, {
    required String message,
    SnackbarType type = SnackbarType.success,
  }) {
    Color bgColor;
    IconData icon;

    switch (type) {
      case SnackbarType.success:
        bgColor = Colors.green;
        icon = Icons.check_circle;
        break;
      case SnackbarType.error:
        bgColor = Colors.red;
        icon = Icons.error;
        break;
      default:
        bgColor = Colors.blue;
        icon = Icons.info;
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}
