import 'package:flutter/material.dart';

import 'user_avatar.dart';

class ChatItem extends StatelessWidget {
  final String name;
  final String message;
  final String time;
  final String? avatar;
  final bool isOnline;
  final bool hasCheck;
  final int unreadCount;
  final VoidCallback onTap;
  const ChatItem({
    super.key,
    this.avatar,
    required this.name,
    required this.message,
    required this.time,
    this.isOnline = false,
    this.hasCheck = false,
    this.unreadCount = 0,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: Stack(
        children: [
          UserAvatar(
            avatar: avatar,
            radius: 28,
            isOnline: isOnline,
            isAdd: false,
          ),
        ],
      ),
      title:
          hasCheck
              ? Text(
                name,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              )
              : Text(name, style: TextStyle(color: Colors.grey[300])),
      subtitle:
          hasCheck
              ? Text(
                message,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              )
              : Text(message, style: TextStyle(color: Colors.grey[700])),
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            time,
            style: TextStyle(
              color: unreadCount > 0 ? Color(0xFF1E5EFF) : Colors.grey,
            ),
          ),
          const SizedBox(height: 6),
          if (unreadCount > 0)
            Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Color(0xFF1E5EFF),
                shape: BoxShape.circle,
              ),
              child: Text(
                '$unreadCount',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
