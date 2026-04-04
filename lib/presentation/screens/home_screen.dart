import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../blocs/home/home_bloc.dart';
import '../blocs/home/home_event.dart';
import '../blocs/home/home_state.dart';
import '../widgets/chat_item.dart';
import '../widgets/search_textfield.dart';
import '../widgets/story_item.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF101622), Color(0xFF111C34)],
              begin: Alignment.bottomCenter,
              end: Alignment.topLeft,
            ),
          ),
          child: SafeArea(
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: Color(0xFF1E5EFF)),
                  );
                }
                if (state is HomeLoaded) {
                  return Column(
                    children: [
                      // Header Section
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Trò chuyện',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.camera_alt,
                                  color: Color(0xFF1E5EFF),
                                ),
                                SizedBox(width: 15),
                                Icon(
                                  Icons.edit_document,
                                  color: Color(0xFF1E5EFF),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Search Section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SearchTextfield(
                          icon: Icons.search,
                          text: 'Tìm kiếm',
                          readOnly: true,
                          canRequestFocus: false,
                          onTap: () => context.push('/search'),
                        ),
                      ),

                      Expanded(
                        child: DefaultTabController(
                          length: 3,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: TabBar(
                                  dividerColor: Colors.transparent,
                                  isScrollable: true,
                                  tabAlignment: TabAlignment.start,
                                  labelColor: const Color(0xFF1E5EFF),
                                  unselectedLabelColor: const Color(0xFF113987),
                                  indicatorColor: const Color(0xFF1E5EFF),
                                  labelPadding: const EdgeInsets.only(
                                    right: 20,
                                  ),
                                  tabs: const [
                                    Tab(text: 'Tất cả'),
                                    Tab(text: 'Chưa đọc'),
                                    Tab(text: 'Nhóm'),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                height: 100,
                                child: ListView.builder(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: state.onlineUsers.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index == 0) {
                                      return StoryItem(
                                        isAdd: true,
                                        name: 'Thêm',
                                        onTap: () {},
                                      );
                                    }
                                    final user = state.onlineUsers[index - 1];
                                    return StoryItem(
                                      avatar: user.avatar,
                                      name: user.fullName,
                                      isOnline: user.isOnline,
                                      onTap:
                                          () => context.push(
                                            '/chat',
                                            extra: user,
                                          ),
                                    );
                                  },
                                ),
                              ),

                              const SizedBox(height: 20),

                              Expanded(
                                child: TabBarView(
                                  children: [
                                    state.chats.isEmpty
                                        ? const Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.chat_bubble_outline,
                                                size: 64,
                                                color: Colors.white30,
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                'Không có cuộc trò chuyện nào',
                                                style: TextStyle(
                                                  color: Colors.white54,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                'Bắt đầu nhắn tin với bạn bè',
                                                style: TextStyle(
                                                  color: Colors.white38,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                        : ListView.builder(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                          ),
                                          itemCount: state.chats.length,
                                          itemBuilder: (context, index) {
                                            final chatUser = state.chats[index];
                                            return ChatItem(
                                              name: chatUser.fullName,
                                              message: 'Bắt đầu nhắn tin...',
                                              time: '10:45',
                                              avatar: chatUser.avatar,
                                              unreadCount: 0,
                                              isOnline: chatUser.isOnline,
                                              hasCheck: false,
                                              onTap:
                                                  () => context.push(
                                                    '/chat',
                                                    extra: chatUser,
                                                  ),
                                            );
                                          },
                                        ),
                                    const Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.mark_chat_unread_outlined,
                                            size: 64,
                                            color: Colors.white30,
                                          ),
                                          SizedBox(height: 12),
                                          Text(
                                            'Không có tin nhắn chưa đọc',
                                            style: TextStyle(
                                              color: Colors.white54,
                                              fontSize: 16,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            'Bạn đã đọc hết tất cả tin nhắn',
                                            style: TextStyle(
                                              color: Colors.white38,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.groups_outlined,
                                            size: 64,
                                            color: Colors.white30,
                                          ),
                                          SizedBox(height: 12),
                                          Text(
                                            'Chưa có nhóm nào',
                                            style: TextStyle(
                                              color: Colors.white54,
                                              fontSize: 16,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            'Tạo hoặc tham gia nhóm chat',
                                            style: TextStyle(
                                              color: Colors.white38,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
                if (state is HomeError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 48,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Lỗi: ${state.message}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        TextButton(
                          onPressed:
                              () => context.read<HomeBloc>().add(HomeLoad()),
                          child: const Text("Thử lại"),
                        ),
                      ],
                    ),
                  );
                }
                return const Center(
                  child: Text(
                    'Không thể tải dữ liệu',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
