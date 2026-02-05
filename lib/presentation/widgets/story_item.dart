import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class StoryItem extends StatelessWidget {
  final String? avatar;
  final String name;
  final bool isAdd;
  final bool isOnline;
  final VoidCallback onTap;
  const StoryItem({
    super.key,
    this.avatar,
    required this.name,
    this.isAdd = false,
    this.isOnline = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final avatarWidget = CircleAvatar(
      radius: 32,
      backgroundColor: isAdd ? Color(0xFF1E293B) : null,
      backgroundImage: avatar != null ? NetworkImage(avatar!) : null,
      child: isAdd ? Icon(Icons.add, size: 30, color: Colors.grey[700]) : null,
    );
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(right: 16, top: 5),
        child: Column(
          children: [
            Stack(
              children: [
                isAdd
                    ? DottedBorder(
                      options: CircularDottedBorderOptions(
                        dashPattern: [10, 5],
                        color: Color(0xFF334155),
                        strokeWidth: 2,
                        padding: EdgeInsets.all(1),
                      ),
                      child: avatarWidget,
                    )
                    : avatarWidget,
                if (isOnline)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 6),
            SizedBox(
              width: 70,
              child: Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
