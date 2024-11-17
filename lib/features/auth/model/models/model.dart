import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int? id;
  final String? name;
  // final String? lastname;
  final String? phoneno;
  final String? email;
  final String? username;
  final String? password;

  const User({
    this.id,
    required this.name,
    // required this.lastname,
    required this.phoneno,
    required this.email,
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [id, name, phoneno, email, password];

  factory User.fromJson(Map<String, Object?> json) => User(
        // id: json["id"] as int,
        name: json["name"] as String,
        // lastname: json["lastname"].toString(),
        phoneno: json["phoneno"] as String,
        email: json["email"] as String,
        username: json["email"] as String,
        password: json["password"] as String,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['id'] = id;
    data['name'] = name;
    // data['lastname'] = lastname;
    data['phoneno'] = phoneno;
    data['email'] = email;
    data['username'] = email;
    data['password'] = password;

    return data;
  }
}
