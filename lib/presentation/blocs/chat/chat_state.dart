part of 'chat_bloc.dart';

sealed class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

final class ChatInitial extends ChatState {}

final class ChatLoading extends ChatState {}

final class ChatLoade extends ChatState {
  final List<ChatEntity> chats;
  const ChatLoade(this.chats);
  @override
  List<Object> get props => [chats];
}

final class ChatError extends ChatState {
  final String error;
  const ChatError(this.error);
  @override
  List<Object> get props => [error];
}
