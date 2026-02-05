import 'package:app_chat/domain/repositories/user_repository.dart';

import '../../domain/entities/user_entity.dart';
import '../datasources/user_remote_datasource.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDatasource remoteDataSource;
  UserRepositoryImpl(this.remoteDataSource);
  @override
  Stream<List<UserEntity>> getAllFrends() {
    return remoteDataSource.getAllFrends();
  }

  @override
  Future<void> acceptFriendRequest(String userId) {
    return remoteDataSource.acceptFriendRequest(userId);
  }

  @override
  Future<void> deleteFriendRequest(String userId) {
    return remoteDataSource.deleteFriendRequest(userId);
  }

  @override
  Stream<List<UserEntity>> getIncomingRequests() {
    return remoteDataSource.getIncomingRequests();
  }

  @override
  Future<void> sendFriendRequest(String userId) {
    return remoteDataSource.sendFriendRequest(userId);
  }
}
