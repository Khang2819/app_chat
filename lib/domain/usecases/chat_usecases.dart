import '../entities/chat_entity.dart';
import '../repositories/chat_repository.dart';

class SendChatUsecase {
  final ChatRepository repository;
  SendChatUsecase(this.repository);
  Future<void> call(ChatEntity chat) => repository.sendChat(chat);
}

class GetChatUsecase {
  final ChatRepository repository;
  GetChatUsecase(this.repository);
  Stream<List<ChatEntity>> call(String roomId) => repository.getChat(roomId);
}
