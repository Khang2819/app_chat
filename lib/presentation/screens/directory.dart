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
                      onPressed: () {
                        context.push('/search');
                      },
                      color: Color(0xFF1E5EFF),
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
                    CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 46,
                                  height: 46,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFF1565C0),
                                  ),
                                  child: Icon(
                                    Icons.group_add_rounded,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Text(
                                  'Tạo nhóm mới',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Divider(
                            color: const Color(0xFF1C2742),
                            height: 1,
                            indent: 76,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                Container(
                                  width: 46,
                                  height: 46,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFF1565C0),
                                  ),
                                  child: Icon(
                                    Icons.share,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Text(
                                  'Mời bạn bè',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SliverPadding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          sliver: SliverList(
                            delegate: SliverChildListDelegate([
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
                            ]),
                          ),
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
