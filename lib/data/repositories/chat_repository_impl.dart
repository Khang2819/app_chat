import '../../domain/entities/chat_entity.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_remote_datasource.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDatasource remoteDataSource;
  ChatRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> sendChat(ChatEntity chat) => remoteDataSource.sendChat(chat);

  @override
  Stream<List<ChatEntity>> getChat(String roomId) =>
      remoteDataSource.getChat(roomId);

  @override
  Future<void> createGroup(List<String> members, String groupName) =>
      remoteDataSource.createGroup(members, groupName);

  @override
  Future<void> setTyping(String roomId, String userId, bool isTyping) =>
      remoteDataSource.setTyping(roomId, userId, isTyping);
}
