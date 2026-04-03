import 'dart:async';

import 'package:app_chat/domain/entities/chat_entity.dart';
import 'package:app_chat/domain/usecases/chat_usecases.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetChatUsecase getChatUsecase;
  final SendChatUsecase sendChatUsecase;
  StreamSubscription? _streamSubscription;
  ChatBloc({required this.getChatUsecase, required this.sendChatUsecase})
    : super(ChatInitial()) {
    on<LoadMessages>(_onLoadMessages);
    on<SendMessage>(_onSendMessage);
    on<MessagesUpdated>(_onMessagesUpdated);
    on<SetTyping>(_onSetTyping);
  }

  FutureOr<void> _onLoadMessages(
    LoadMessages event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoading());
    try {
      await _streamSubscription?.cancel();
      _streamSubscription = getChatUsecase(event.roomId).listen(
        (messages) => add(MessagesUpdated(messages)),
        onError: (error) => add(MessagesError(error.toString())),
      );
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  void _onMessagesUpdated(MessagesUpdated event, Emitter<ChatState> emit) {
    emit(ChatLoade(event.messages));
  }

  FutureOr<void> _onSendMessage(
    SendMessage event,
    Emitter<ChatState> emit,
  ) async {
    try {
      await sendChatUsecase(event.chat);
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  FutureOr<void> _onSetTyping(SetTyping event, Emitter<ChatState> emit) async {
    try {
      await sendChatUsecase.repository.setTyping(
        event.roomId,
        event.userId,
        event.isTyping,
      );
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }
}
