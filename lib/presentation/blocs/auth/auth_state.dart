import 'package:equatable/equatable.dart';

sealed class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuces extends AuthState {
  final String message;
  const AuthSuces({required this.message});
  @override
  List<Object> get props => [message];
}

final class AuthFailure extends AuthState {
  final String error;
  const AuthFailure({required this.error});
  @override
  List<Object?> get props => [error];
}
