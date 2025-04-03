import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';
@JsonSerializable()
class UserRespone {
  final String? id;
  final String? email;
  final String? username;
  final String? password;

  UserRespone({
    required this.id,
    required this.email,
    required this.username,
    required this.password,
  });

  factory UserRespone.fromJson(Map<String, dynamic> json) => _$UserResponeFromJson(json);
  Map<String, dynamic> toJson() => _$UserResponeToJson(this);
}