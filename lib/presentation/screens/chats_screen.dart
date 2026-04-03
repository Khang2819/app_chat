import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/chat_entity.dart';
import '../../domain/repositories/user_entity.dart';
import '../blocs/chat/chat_bloc.dart';

class Chats extends StatefulWidget {
  final UserEntity receiver;

  const Chats({super.key, required this.receiver});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  final TextEditingController _messageController = TextEditingController();
  final String currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';
  late String roomId;

  @override
  void initState() {
    super.initState();
    // Tạo roomId đơn giản bằng cách ghép 2 ID (nên sort để luôn ra 1 ID duy nhất cho 2 người)
    List<String> ids = [currentUserId, widget.receiver.userId];
    ids.sort();
    roomId = ids.join('_');

    // Load tin nhắn
    context.read<ChatBloc>().add(LoadMessages(roomId));
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    final chat = ChatEntity(
      roomId: roomId,
      senderId: currentUserId,
      content: _messageController.text.trim(),
      timestamp: DateTime.now(),
      type: MessageType.text,
    );

    context.read<ChatBloc>().add(SendMessage(chat));
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF111318),
        title: Text(
          widget.receiver.fullName,
          style: const TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topLeft,
            colors: [Color(0xFF101622), Color(0xFF111C34)],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  if (state is ChatLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is ChatLoade) {
                    final messages = state.chats;
                    return ListView.builder(
                      reverse: true, // Hiển thị tin mới nhất ở dưới
                      padding: const EdgeInsets.all(16),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final msg = messages[index];
                        return MessageBubble(
                          message: msg,
                          isMe: msg.senderId == currentUserId,
                        );
                      },
                    );
                  }
                  return const Center(
                    child: Text(
                      "Bắt đầu cuộc trò chuyện",
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: const Color(0xFF111318),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Nhập tin nhắn...",
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: const Color(0xFF1A2233),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: _sendMessage,
            icon: const Icon(Icons.send, color: Color(0xFF1E5EFF)),
          ),
        ],
      ),
    );
  }
}

// Cập nhật lại MessageBubble để nhận ChatEntity
class MessageBubble extends StatelessWidget {
  final ChatEntity message;
  final bool isMe;

  const MessageBubble({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isMe ? const Color(0xFF1E5EFF) : const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          message.content,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
