import '../../domain/repositories/user_entity.dart';
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
  Future<UserEntity> forgotPassword(String email) async {
    throw UnimplementedError();
  }

  @override
  Future<void> logout() async {
    return await remoteDataSource.logout();
  }
}
