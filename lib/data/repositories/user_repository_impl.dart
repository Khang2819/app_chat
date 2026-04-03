import 'package:app_chat/domain/repositories/user_repository.dart';

import '../../domain/repositories/user_entity.dart';
import '../datasources/user_remote_datasource.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDatasource remoteDataSource;
  UserRepositoryImpl(this.remoteDataSource);
  @override
  Stream<List<UserEntity>> getAllFrends() {
    return remoteDataSource.getAllFrends();
  }

  @override
  Future<UserEntity> getUserById(String userId) {
    return remoteDataSource.getUserById(userId);
  }

  @override
  Future<List<UserEntity>> searchUsers(String query) {
    return remoteDataSource.searchUsers(query);
  }

  @override
  Future<void> clearSearchHistory(String userId) {
    return remoteDataSource.clearSearchHistory(userId);
  }

  @override
  Future<List<String>> getSearchHistory(String userId) {
    return remoteDataSource.getSearchHistory(userId);
  }

  @override
  Future<void> saveSearchQuery(String userId, String query) {
    return remoteDataSource.saveSearchQuery(userId, query);
  }
}
