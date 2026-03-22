part of 'friend_bloc.dart';

sealed class FriendState extends Equatable {
  const FriendState();

  @override
  List<Object?> get props => [];
}

final class FriendInitial extends FriendState {}

final class FriendLoading extends FriendState {}

final class FriendRequestLoaded extends FriendState {
  final List<FriendRequestEntity> incomingRequests;
  const FriendRequestLoaded(this.incomingRequests);
  @override
  List<Object?> get props => [incomingRequests];
}

final class FriendActionSuccess extends FriendState {
  final String message;

  const FriendActionSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

final class FriendError extends FriendState {
  final String message;
  const FriendError(this.message);
  @override
  List<Object?> get props => [message];
}
