import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'appbar_state.dart';

class AppbarCubit extends Cubit<AppbarState> {
  AppbarCubit() : super(const AppbarState());

  Future<void> loginInfo() async {
    AndroidOptions getAndroidOptions() => const AndroidOptions(
          encryptedSharedPreferences: true,
        );
    final storage = FlutterSecureStorage(aOptions: getAndroidOptions());

    Map data = await storage.readAll();
    print(data);
  }
}
