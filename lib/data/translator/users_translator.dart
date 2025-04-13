
import 'package:flutter_clean_architecture/data/remote/models/respone/user.dart';
import 'package:flutter_clean_architecture/domain/entities/users.dart';

extension UsersTranslator on UserRespone {
  Users toEntity() {
    return Users(
      id ?? '',
      username ?? '',
      email ?? '',
      imageUrl ?? '',
      password ?? '',
      int.tryParse(followers ?? '') ?? 0,
      isFollow == 'true' ? true : false,
    );
  }
}
