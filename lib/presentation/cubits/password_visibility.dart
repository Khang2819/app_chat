import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordVisibility extends Cubit<bool> {
  PasswordVisibility() : super(true);
  void toggle() {
    emit(!state);
  }
}
