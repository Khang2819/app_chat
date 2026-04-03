import 'package:app_chat/domain/repositories/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> login(String email, String password);
  Future<UserEntity> register(String fullName, String email, String password);
  Future<UserEntity> forgotPassword(String email);
  Future<void> logout();
  Stream<UserEntity?> get user;
}
