import '../repositories/user_repository.dart';

class UserUsecases {
  final UserRepository repository;
  UserUsecases(this.repository);
  Future<void> call(String targetUserId) {
    return repository.getUserById(targetUserId);
  }
}
