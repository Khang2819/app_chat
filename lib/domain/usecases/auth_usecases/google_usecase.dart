import 'package:app_chat/domain/entities/user_entity.dart';

import '../../repositories/auth_repository.dart';

class GoogleUsecase {
  final AuthRepository repository;
  GoogleUsecase(this.repository);
  Future<UserEntity> call() async {
    return repository.signInWithGoogle();
  }
}
