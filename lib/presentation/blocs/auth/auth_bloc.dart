import 'package:app_chat/domain/repositories/user_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/usecases/auth_usecases/logout_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LogoutUsecase logoutUsecase;
  final AuthRepository authRepository;
  AuthBloc({required this.logoutUsecase, required this.authRepository})
    : super(AuthInitial()) {
    on<AuthStatusChanged>((event, emit) async {
      await emit.forEach<UserEntity?>(
        authRepository.user,
        onData:
            (user) =>
                user != null ? AuthAuthenticated(user) : AuthUnauthenticated(),
        onError: (error, stackTrace) => AuthFailure(error: error.toString()),
      );
    });

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
