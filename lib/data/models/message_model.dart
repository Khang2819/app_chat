import 'package:app_chat/domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  const MessageModel({
    required super.messagesId,
    required super.senderId,
    required super.receiverId,
    required super.content,
    required super.type,
    required super.createdAt,
    required super.isRead,
  });
  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      messagesId: map['messagesId'],
      senderId: map['senderId'],
      receiverId: map['receiverId'],
      content: map['content'],
      type: map['type'],
      createdAt: map['createdAt'],
      isRead: map['isRead'],
    );
  }

  Map<String, dynamic> toMap() => {};
}
