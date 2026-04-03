part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class LoadMessages extends ChatEvent {
  final String roomId;
  const LoadMessages(this.roomId);
  @override
  List<Object> get props => [roomId];
}

class MessagesUpdated extends ChatEvent {
  final List<ChatEntity> messages;

  const MessagesUpdated(this.messages);

  @override
  List<Object> get props => [messages];
}

class SendMessage extends ChatEvent {
  final ChatEntity chat;
  const SendMessage(this.chat);
  @override
  List<Object> get props => [chat];
}

class SetTyping extends ChatEvent {
  final String roomId;
  final String userId;
  final bool isTyping;
  const SetTyping({
    required this.roomId,
    required this.userId,
    required this.isTyping,
  });
  @override
  List<Object> get props => [roomId, userId, isTyping];
}

class MessagesError extends ChatEvent {
  final String message;
  const MessagesError(this.message);
  @override
  List<Object> get props => [message];
}
