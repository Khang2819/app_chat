import 'dart:async';

import 'package:app_chat/presentation/blocs/home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/user_repository.dart';
import 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserRepository userRepository;
  StreamSubscription? _friendsSubscription;
  HomeBloc({required this.userRepository}) : super(HomeInitial()) {
    on<HomeLoad>((event, emit) async {
      emit(HomeLoading());
      await _friendsSubscription?.cancel();
      // await emit.forEach<List<UserEntity>>(
      //   userRepository.getAllFrends(),
      //   onData: (user) => HomeLoaded(onlineUsers: user, chats: user),
      //   onError: (error, _) => HomeError(error.toString()),
      // );
      _friendsSubscription = userRepository.getAllFrends().listen(
        (users) => add(HomeUpdated(users)),
        onError: (error) => add(HomeErrorOccurred(error.toString())),
      );
    });

    on<HomeUpdated>((event, emit) {
      emit(HomeLoaded(onlineUsers: event.users, chats: event.users));
    });

    on<HomeErrorOccurred>((event, emit) {
      emit(HomeError(event.error));
    });
  }

  @override
  Future<void> close() {
    _friendsSubscription?.cancel(); // Quan trọng: Hủy stream khi bloc bị đóng
    return super.close();
  }
}
