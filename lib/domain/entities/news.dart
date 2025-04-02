import 'package:equatable/equatable.dart';


class News extends Equatable {

  const News({
    required this.id,
    required this.category,
    required this.title,
    required this.source,
    required this.time,
    required this.imageUrl,
    required this.srcImage,
  });


  final String id;
  final String category;
  final String title;
  final String source;
  final String time;
  final String imageUrl;
  final String srcImage;



  @override
  List<Object?> get props => [id, category, title, source,time,imageUrl,srcImage];
}