import 'package:equatable/equatable.dart';


class Users extends Equatable {

  const Users({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
  });


  final String? id;
  final String? username;
  final String? email;
  final String? password;



  @override
  List<Object?> get props => [id, username, email, password];
}