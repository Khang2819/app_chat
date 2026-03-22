import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../blocs/search/search_bloc.dart';
import '../widgets/chat_item.dart';
import '../widgets/recent_search_item.dart';
import '../widgets/search_textfield.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<SearchBloc>().add(SearchLoad());
  }

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
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: CustomScrollView(
          slivers: [
            /// Search box
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 12),

                    SearchTextfield(
                      icon: Icons.search,
                      text: 'Tìm kiếm hoặc @username...',
                      autofocus: true,
                      controller: searchController,
                      onChanged: (query) {
                        context.read<SearchBloc>().add(SearchQuery(query));
                      },
                      onSubmitted: (query) {
                        context.read<SearchBloc>().add(SaveHistoryEvent(query));
                      },
                    ),
                    const SizedBox(height: 15),
                    Container(height: 0.5, color: Colors.white24),

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
                          onPressed: () {
                            context.read<SearchBloc>().add(ClearSearch());
                          },
                          child: const Text(
                            'Xóa tất cả',
                            style: TextStyle(color: Colors.blueAccent),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),

            /// Recent search horizontal list
            SliverToBoxAdapter(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  List<String> history = [];
                  if (state is SearchLoaded) {
                    history = state.recentQueries;
                  }
                  if (history.isEmpty) return const SizedBox.shrink();
                  return SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: history.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: RecentSearchItem(
                            username: history[index],
                            onTap: () {
                              searchController.text = history[index];
                              context.read<SearchBloc>().add(
                                SearchQuery(history[index]),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),

            /// Title suggest
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: const [
                    SizedBox(height: 15),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Kết quả cho bạn',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),

            /// User list
            BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state is SearchLoading) {
                  return SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (state is SearchLoaded) {
                  final users = state.users;
                  if (searchController.text.isEmpty) {
                    return _buildInitialSearchUI();
                  }
                  if (state.users.isEmpty) {
                    return const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.person, color: Colors.white30, size: 64),
                            SizedBox(height: 12),
                            Text(
                              "Không tìm thấy người dùng",
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final user = state.users[index];
                        return ChatItem(
                          name: user.fullName,
                          message: 'Xin chào, Thằng Loll nha?',
                          time: '10:45',
                          avatar:
                              'https://cellphones.com.vn/sforum/wp-content/uploads/2024/01/avartar-anime-6.jpg',
                          unreadCount: 2,
                          isOnline: true,
                          hasCheck: true,
                          onTap: () {},
                        );
                      }, childCount: users.length),
                    ),
                  );
                }
                return _buildInitialSearchUI();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInitialSearchUI() {
    return const SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history, size: 64, color: Colors.white30),
            SizedBox(height: 12),
            Text(
              'Bắt đầu tìm kiếm',
              style: TextStyle(color: Colors.white54, fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              'Nhập tên hoặc @username để tìm bạn bè',
              style: TextStyle(color: Colors.white38, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
