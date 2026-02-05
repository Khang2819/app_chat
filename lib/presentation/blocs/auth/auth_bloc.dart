import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/auth_usecases/login_usecase.dart';
import '../../../domain/usecases/auth_usecases/logout_usecase.dart';
import '../../../domain/usecases/auth_usecases/register_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase loginUseCase;
  final RegisterUsecase registerUsecase;
  final LogoutUsecase logoutUsecase;
  AuthBloc({
    required this.loginUseCase,
    required this.registerUsecase,
    required this.logoutUsecase,
  }) : super(AuthInitial()) {
    // đăng nhập bằng email
    on<LoginWithEmailEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await loginUseCase(event.email, event.password);
        emit(AuthSuces(message: 'Đăng nhập thành công'));
      } catch (e) {
        emit(AuthInitial());
      }
    });
    // đăng ký bằng email
    on<RegisterWithEmailEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await registerUsecase(event.fullName, event.email, event.password);
        emit(const AuthSuces(message: 'Đăng ký thành công'));
      } catch (e) {
        emit(AuthFailure(error: e.toString()));
      }
    });

    // đăng xuất
    on<Logout>((event, emit) async {
      emit(AuthLoading());
      try {
        await logoutUsecase();
        emit(const AuthSuces(message: 'Đăng xuất thành công'));
      } catch (e) {
        emit(AuthFailure(error: e.toString()));
      }
    });
  }
}
