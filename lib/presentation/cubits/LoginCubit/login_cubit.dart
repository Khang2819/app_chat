import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/auth_usecases/login_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUsecase loginUseCase;
  LoginCubit({required this.loginUseCase}) : super(LoginInitial());

  Future<void> login(String email, String password) async {
    try {
      await loginUseCase(email, password);
      emit(LoginSuces(message: 'Đăng nhập thành công'));
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
    }
  }
}
