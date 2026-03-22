import 'package:equatable/equatable.dart';

import '../../../domain/entities/user_entity.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object> get props => [];
}

class HomeLoad extends HomeEvent {}

class HomeUpdated extends HomeEvent {
  final List<UserEntity> users;
  const HomeUpdated(this.users);
  @override
  List<Object> get props => [users];
}

class HomeErrorOccurred extends HomeEvent {
  final String error;
  const HomeErrorOccurred(this.error);
  @override
  List<Object> get props => [error];
}
