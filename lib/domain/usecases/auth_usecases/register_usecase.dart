import 'package:app_chat/domain/repositories/user_entity.dart';
import 'package:app_chat/domain/repositories/auth_repository.dart';

class RegisterUsecase {
  final AuthRepository repository;
  RegisterUsecase(this.repository);
  Future<UserEntity> call(String fullName, String email, String password) {
    return repository.register(fullName, email, password);
  }
}
