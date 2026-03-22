import 'package:app_chat/domain/entities/friend_request_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core/date_utils.dart';
import '../blocs/friend/friend_bloc.dart';

class Friendrequestscreen extends StatefulWidget {
  const Friendrequestscreen({super.key});

  @override
  State<Friendrequestscreen> createState() => _FriendrequestscreenState();
}

class _FriendrequestscreenState extends State<Friendrequestscreen> {
  @override
  void initState() {
    super.initState();
    // Kích hoạt load dữ liệu khi vào màn hình
    context.read<FriendBloc>().add(LoadIncomingRequests());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101622),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: const Color(0xFF101622),
        title: const Text(
          'Lời mời kết bạn',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: BlocBuilder<FriendBloc, FriendState>(
        builder: (context, state) {
          if (state is FriendLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          List<FriendRequestEntity> requests = [];
          if (state is FriendRequestLoaded) {
            requests = state.incomingRequests;
          }

          // Phân loại lời mời theo thời gian
          final todayRequests =
              requests.where((u) => DateHelper.isToday(u.createdAt)).toList();
          final olderRequests =
              requests.where((u) => !DateHelper.isToday(u.createdAt)).toList();

          return CustomScrollView(
            slivers: [
              // Header luôn luôn hiển thị
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildHeaderWidgets(requests.length),
                ),
              ),

              // Trường hợp không có lời mời nào
              if (requests.isEmpty)
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.inbox, size: 70, color: Colors.white30),
                        SizedBox(height: 12),
                        Text(
                          'Không có lời mời nào',
                          style: TextStyle(color: Colors.white54, fontSize: 16),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Hãy kết nối với bạn bè mới',
                          style: TextStyle(color: Colors.white38, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                )
              else ...[
                // Hiển thị lời mời hôm nay nếu có
                if (todayRequests.isNotEmpty) ...[
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Text(
                        'Hôm nay',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) =>
                            _buildRequestItem(context, todayRequests[index]),
                        childCount: todayRequests.length,
                      ),
                    ),
                  ),
                ],

                // Hiển thị lời mời cũ hơn nếu có
                if (olderRequests.isNotEmpty) ...[
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
                      child: Text(
                        'Trước đó',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) =>
                            _buildRequestItem(context, olderRequests[index]),
                        childCount: olderRequests.length,
                      ),
                    ),
                  ),
                ],
                const SliverToBoxAdapter(child: SizedBox(height: 20)),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeaderWidgets(int count) {
    return Row(
      children: [
        Expanded(
          child: _headerCard(
            'PENDING',
            '$count',
            'New requests',
            const Color(0xFF1E1E1E),
            const Color(0xFF1877F2),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _headerCard(
            'DISCOVERY',
            '',
            'Find more friends',
            const Color(0xFF1877F2),
            Colors.white,
            isIcon: true,
          ),
        ),
      ],
    );
  }

  Widget _headerCard(
    String title,
    String value,
    String sub,
    Color bg,
    Color valColor, {
    bool isIcon = false,
  }) {
    return Container(
      height: 130,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
          const Spacer(),
          isIcon
              ? const Icon(Icons.person_add, color: Colors.white, size: 36)
              : Text(
                value,
                style: TextStyle(
                  color: valColor,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  height: 1,
                ),
              ),
          const SizedBox(height: 4),
          Text(
            sub,
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestItem(BuildContext context, FriendRequestEntity request) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
              request.avatar ?? 'https://via.placeholder.com/150',
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  request.fullName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Text(
                  'Muốn kết bạn với bạn',
                  style: TextStyle(color: Colors.white54, fontSize: 13),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: _actionButton(
                        'Chấp nhận',
                        const Color(0xFF1877F2),
                        () => context.read<FriendBloc>().add(
                          AcceptFriendRequest(request.fromId),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _actionButton(
                        'Từ chối',
                        const Color(0xFF2A2A2A),
                        () => context.read<FriendBloc>().add(
                          DeleteFriendRequest(request.fromId),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton(String text, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 36,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
