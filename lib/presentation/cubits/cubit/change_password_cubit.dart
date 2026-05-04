import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/auth_usecases/change_password_usecase.dart';
import 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePasswordUsecase changePasswordUsecase;
  ChangePasswordCubit({required this.changePasswordUsecase})
    : super(ChangePasswordState());

  Future<void> changePassword(String oldPassword, String newPassword) async {
    if (!state.isValid) {
      emit(
        state.copyWith(
          status: ChangePassWord.failure,
          error: "Mật khẩu chưa đủ điều kiện",
        ),
      );
      return;
    }

    emit(state.copyWith(status: ChangePassWord.loading));
    try {
      final email = FirebaseAuth.instance.currentUser?.email;
      await changePasswordUsecase(email!, oldPassword, newPassword);
      emit(state.copyWith(status: ChangePassWord.success));
    } catch (e) {
      emit(state.copyWith(status: ChangePassWord.failure, error: e.toString()));
    }
  }

  void onPasswordChanged(String password) {
    emit(
      state.copyWith(
        password: password,
        hasMinLength: password.length >= 8,
        hasUpperLower:
            password.contains(RegExp(r'[A-Z]')) &&
            password.contains(RegExp(r'[a-z]')),
        hasNumber: password.contains(RegExp(r'[0-9]')),
      ),
    );
  }
}
