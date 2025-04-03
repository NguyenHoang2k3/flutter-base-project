
import 'package:flutter_clean_architecture/data/remote/models/respone/user.dart';
import 'package:flutter_clean_architecture/domain/entities/users.dart';

extension UsersTranslator on UserRespone {
  Users toEntity() {
    return Users(
      id: id ?? "",
      email: email ?? "",
      password: password ?? "",
      username: username ?? "",
    );
  }
}
