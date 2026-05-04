import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/auth_usecases/forgot_password_usecase.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotpasswordUsecase forgotpasswordUsecase;
  ForgotPasswordCubit({required this.forgotpasswordUsecase})
    : super(ForgotPasswordStateInitial());
  Future<void> sendResetEmail(String email) async {
    emit(ForgotPasswordLoading());
    try {
      await forgotpasswordUsecase(email);
    } catch (e) {
      emit(ForgotPasswordFailure(e.toString()));
    }
  }
}
