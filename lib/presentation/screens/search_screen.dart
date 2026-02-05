import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/chat_item.dart';
import '../widgets/recent_search_item.dart';
import '../widgets/search_textfield.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final TextEditingController searchController = TextEditingController();
  final List<String> recentUsers = [
    'Alex Rivera',
    'NguyenVanKhangRatDai',
    'FlutterBloc',
    'FirebaseAuthUser123',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101622),
      appBar: AppBar(
        backgroundColor: const Color(0xFF101622),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Tìm kiếm',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            const SizedBox(height: 12),

            SearchTextfield(
              icon: Icons.search,
              text: 'Tìm kiếm hoặc @username...',
              autofocus: true,
              controller: searchController,
            ),

            const SizedBox(height: 15),
            // ignore: deprecated_member_use
            Container(height: 0.5, color: Colors.white.withOpacity(0.1)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Tìm kiếm gần đây',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Xóa tất cả',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: recentUsers.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: RecentSearchItem(
                      username: recentUsers[index],
                      onTap: () {},
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 15),
            const Text(
              'Gợi ý cho bạn',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

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
      ),
    );
  }
}
