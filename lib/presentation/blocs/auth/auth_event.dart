import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class LoginWithEmailEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginWithEmailEvent({required this.email, required this.password});
  @override
  List<Object?> get props => [email, password];
}

class RegisterWithEmailEvent extends AuthEvent {
  final String fullName;
  final String email;
  final String password;
  final String confirmPassword;

  const RegisterWithEmailEvent({
    required this.fullName,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object> get props => [fullName, email, password, confirmPassword];
}

class ForgotPasswordEvent extends AuthEvent {
  final String email;

  const ForgotPasswordEvent({required this.email});

  @override
  List<Object> get props => [email];
}

class UpdatePassWord extends AuthEvent {}

class LoginWithGoogle extends AuthEvent {}

class LoginWithApple extends AuthEvent {}

class Logout extends AuthEvent {}
