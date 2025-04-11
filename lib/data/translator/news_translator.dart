import 'package:flutter_clean_architecture/data/remote/models/respone/news.dart';
import 'package:flutter_clean_architecture/domain/entities/news.dart';

import '../../domain/entities/users.dart';

extension NewsTranslator on NewsRespone {
  News toEntity() {
    return News(
      id: id ?? "",
      category: category ?? "",
      title: title ?? "",
      source: source ?? "",
      time: time?? "",
      imageUrl: imageUrl?? "",
      srcImage: srcImage?? "",
      comment: comment ?? 0,
      context: context ?? "",
      like: like ?? 0,
      saved: saved ?? false,
      users: Users(id: "0", username: "a", email: "a", imageUrl: "a", password: "a"),

    );
  }
}
