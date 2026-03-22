import '../../domain/entities/friend_request_entity.dart';
import '../../domain/repositories/friend_repository.dart';
import '../datasources/friend_remote_datasource.dart';

class FriendRepositoryImpl extends FriendRepository {
  final FriendRemoteDatasource remoteDataSource;
  FriendRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> acceptFriendRequest(String userId) {
    return remoteDataSource.acceptFriendRequest(userId);
  }

  @override
  Future<void> deleteFriendRequest(String userId) {
    return remoteDataSource.deleteFriendRequest(userId);
  }

  @override
  Stream<List<FriendRequestEntity>> getIncomingRequests() {
    return remoteDataSource.getIncomingRequests();
  }

  @override
  Future<void> sendFriendRequest(String userId) {
    return remoteDataSource.sendFriendRequest(userId);
  }
}
