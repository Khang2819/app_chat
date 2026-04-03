import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/chat_entity.dart';

class ChatModel extends ChatEntity {
  const ChatModel({
    super.id,
    required super.roomId,
    required super.senderId,
    required super.content,
    required super.timestamp,
    required super.type,
    super.isRead = false,
  });

  factory ChatModel.fromSnapshot(DocumentSnapshot snap) {
    var map = snap.data() as Map<String, dynamic>;
    return ChatModel(
      id: snap.id,
      roomId: map['roomId'] ?? '',
      senderId: map['senderId'] ?? '',
      content: map['content'] ?? '',
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      type: _stringToType(map['type']),
      isRead: map['isRead'] ?? false,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'roomId': roomId,
      'senderId': senderId,
      'content': content,
      'timestamp': Timestamp.fromDate(timestamp),
      'type': _typeToString(type),
      'isRead': isRead,
    };
  }

  static MessageType _stringToType(String? type) {
    switch (type) {
      case 'image':
        return MessageType.image;
      case 'video':
        return MessageType.video;
      default:
        return MessageType.text;
    }
  }

  static String _typeToString(MessageType type) {
    return type.name;
  }
}
