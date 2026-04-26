import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/auth_usecases/register_usecase.dart';

part 'register_cubit_state.dart';

class RegisterCubit extends Cubit<RegisterCubitState> {
  final RegisterUsecase registerUseCase;
  RegisterCubit({required this.registerUseCase})
    : super(RegisterCubitInitial());

  Future<void> register(String fullName, String email, String password) async {
    try {
      await registerUseCase(fullName, email, password);
      emit(RegisterSuccess(message: 'Đăng kí thành công'));
    } catch (e) {
      emit(RegisterFailure(error: e.toString()));
    }
  }
}
