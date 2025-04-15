import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/domain/entities/users.dart';


class News extends Equatable {

  const News( {
    required this.id,
    required this.category,
    required this.title,
    required this.source,
    required this.time,
    required this.imageUrl,
    required this.srcImage,
    required this.context,
    required this.comment,
    required this.like,
    required this.saved,
    required this.users,
    required this.userLikeId,

  });


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
  final Users? users;
  final List<String> userLikeId;



  @override
  List<Object?> get props => [id, category, title, source,time,imageUrl,srcImage,context,comment,like,saved,users];
}