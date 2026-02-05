import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/chat_item.dart';
import '../widgets/icon_button.dart';
import '../widgets/search_textfield.dart';

class Directory extends StatelessWidget {
  Directory({super.key});
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topLeft,
            colors: [Color(0xFF101622), Color(0xFF111C34)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Danh bạ',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CircleIconButton(
                      onPressed: () {},
                      icon: Icons.person_add_alt_1_rounded,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: SearchTextfield(
                  icon: Icons.search,
                  text: 'Tìm kiếm liên hệ...',
                  controller: searchController,
                  onTap: () => context.push('/search'),
                  readOnly: true,
                  canRequestFocus: false,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Stack(
                  children: [
                    ListView(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        ChatItem(
                          name: 'Nguyễn Văn Khang',
                          message: 'Xin chào, Thằng Loll nha?',
                          time: '10:45',
                          avatar:
                              'https://cellphones.com.vn/sforum/wp-content/uploads/2024/01/avartar-anime-6.jpg',
                          unreadCount: 2,
                          isOnline: true,
                          hasCheck: true,
                          onTap: () {},
                        ),

                        ChatItem(
                          name: 'Nguyễn Văn Khang',
                          message: 'Xin chào, Thằng Loll nha?',
                          time: '10:45',
                          avatar:
                              'https://cellphones.com.vn/sforum/wp-content/uploads/2024/01/avartar-anime-6.jpg',
                          unreadCount: 2,
                          isOnline: true,
                          hasCheck: true,
                          onTap: () {},
                        ),
                        ChatItem(
                          name: 'Nguyễn Văn Khang',
                          message: 'Xin chào, Thằng Loll nha?',
                          time: '10:45',
                          avatar:
                              'https://cellphones.com.vn/sforum/wp-content/uploads/2024/01/avartar-anime-6.jpg',
                          unreadCount: 2,
                          isOnline: true,
                          hasCheck: true,
                          onTap: () {},
                        ),
                        ChatItem(
                          name: 'Nguyễn Văn Khang',
                          message: 'Xin chào, Thằng Loll nha?',
                          time: '10:45',
                          avatar:
                              'https://cellphones.com.vn/sforum/wp-content/uploads/2024/01/avartar-anime-6.jpg',
                          unreadCount: 2,
                          isOnline: true,
                          hasCheck: true,
                          onTap: () {},
                        ),
                        ChatItem(
                          name: 'Nguyễn Văn Khang',
                          message: 'Xin chào, Thằng Loll nha?',
                          time: '10:45',
                          avatar:
                              'https://cellphones.com.vn/sforum/wp-content/uploads/2024/01/avartar-anime-6.jpg',
                          unreadCount: 2,
                          isOnline: true,
                          hasCheck: true,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
