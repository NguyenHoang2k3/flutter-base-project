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
  final String? context;
  final int? comment;
  final int? like;
  final bool? saved;


  NewsRespone( {
    required this.id,
    required this.category,
    required this.title,
    required this.source,
    required this.time,
    required this.imageUrl,
    required this.srcImage,
    this.context, this.comment, this.like, this.saved,
  });

  factory NewsRespone.fromJson(Map<String, dynamic> json) => _$NewsResponeFromJson(json);
  Map<String, dynamic> toJson() => _$NewsResponeToJson(this);
}