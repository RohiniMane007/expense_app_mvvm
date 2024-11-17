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
    on<LoginUser>(_login);
    on<LogoutUser>(_logout);
  }

  Future<void> _register(RegisterUser event, Emitter<AuthState> emit) async {
    int val = await AuthService.insertUser(
        await databaseHelper.database,
        User(
            name: event.name,
            phoneno: event.phoneno,
            email: event.email,
            username: event.email,
            password: event.password));
    print("================$val");
  }

  Future<void> _login(LoginUser event, Emitter<AuthState> emit) async {
    // await AuthService.deleteUser(await databaseHelper.database, 3);

    String result = await AuthService.getUser(await databaseHelper.database,
        {"username": event.username, "password": event.password});
    print(result);
  }

  Future<void> _logout(LogoutUser event, Emitter<AuthState> emit) async {}
}
