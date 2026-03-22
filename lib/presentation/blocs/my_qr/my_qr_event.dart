part of 'my_qr_bloc.dart';

sealed class MyQrEvent extends Equatable {
  const MyQrEvent();

  @override
  List<Object> get props => [];
}

class LoadMyQrInfo extends MyQrEvent {}
