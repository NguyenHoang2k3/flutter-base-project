import 'package:equatable/equatable.dart';


class Users extends Equatable {

  Users({
    required this.id,
    required this.username,
    required this.email,
    required this.imageUrl,
    required this.password,
    this.isFollow = false,
  });


  final String? id;
  final String username;
  final String? email;
  final String imageUrl;
  final String? password;
  bool isFollow;

  Users copyWith({
    final String? id,
    String? username,
    final String? email,
    String? imageUrl,
    final String? password,
    bool? isFollow,
  }) {
    return Users(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
      password: password ?? this.password,
      isFollow: isFollow ?? this.isFollow,
    );
  }



  @override
  List<Object?> get props => [id, username, email, password,imageUrl];
}