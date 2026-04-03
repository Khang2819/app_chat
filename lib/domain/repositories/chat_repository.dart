import 'package:app_chat/domain/entities/chat_entity.dart';

abstract class ChatRepository {
  Future<void> sendChat(ChatEntity chat);
  Stream<List<ChatEntity>> getChat(String roomId);
  Future<void> createGroup(List<String> members, String groupName);
  Future<void> setTyping(String roomId, String userId, bool isTyping);
}
