import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final double radius;
  final String? avatar;
  final bool isOnline;
  final bool isAdd;
  const UserAvatar({
    super.key,
    required this.radius,
    this.avatar,
    required this.isOnline,
    required this.isAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: radius,
          backgroundImage: avatar != null ? NetworkImage(avatar!) : null,
          backgroundColor: isAdd ? Color(0xFF1E293B) : null,
          child:
              isAdd ? Icon(Icons.add, size: 30, color: Colors.grey[700]) : null,
        ),
        if (isOnline)
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: radius * 0.45,
              height: radius * 0.45,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
      ],
    );
  }
}
