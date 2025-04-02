import 'package:equatable/equatable.dart';

class NewsCategory extends Equatable {
  const NewsCategory({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  @override
  List<Object?> get props => [id, name];
}