import 'package:flutter/material.dart';

class RecentSearchItem extends StatelessWidget {
  final String username;
  final VoidCallback onTap;
  const RecentSearchItem({
    super.key,
    required this.username,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFF1A2233),
      ),
      child: Row(
        children: [
          Icon(Icons.history, color: Color(0xFF64748B), size: 17),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              username,
              style: TextStyle(color: Colors.white, fontSize: 15),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
