part of 'register_cubit.dart';

sealed class RegisterCubitState extends Equatable {
  const RegisterCubitState();

  @override
  List<Object> get props => [];
}

final class RegisterCubitInitial extends RegisterCubitState {}

final class RegisterLoading extends RegisterCubitState {}

final class RegisterSuccess extends RegisterCubitState {
  final String message;
  const RegisterSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

final class RegisterFailure extends RegisterCubitState {
  final String error;
  const RegisterFailure({required this.error});

  @override
  List<Object> get props => [error];
}
