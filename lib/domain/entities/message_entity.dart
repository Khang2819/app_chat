import 'package:equatable/equatable.dart';

enum MessageType { text, image, file, audio }

class MessageEntity extends Equatable {
  final String messagesId;
  final String senderId;
  final String receiverId;
  final String content;
  final MessageType type;
  final DateTime createdAt;
  final bool isRead;
  const MessageEntity({
    required this.messagesId,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.type,
    required this.createdAt,
    required this.isRead,
  });
  @override
  List<Object> get props => [
    messagesId,
    senderId,
    receiverId,
    content,
    type,
    createdAt,
    isRead,
  ];
}
