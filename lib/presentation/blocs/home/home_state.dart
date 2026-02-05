import 'package:equatable/equatable.dart';

import '../../../domain/entities/user_entity.dart';

sealed class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<UserEntity> onlineUsers;
  final List<UserEntity> chats;
  const HomeLoaded({this.onlineUsers = const [], this.chats = const []});
  @override
  List<Object> get props => [];
}

class HomeError extends HomeState {
  final String message;
  const HomeError(this.message);
  @override
  List<Object> get props => [];
}
