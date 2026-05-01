import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Stream<UserEntity?> get user {
    return remoteDataSource.user;
  }

  @override
  Future<UserEntity> login(String email, String password) async {
    return await remoteDataSource.login(email, password);
  }

  @override
  Future<UserEntity> register(
    String fullName,
    String email,
    String password,
  ) async {
    return await remoteDataSource.register(fullName, email, password);
  }

  @override
  Future<UserEntity> signInWithGoogle() async {
    return await remoteDataSource.google();
  }

  @override
  Future<void> forgotPassword(String email) async {
    return await remoteDataSource.forgotPassword(email);
  }

  @override
  Future<void> logout() async {
    return await remoteDataSource.logout();
  }
}
