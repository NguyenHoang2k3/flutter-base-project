import 'package:json_annotation/json_annotation.dart';
part 'topics.g.dart';
@JsonSerializable()
class Topics {
  final String id;
  final String imageUrl;
  final String   name;
  final String context;
  bool save;


  Topics({
    required this.id,
    required this.name,
    required this.context,
    this.save = false,
    required this.imageUrl,
  });



  factory Topics.fromJson(Map<String, dynamic> json) => _$TopicsFromJson(json);
  Map<String, dynamic> toJson() => _$TopicsToJson(this);
}
extension TopicsCopyWith on Topics {
  Topics copyWith({
    String? id,
    String? name,
    String? context,
    bool? save,
    String? imageUrl,
  }) {
    return Topics(
      id: id ?? this.id,
      name: name ?? this.name,
      context: context ?? this.context,
      save: save ?? this.save,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
