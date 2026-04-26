import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'qr_scanner_cubit_state.dart';

class QrScannerCubit extends Cubit<QrScannerCubitState> {
  QrScannerCubit() : super(QrScannerCubitInitial());

  bool _torchOn = false;
  void toggleTorch() {
    _torchOn = !_torchOn;
    emit(QrTorchChanged(_torchOn));
  }

  void startScaning() {
    emit(QrScannerCubitScanning());
  }

  void onScaning(String uid, String currentUserId) {
    if (uid.isEmpty) {
      emit(QrScannerCubitError('QR không hợp lệ'));
      return;
    }
    if (currentUserId == uid) {
      emit(QrScannerCubitError('Đây là mã QR của bạn'));
      return;
    }
    emit(QrScannerCubitSuccess(uid));
  }

  void reset() {
    emit(QrScannerCubitInitial());
  }
}
