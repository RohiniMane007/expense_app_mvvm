part of 'appbar_cubit.dart';

class AppbarState extends Equatable {
  final String username;
  const AppbarState({this.username = ""});

  @override
  List<Object> get props => [username];
}
