import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_app/core/db/database_helper.dart';
import 'package:expense_app/features/auth/model/models/model.dart';
import 'package:expense_app/features/auth/model/service/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  DatabaseHelper databaseHelper = DatabaseHelper.instance;
  AuthBloc() : super(const AuthState()) {
    on<RegisterUser>(_register);
    on<AuthEvent>(_login);
    on<AuthEvent>(_logout);
  }

  Future<void> _register(RegisterUser event, Emitter<AuthState> emit) async {
    await AuthService.insertUser(
        await databaseHelper.database,
        User(
            name: event.name,
            phoneno: event.phoneno,
            email: event.email,
            password: event.password));
  }

  Future<void> _login(AuthEvent event, Emitter<AuthState> emit) async {}
  Future<void> _logout(AuthEvent event, Emitter<AuthState> emit) async {}
}
