import 'dart:async';

import 'package:app_chat/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/user_repository.dart';

part 'my_qr_event.dart';
part 'my_qr_state.dart';

class MyQrBloc extends Bloc<MyQrEvent, MyQrState> {
  final UserRepository userRepository;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  MyQrBloc({required this.userRepository}) : super(MyQrInitial()) {
    on<LoadMyQrInfo>(_onLoadMyQrInfo);
  }

  FutureOr<void> _onLoadMyQrInfo(
    LoadMyQrInfo event,
    Emitter<MyQrState> emit,
  ) async {
    emit(MyQrLoading());
    try {
      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        emit(const MyQrError("Người dùng chưa đăng nhập"));
        return;
      }
      final user = await userRepository.getUserById(currentUser.uid);
      emit(MyQrLoaded(user));
    } catch (e) {
      emit(MyQrError(e.toString()));
    }
  }
}
