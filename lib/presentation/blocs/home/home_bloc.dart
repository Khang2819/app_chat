import 'dart:async';

import 'package:app_chat/presentation/blocs/home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/user_repository.dart';
import 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserRepository userRepository;
  StreamSubscription? _friendsSubscription;

  HomeBloc({required this.userRepository}) : super(HomeInitial()) {
    on<HomeLoad>(_onHomeLoad);
    on<HomeUpdated>(_onHomeUpdated);
    on<HomeErrorOccurred>(_onHomeError);
    on<HomeReset>(_onHomeReset);
  }

  Future<void> _onHomeLoad(HomeLoad event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    await _friendsSubscription?.cancel();
    _friendsSubscription = null;

    _friendsSubscription = userRepository.getAllFrends().listen(
      (users) {
        if (!isClosed) add(HomeUpdated(users));
      },
      onError: (error) {
        if (!isClosed) add(HomeErrorOccurred(error.toString()));
      },
    );
  }

  void _onHomeUpdated(HomeUpdated event, Emitter<HomeState> emit) {
    final onlineUsers = event.users.where((user) => user.isOnline).toList();
    emit(HomeLoaded(onlineUsers: onlineUsers, chats: event.users));
  }

  void _onHomeError(HomeErrorOccurred event, Emitter<HomeState> emit) {
    emit(HomeError(event.error));
  }

  Future<void> _onHomeReset(HomeReset event, Emitter<HomeState> emit) async {
    await _friendsSubscription?.cancel();
    _friendsSubscription = null;
    emit(HomeInitial());
  }

  @override
  Future<void> close() async {
    await _friendsSubscription?.cancel();
    _friendsSubscription = null;
    return super.close();
  }
}
