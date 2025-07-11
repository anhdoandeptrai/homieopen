part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class LoginEvent extends AuthEvent {
  final LoginParams params;

  const LoginEvent({
    required this.params,
  });

  @override
  List<Object> get props => [params];
}

final class RegisterEvent extends AuthEvent {
  final RegisterParams params;

  const RegisterEvent({
    required this.params,
  });

  @override
  List<Object> get props => [params];
}
