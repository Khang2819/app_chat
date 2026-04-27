import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/auth_usecases/login_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUsecase loginUseCase;
  LoginCubit({required this.loginUseCase}) : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    try {
      await loginUseCase(email, password);
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
    }
  }

  Future<void> loginWithGoogle() async {
    emit(LoginLoading());
    try {
      await loginUseCase.repository.signInWithGoogle();
      emit(const LoginSuces(message: 'Đăng nhập Google thành công'));
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
    }
  }
}
