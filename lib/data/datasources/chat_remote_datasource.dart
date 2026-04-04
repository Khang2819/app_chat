import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/chat_entity.dart';
import '../models/chat_model.dart';

abstract class ChatRemoteDatasource {
  Future<void> sendChat(ChatEntity chat);
  Stream<List<ChatEntity>> getChat(String roomId);
  Future<void> createGroup(List<String> members, String groupName);
  Future<void> setTyping(String roomId, String userId, bool isTyping);
}

class ChatRemoteDatasourceImpl implements ChatRemoteDatasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> sendChat(ChatEntity chat) async {
    final message = _firestore.collection('chat_room').doc(chat.roomId);

    await message.collection('messages').add({
      'id': message.id,
      'roomId': chat.roomId,
      'senderId': chat.senderId,
      'content': chat.content,
      'timestamp': FieldValue.serverTimestamp(),
      'type': chat.type.name,
      'isRead': false,
    });
    await message.set({
      'lastMessage': chat.content,
      'lastTimestamp': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  @override
  Stream<List<ChatEntity>> getChat(String roomId) {
    return _firestore
        .collection('chat_rooms')
        .doc(roomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (snap) =>
              snap.docs.map((doc) => ChatModel.fromSnapshot(doc)).toList(),
        );
  }

  @override
  Future<void> createGroup(List<String> members, String groupName) async {
    await _firestore.collection('chat_room').add({
      'name': groupName,
      'members': members,
      'isGroup': true,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> setTyping(String roomId, String userId, bool isTyping) async {
    final roomRef = _firestore.collection('chat_room').doc(roomId);

    if (isTyping) {
      await roomRef.set({
        'typing': {userId: true},
      }, SetOptions(merge: true));
    } else {
      await roomRef.update({'typing.$userId': FieldValue.delete()});
    }
  }
}
