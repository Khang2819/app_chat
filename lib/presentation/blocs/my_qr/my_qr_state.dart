part of 'my_qr_bloc.dart';

sealed class MyQrState extends Equatable {
  const MyQrState();

  @override
  List<Object> get props => [];
}

final class MyQrInitial extends MyQrState {}

final class MyQrLoading extends MyQrState {}

final class MyQrLoaded extends MyQrState {
  final UserEntity user;
  const MyQrLoaded(this.user);
  @override
  List<Object> get props => [user];
}

final class MyQrError extends MyQrState {
  final String message;
  const MyQrError(this.message);
  @override
  List<Object> get props => [message];
}
