import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int? id;
  final String? firstname;
  final String? lastname;
  final String? phoneno;
  final String? email;
  final String? username;
  final String? password;

  const User({
    this.id,
    required this.firstname,
    required this.lastname,
    required this.phoneno,
    required this.email,
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props =>
      [id, firstname, lastname, phoneno, email, username, password];

  factory User.fromJson(Map<String, Object?> json) => User(
        id: json["id"] as int,
        firstname: json["firstname"] as String,
        lastname: json["lastname"].toString(),
        phoneno: json["phoneno"] as String,
        email: json["email"] as String,
        username: json["username"] as String,
        password: json["password"] as String,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['id'] = id;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['phoneno'] = phoneno;
    data['email'] = email;
    data['username'] = username;
    data['password'] = password;

    return data;
  }
}
