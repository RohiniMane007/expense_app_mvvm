import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'appbar_state.dart';

class AppbarCubit extends Cubit<AppbarState> {
  AppbarCubit() : super(AppbarInitial());

  Future<void> logoutUser() async {}
}
