part of 'qr_scanner_cubit.dart';

sealed class QrScannerCubitState extends Equatable {
  const QrScannerCubitState();

  @override
  List<Object> get props => [];
}

final class QrScannerCubitInitial extends QrScannerCubitState {}

final class QrScannerCubitScanning extends QrScannerCubitState {}

final class QrScannerCubitSuccess extends QrScannerCubitState {
  final String uid;
  const QrScannerCubitSuccess(this.uid);

  @override
  List<Object> get props => [uid];
}

final class QrScannerCubitError extends QrScannerCubitState {
  final String error;
  const QrScannerCubitError(this.error);

  @override
  List<Object> get props => [error];
}

final class QrTorchChanged extends QrScannerCubitState {
  final bool isOn;
  const QrTorchChanged(this.isOn);

  @override
  List<Object> get props => [isOn];
}
