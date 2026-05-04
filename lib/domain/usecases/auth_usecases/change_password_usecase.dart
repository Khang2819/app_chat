import '../../repositories/auth_repository.dart';

class ChangePasswordUsecase {
  final AuthRepository repository;
  ChangePasswordUsecase(this.repository);

  Future<void> call(
    String email,
    String oldPassword,
    String newPassword,
  ) async {
    return repository.changePassword(email, oldPassword, newPassword);
  }
}
