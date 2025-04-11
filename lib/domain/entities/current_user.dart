import 'package:json_annotation/json_annotation.dart';

part 'current_user.g.dart';

@JsonSerializable()
class CurrentUser {
  CurrentUser({
    required this.id,
    this.fullName,
    this.imagePath,
    required this.username,
    required this.email,
    required this.phoneNumber,
    this.bio,
    this.website,
  });

  final String id;
  final String? imagePath;
  final String? fullName;
  final String username;
  final String email;
  final String phoneNumber;
  final String? bio;
  final String? website;

  factory CurrentUser.fromJson(Map<String, dynamic> json) =>
      _$CurrentUserFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentUserToJson(this);
}