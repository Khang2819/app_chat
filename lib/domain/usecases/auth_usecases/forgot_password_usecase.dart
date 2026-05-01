import '../../repositories/auth_repository.dart';

class ForgotpasswordUsecase {
  final AuthRepository repository;
  ForgotpasswordUsecase(this.repository);
  Future<void> call(String email) {
    return repository.forgotPassword(email);
  }
}
