import 'package:app_chat/presentation/blocs/home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/user_entity.dart';
import '../../../domain/repositories/user_repository.dart';
import 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserRepository userRepository;
  HomeBloc({required this.userRepository}) : super(HomeInitial()) {
    on<HomeLoad>((event, emit) async {
      emit(HomeLoading());
      await emit.forEach<List<UserEntity>>(
        userRepository.getAllFrends(),
        onData: (user) => HomeLoaded(onlineUsers: user, chats: user),
        onError: (error, _) => HomeError(error.toString()),
      );
    });
  }
}
