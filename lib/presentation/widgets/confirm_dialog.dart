import 'package:flutter/material.dart';

Future<bool?> showConfirmDialog({
  required BuildContext context,
  required String title,
  required String content,
  String cancelText = 'Hủy',
  String confirmText = 'Xác nhận',
  Color confirmColor = Colors.red,
}) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false); // ❌ Hủy
            },
            child: Text(cancelText),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, true); // ✅ Đồng ý
            },
            child: Text(confirmText, style: TextStyle(color: confirmColor)),
          ),
        ],
      );
    },
  );
}
