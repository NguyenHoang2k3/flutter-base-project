import 'package:json_annotation/json_annotation.dart';
part 'news.g.dart';
@JsonSerializable()
class NewsRespone {
  final String? id;
  final String? category;
  final String? title;
  final String? source;
  final String? time;
  final String? imageUrl;
  final String? srcImage;

  NewsRespone({
    required this.id,
    required this.category,
    required this.title,
    required this.source,
    required this.time,
    required this.imageUrl,
    required this.srcImage,
  });

  factory NewsRespone.fromJson(Map<String, dynamic> json) => _$NewsResponeFromJson(json);
  Map<String, dynamic> toJson() => _$NewsResponeToJson(this);
}