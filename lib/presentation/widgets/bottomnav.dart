import 'package:flutter/material.dart';

class Bottomnav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  const Bottomnav({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final int countnotifications = 8;
    final int countMessenger = 10;
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF101622),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        backgroundColor: Colors.transparent,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF1E5EFF),
        unselectedItemColor: Colors.grey,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: Badge(
              isLabelVisible: countMessenger > 0,
              backgroundColor: Colors.red,
              label: Text(countMessenger > 9 ? '+9' : '$countMessenger'),
              child: Icon(Icons.messenger),
            ),
            label: 'Tin nhắn',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.contacts_rounded),
            label: 'Danh bạ',
          ),
          BottomNavigationBarItem(
            icon: Badge(
              backgroundColor: Colors.red,
              isLabelVisible: countnotifications > 0,
              label: Text(
                countnotifications > 9 ? '+9' : '$countnotifications',
              ),
              child: const Icon(Icons.notifications),
            ),
            label: 'Thông báo',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Khám phá',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Cá nhân',
          ),
        ],
      ),
    );
  }
}
