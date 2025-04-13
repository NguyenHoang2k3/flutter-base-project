import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'users.g.dart';
@JsonSerializable()
class Users extends Equatable {
  Users(
      this.id,
      this.username,
      this.email,
      this.imageUrl,
      this.password,
      this.followers,
      this.isFollow,
      );

  final String? id;
  final String? username;
  final String? email;
  final String? imageUrl;
  final String? password;
  final int? followers;
  bool isFollow;

  Users copyWith({
    String? id,
    String? username,
    String? email,
    String? imageUrl,
    String? password,
    int? followers,
    bool? isFollow,
  }) {
    return Users(
      id ?? this.id,
      username ?? this.username,
      email ?? this.email,
      imageUrl ?? this.imageUrl,
      password ?? this.password,
      followers ?? this.followers,
      isFollow ?? this.isFollow,
    );
  }

  @override
  List<Object?> get props => [
    id,
    username,
    email,
    password,
    imageUrl,
    followers,
    isFollow,
  ];
  factory Users.fromJson(Map<String, dynamic> json) =>
      _$UsersFromJson(json);

  Map<String, dynamic> toJson() => _$UsersToJson(this);

}
