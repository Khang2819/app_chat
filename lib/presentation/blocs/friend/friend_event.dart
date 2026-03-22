part of 'friend_bloc.dart';

sealed class FriendEvent extends Equatable {
  const FriendEvent();

  @override
  List<Object?> get props => [];
}

class SendFriendRequest extends FriendEvent {
  final String targetUserId;
  const SendFriendRequest(this.targetUserId);
  @override
  List<Object?> get props => [targetUserId];
}

class AcceptFriendRequest extends FriendEvent {
  final String requesterId;
  const AcceptFriendRequest(this.requesterId);
  @override
  List<Object?> get props => [];
}

class DeleteFriendRequest extends FriendEvent {
  final String requesterId;
  const DeleteFriendRequest(this.requesterId);
  @override
  List<Object?> get props => [requesterId];
}

class LoadIncomingRequests extends FriendEvent {}
