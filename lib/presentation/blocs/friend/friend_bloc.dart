import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/friend_request_entity.dart';
import '../../../domain/usecases/friend_usecases.dart';

part 'friend_event.dart';
part 'friend_state.dart';

class FriendBloc extends Bloc<FriendEvent, FriendState> {
  StreamSubscription? _requestsSubscription;
  final SendFriendRequestUsecase sendFriendRequestUsecase;
  final AcceptFriendRequestUsecase acceptFriendRequestUsecase;
  final DeleteFriendRequestUsecase deleteFriendRequestUsecase;
  final GetIncomingRequestsUsecase getIncomingRequestsUsecase;
  FriendBloc({
    required this.sendFriendRequestUsecase,
    required this.acceptFriendRequestUsecase,
    required this.deleteFriendRequestUsecase,
    required this.getIncomingRequestsUsecase,
  }) : super(FriendInitial()) {
    on<SendFriendRequest>(_sendFriendRequest);
    on<AcceptFriendRequest>(_acceptFriendRequest);
    on<DeleteFriendRequest>(_onDeleteFriendRequest);
    on<LoadIncomingRequests>(_onLoadIncomingRequests);
  }

  FutureOr<void> _sendFriendRequest(
    SendFriendRequest event,
    Emitter<FriendState> emit,
  ) async {
    try {
      await sendFriendRequestUsecase(event.targetUserId);
      emit(FriendActionSuccess('Đã gửi lời mời kết bạn thành công'));
    } catch (e) {
      emit(FriendError(e.toString()));
    }
  }

  FutureOr<void> _acceptFriendRequest(
    AcceptFriendRequest event,
    Emitter<FriendState> emit,
  ) async {
    try {
      await acceptFriendRequestUsecase(event.requesterId);
      emit(FriendActionSuccess('Đã chấp nhận lời mời kết bạn'));
    } catch (e) {
      emit(FriendError(e.toString()));
    }
  }

  FutureOr<void> _onDeleteFriendRequest(
    DeleteFriendRequest event,
    Emitter<FriendState> emit,
  ) async {
    emit(FriendLoading());
    try {
      await deleteFriendRequestUsecase(event.requesterId);
      emit(FriendActionSuccess('Đã xóa yêu cầu kết bạn'));
    } catch (e) {
      emit(FriendError(e.toString()));
    }
  }

  FutureOr<void> _onLoadIncomingRequests(
    LoadIncomingRequests event,
    Emitter<FriendState> emit,
  ) async {
    // await emit.forEach<List<FriendRequestEntity>>(
    //   getIncomingRequestsUsecase(),
    //   onData: (requests) => FriendRequestLoaded(requests),
    //   onError: (error, _) => FriendError(error.toString()),
    // );
    await _requestsSubscription?.cancel();
    await emit.forEach<List<FriendRequestEntity>>(
      getIncomingRequestsUsecase(),
      onData: (requests) => FriendRequestLoaded(requests),
      onError: (error, _) => FriendError(error.toString()),
    );
  }

  @override
  Future<void> close() {
    _requestsSubscription?.cancel();
    return super.close();
  }
}
