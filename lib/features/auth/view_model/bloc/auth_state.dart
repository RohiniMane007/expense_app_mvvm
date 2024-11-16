part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState({this.result = ""});
  final String result;

  @override
  List<Object> get props => [result];
}

// final class AuthInitial extends AuthState {}
