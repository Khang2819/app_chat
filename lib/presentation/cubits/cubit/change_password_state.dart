import 'package:equatable/equatable.dart';

enum ChangePassWord { initial, loading, success, failure }

class ChangePasswordState extends Equatable {
  final String password;
  final bool hasMinLength;
  final bool hasUpperLower;
  final bool hasNumber;
  final ChangePassWord status;
  final String? error;
  const ChangePasswordState({
    this.password = '',
    this.hasMinLength = false,
    this.hasUpperLower = false,
    this.hasNumber = false,
    this.status = ChangePassWord.initial,
    this.error,
  });
  bool get isValid => hasMinLength && hasUpperLower && hasNumber;

  ChangePasswordState copyWith({
    String? password,
    bool? hasMinLength,
    bool? hasUpperLower,
    bool? hasNumber,
    ChangePassWord? status,
    String? error,
  }) {
    return ChangePasswordState(
      password: password ?? this.password,
      hasMinLength: hasMinLength ?? this.hasMinLength,
      hasUpperLower: hasUpperLower ?? this.hasUpperLower,
      hasNumber: hasNumber ?? this.hasNumber,
      status: status ?? this.status,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
    password,
    hasMinLength,
    hasUpperLower,
    hasNumber,
    status,
    error,
  ];
}
