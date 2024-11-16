part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class RegisterUser extends AuthEvent {
  final String name, email, phoneno, password;
  const RegisterUser(
      {required this.name,
      required this.email,
      required this.phoneno,
      required this.password});
}

class LoginUser extends AuthEvent {
  final String email, password;
  const LoginUser({required this.email, required this.password});
}
