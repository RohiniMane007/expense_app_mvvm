part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final String result;
  final String username;
  const AuthState({this.result = 'loading', this.username = ""});

  AuthState copyWith({required String? result, String? username}) {
    return AuthState(
        result: result ?? this.result, username: username ?? this.username);
  }

  @override
  List<Object> get props => [result];
}

// final class AuthInitial extends AuthState {}
