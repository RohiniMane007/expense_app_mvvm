import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>(_register);
    on<AuthEvent>(_login);
    on<AuthEvent>(_logout);
  }

  Future<void> _register(AuthEvent event, Emitter<AuthState> emit) async {}
  Future<void> _login(AuthEvent event, Emitter<AuthState> emit) async {}
  Future<void> _logout(AuthEvent event, Emitter<AuthState> emit) async {}
}
