import 'package:app_chat/domain/repositories/user_entity.dart';

abstract class UserRepository {
  Stream<List<UserEntity>> getAllFrends();
  Future<UserEntity> getUserById(String userId);
  Future<List<UserEntity>> searchUsers(String query);
  Future<List<String>> getSearchHistory(String userId);
  Future<void> saveSearchQuery(String userId, String query);
  Future<void> clearSearchHistory(String userId);
}
