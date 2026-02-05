import 'package:app_chat/domain/entities/user_entity.dart';

abstract class UserRepository {
  Stream<List<UserEntity>> getAllFrends();
  Future<void> sendFriendRequest(String targetUserId);
  Future<void> acceptFriendRequest(String requesterId);
  Future<void> deleteFriendRequest(String requesterId);
  Stream<List<UserEntity>> getIncomingRequests();
}
