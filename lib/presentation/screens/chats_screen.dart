import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Chats extends StatelessWidget {
  const Chats({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Message> messages = [
      Message(
        text: "Hey, are we still meeting today?",
        time: "09:42 AM",
        isSentByMe: false,
      ),
      Message(
        text: "",
        time: "09:43 AM",
        isSentByMe: false,
        imageUrl:
            "https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800",
      ),
      Message(text: "Yes, definitely!", time: "09:45 AM", isSentByMe: true),
      Message(
        text: "I'll be there in 10 mins.",
        time: "09:46 AM",
        isSentByMe: true,
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF111318),
        surfaceTintColor: Colors.transparent,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                    'https://jbagy.me/wp-content/uploads/2025/03/Hinh-anh-avatar-nam-anime-7.jpg',
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Khang',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  'Đang hoạt động',
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
              ],
            ),
          ],
        ),
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.call, color: Color(0xFF1E5EFF), size: 30),
              ),
              const SizedBox(width: 1),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.videocam, color: Color(0xFF1E5EFF), size: 30),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topLeft,
            colors: [Color(0xFF101622), Color(0xFF111C34)],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: messages.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2A2A2A),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Today 9:41 AM',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ),
                    );
                  }
                  return MessageBubble(message: messages[index - 1]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Message {
  final String text;
  final String time;
  final bool isSentByMe;
  final String? imageUrl;

  Message({
    required this.text,
    required this.time,
    required this.isSentByMe,
    this.imageUrl,
  });
}

class MessageBubble extends StatelessWidget {
  final Message message;

  const MessageBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment:
            message.isSentByMe
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!message.isSentByMe) ...[
            const CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=33'),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment:
                  message.isSentByMe
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
              children: [
                if (message.imageUrl != null)
                  ClipRRectangle(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      message.imageUrl!,
                      width: 300,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color:
                          message.isSentByMe
                              ? const Color(0xFF2563EB)
                              : const Color(0xFF2A2A2A),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      message.text,
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      message.time,
                      style: const TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                    if (message.isSentByMe) ...[
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.done_all,
                        size: 14,
                        color: Color(0xFF2563EB),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          if (message.isSentByMe) const SizedBox(width: 8),
        ],
      ),
    );
  }
}

class ClipRRectangle extends StatelessWidget {
  final BorderRadius borderRadius;
  final Widget child;

  const ClipRRectangle({
    super.key,
    required this.borderRadius,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(borderRadius: borderRadius, child: child);
  }
}
