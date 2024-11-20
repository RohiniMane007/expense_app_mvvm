part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final String result;
  const AuthState({this.result = 'loading'});

  AuthState copyWith({required String? result}) {
    return AuthState(result: result ?? this.result);
  }

  @override
  List<Object> get props => [result];
}

// final class AuthInitial extends AuthState {}
