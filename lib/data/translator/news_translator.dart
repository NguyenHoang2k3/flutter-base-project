import 'package:flutter_clean_architecture/data/remote/models/respone/news.dart';
import 'package:flutter_clean_architecture/domain/entities/news.dart';

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
    );
  }
}
