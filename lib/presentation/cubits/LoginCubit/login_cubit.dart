import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/auth_usecases/google_usecase.dart';
import '../../../domain/usecases/auth_usecases/login_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUsecase loginUseCase;
  final GoogleUsecase googleUsecase;
  LoginCubit({required this.loginUseCase, required this.googleUsecase})
    : super(LoginInitial());

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
      await googleUsecase();
      emit(const LoginSuces(message: 'Đăng nhập Google thành công'));
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
    }
  }
}
