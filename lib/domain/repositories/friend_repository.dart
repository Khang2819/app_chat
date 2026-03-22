import '../entities/friend_request_entity.dart';

abstract class FriendRepository {
  Future<void> sendFriendRequest(String targetUserId);
  Future<void> acceptFriendRequest(String requesterId);
  Future<void> deleteFriendRequest(String requesterId);
  Stream<List<FriendRequestEntity>> getIncomingRequests();
}
