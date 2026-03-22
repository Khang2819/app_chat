import '../entities/friend_request_entity.dart';
import '../repositories/friend_repository.dart';

class SendFriendRequestUsecase {
  final FriendRepository repository;
  SendFriendRequestUsecase(this.repository);
  Future<void> call(String targetUserId) {
    return repository.sendFriendRequest(targetUserId);
  }
}

class AcceptFriendRequestUsecase {
  final FriendRepository repository;
  AcceptFriendRequestUsecase(this.repository);
  Future<void> call(String requesterId) {
    return repository.acceptFriendRequest(requesterId);
  }
}

class GetIncomingRequestsUsecase {
  final FriendRepository repository;
  GetIncomingRequestsUsecase(this.repository);
  Stream<List<FriendRequestEntity>> call() {
    return repository.getIncomingRequests();
  }
}

class DeleteFriendRequestUsecase {
  final FriendRepository repository;
  DeleteFriendRequestUsecase(this.repository);
  Future<void> call(String requesterId) {
    return repository.deleteFriendRequest(requesterId);
  }
}
