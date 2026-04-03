import 'package:equatable/equatable.dart';

enum MessageType { text, image, video }

class ChatEntity extends Equatable {
  final String? id;
  final String roomId;
  final String senderId;
  final String content;
  final DateTime timestamp;
  final MessageType type;
  final bool isRead;

  const ChatEntity({
    this.id,
    required this.roomId,
    required this.senderId,
    required this.content,
    required this.timestamp,
    required this.type,
    this.isRead = false,
  });
  @override
  List<Object?> get props => [
    id,
    roomId,
    senderId,
    content,
    timestamp,
    type,
    isRead,
  ];
}
